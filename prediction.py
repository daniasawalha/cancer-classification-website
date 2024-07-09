from flask import Flask, request, jsonify, render_template
from PIL import Image
import numpy as np
import tensorflow as tf
import tensorflow_hub as hub
import io
import pandas as pd
import base64
import mysql.connector
import os
from datetime import datetime

app = Flask(__name__)  # Initializing Flask app

# Load the model
custom_objects = {'KerasLayer': hub.KerasLayer}  # Custom objects required for loading the model

try:
    # Load the model within a custom object scope
    with tf.keras.utils.custom_object_scope(custom_objects):
        base_model = tf.keras.models.load_model('cancer.h5', custom_objects=custom_objects)  # Loading the model
    print("Model loaded successfully.")
except Exception as e:
    print("Error loading model:", str(e))  # Error handling for model loading

# Function to prepare image for model prediction
def prepare_image(image, target_size):
    if image.mode != "RGB":  # Ensure image is in RGB mode
        image = image.convert("RGB")
    image = image.resize(target_size)  # Resize image to target size
    image = np.array(image)  # Convert image to NumPy array
    image = image / 255.0  # Normalize pixel values
    image = np.expand_dims(image, axis=0)  # Add batch dimension
    return image

# Database connection
db_connection = mysql.connector.connect(
    host="127.0.0.1",
    user="root",
    password="Ibrahim@77",
    database="projct"
)

# Function to generate unique ID for images
def ID():
    import random
    random_n = random.randint(10000, 99999)  # Generate random number
    random_n_str = str(random_n)
    current_time = datetime.now()
    current_time_formatted = current_time.strftime("%Y")  # Get current year
    res = ''.join(random_n_str) + "_" + ''.join(current_time_formatted)  # Combine random number and year
    return res

import imghdr  # Importing imghdr for determining image type

# Function to decode base64 string to image and save it
def decode_base64_to_image(encoded_string, state, idimg):
    try:
        decoded_image = base64.b64decode(encoded_string)  # Decode base64 string
        image_type = imghdr.what(None, decoded_image)  # Determine image type
        if not image_type:
            raise ValueError("Unable to determine image type")
        
        output_dir = r"D:\deployment\prj\images"  # Set output directory
        os.makedirs(output_dir, exist_ok=True)  # Create directory if not exists
        
        output_file_path = os.path.join(output_dir, f"{idimg}.{image_type}")  # Create output file path
        with open(output_file_path, "wb") as output_file:
            output_file.write(decoded_image)  # Save decoded image
        
        print(f"Decoded image saved at: {output_file_path}")
        return output_file_path
    except Exception as e:
        print(f"Error: {e}")

# Function to insert image data into the database
def insert(imgb64, state):
    cursor = db_connection.cursor()  # Create database cursor
    idimg = float(ID())  # Generate unique ID
    insert_query = """
    INSERT INTO pictures (idpictures, states, directory)
    VALUES (%s, %s, %s);
    """
    data_to_insert = (idimg, state, decode_base64_to_image(imgb64, state, idimg))  # Prepare data to insert
    cursor.execute(insert_query, data_to_insert)  # Execute insert query
    db_connection.commit()  # Commit changes
    cursor.close()  # Close cursor

@app.route('/')
def index():
    return render_template('upload.html')  # Render upload page

@app.route('/insert_img', methods=['POST'])
def insert_img():
    try:
        if 'file' not in request.files:
            return render_template('upload.html', error='No file part')  # Error if no file part
        file = request.files['file']
        if file.filename == '':
            return render_template('upload.html', error='No selected file')  # Error if no file selected
        
        image = Image.open(file.stream)  # Open image file
        processed_image = prepare_image(image, target_size=(224, 224))  # Prepare image for prediction

        prediction = base_model.predict(processed_image)  # Predict using model
        predicted_label = np.argmax(prediction, axis=1)[0] + 1  # Get predicted label
        predicted_label = str(predicted_label)

        img_io = io.BytesIO()  # Create byte stream
        image.save(img_io, 'JPEG')  # Save image to byte stream
        img_io.seek(0)
        img_data = base64.b64encode(img_io.read()).decode()  # Encode image to base64
        insert(img_data, predicted_label)  # Insert image data into database

        return render_template('upload.html', img_data=img_data, predicted_label=predicted_label)  # Render upload page with results
    except Exception as e:
        return render_template('upload.html', error=str(e))  # Error handling

# Function to list images from the database
def list_of_imgs():
    cursor = db_connection.cursor()  # Create database cursor
    cursor.execute("SELECT directory, states FROM pictures")  # Execute select query
    myresult = cursor.fetchall()  # Fetch all results
    if not myresult:
        print("No images found.")
        return pd.DataFrame(columns=["directory", "states"])  # Return empty DataFrame if no images found
    
    r = pd.DataFrame(myresult, columns=["directory", "states"])  # Create DataFrame from results
    cursor.close()  # Close cursor
    return r

# Function to encode image file to base64 string
def encode_image_to_base64(img_path):
    try:
        with open(img_path, "rb") as image_file:
            encoded_image = base64.b64encode(image_file.read())  # Encode image to base64
            return encoded_image.decode('utf-8')  # Return encoded string
    except Exception as e:
        print(f"Error: {e}")
        return None

@app.route('/list_imgs', methods=['GET'])
def list_imgs():
    ls = list_of_imgs()  # Get list of images from database
    img_info_list = []

    for img_path, img_label in zip(ls["directory"], ls["states"]):
        img_info = {
            "label": img_label,
            "base64": encode_image_to_base64(img_path)  # Encode image to base64 string
        }
        img_info_list.append(img_info)
    
    return render_template('index.html', images=img_info_list)  # Render page with list of images

if __name__ == '__main__':
    app.run(host='0.0.0.0')  # Run Flask app
