import pickle
import pandas as pd

# -----------------------------
# Load model & encoders
# -----------------------------
with open("stress_model.pkl", "rb") as f:
    model = pickle.load(f)

with open("encoders.pkl", "rb") as f:
    encoders = pickle.load(f)

# -----------------------------
# Input data
# -----------------------------
input_data = {
    'Age': 50,
    'Gender': 'Male',
    'Occupation': 'Business Owner',
    'Marital_Status': 'Married',
    'Sleep_Duration': 5,
    'Sleep_Quality': 2,
    'Wake_Up_Time': '5:00 AM',
    'Bed_Time': '12:30 AM',
    'Physical_Activity': 1,
    'Screen_Time': 8,
    'Caffeine_Intake': 3,
    'Alcohol_Intake': 2,
    'Smoking_Habit': 'Yes',
    'Work_Hours': 12,
    'Travel_Time': 2,
    'Social_Interactions': 2,
    'Meditation_Practice': 'No',
    'Exercise_Type': 'Walking',
    'Blood_Pressure': 150,
    'Cholesterol_Level': 240,
    'Blood_Sugar_Level': 130
}

df = pd.DataFrame([input_data])

# -----------------------------
# Convert time
# -----------------------------
df["Wake_Up_Time"] = pd.to_datetime(df["Wake_Up_Time"], errors='coerce').dt.hour
df["Bed_Time"] = pd.to_datetime(df["Bed_Time"], errors='coerce').dt.hour

# -----------------------------
# Encode ONLY categorical columns
# -----------------------------
for col in encoders:
    if col in df.columns:
        try:
            df[col] = encoders[col].transform(df[col].astype(str).str.strip())
        except:
            # fallback for unseen values
            df[col] = encoders[col].transform([encoders[col].classes_[0]])

# -----------------------------
# Convert numeric columns safely
# -----------------------------
df = df.apply(pd.to_numeric, errors='coerce').fillna(0)

# -----------------------------
# Predict
# -----------------------------
prediction = model.predict(df)

# -----------------------------
# Decode output
# -----------------------------
result = encoders["Stress_Detection"].inverse_transform(prediction)

print("Predicted Stress Level:", result[0])