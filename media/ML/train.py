import pandas as pd
import os
import pickle
import matplotlib.pyplot as plt
import seaborn as sns
import mysql.connector

from sklearn.model_selection import train_test_split
from sklearn.preprocessing import LabelEncoder
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score, precision_score, recall_score, f1_score, confusion_matrix, classification_report

# -----------------------------
# Create graphs folder
# -----------------------------
os.makedirs("graphs", exist_ok=True)

# -----------------------------
# Load dataset
# -----------------------------
data = pd.read_csv("stress_detection_data.csv")

# -----------------------------
# CLEAN COLUMN NAMES
# -----------------------------
data.columns = data.columns.str.strip()

# -----------------------------
# FIX TIME FORMAT
# -----------------------------
data["Wake_Up_Time"] = pd.to_datetime(data["Wake_Up_Time"], errors='coerce').dt.hour
data["Bed_Time"] = pd.to_datetime(data["Bed_Time"], errors='coerce').dt.hour

# -----------------------------
# STRIP ALL STRINGS
# -----------------------------
for col in data.columns:
    data[col] = data[col].astype(str).str.strip()

# -----------------------------
# ENCODE EVERYTHING (SAFE WAY)
# -----------------------------
encoders = {}

for col in data.columns:
    le = LabelEncoder()
    data[col] = le.fit_transform(data[col])
    encoders[col] = le

# -----------------------------
# FORCE NUMERIC (CRITICAL FIX)
# -----------------------------
data = data.apply(pd.to_numeric, errors='coerce')
data = data.fillna(0)

# -----------------------------
# DEBUG CHECK
# -----------------------------
print("\nFINAL TYPES:\n", data.dtypes)

# -----------------------------
# SPLIT DATA
# -----------------------------
X = data.drop("Stress_Detection", axis=1)
y = data["Stress_Detection"]

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2)

# -----------------------------
# MODEL
# -----------------------------
model = RandomForestClassifier(n_estimators=100)
model.fit(X_train, y_train)

# -----------------------------
# SAVE MODEL
# -----------------------------
pickle.dump(model, open("stress_model.pkl", "wb"))
pickle.dump(encoders, open("encoders.pkl", "wb"))

# -----------------------------
# PREDICTION
# -----------------------------
y_pred = model.predict(X_test)

# -----------------------------
# METRICS
# -----------------------------
accuracy = accuracy_score(y_test, y_pred)
precision = precision_score(y_test, y_pred, average='weighted')
recall = recall_score(y_test, y_pred, average='weighted')
f1 = f1_score(y_test, y_pred, average='weighted')

print("\nAccuracy:", accuracy)

# -----------------------------
# GRAPH 1: Confusion Matrix
# -----------------------------
plt.figure()
sns.heatmap(confusion_matrix(y_test, y_pred), annot=True, fmt='d')
plt.savefig("graphs/confusion_matrix.png")
plt.close()

# -----------------------------
# GRAPH 2: Performance
# -----------------------------
plt.figure()
plt.bar(["Acc", "Prec", "Rec", "F1"], [accuracy, precision, recall, f1])
plt.savefig("graphs/performance.png")
plt.close()

# -----------------------------
# GRAPH 3: Feature Importance
# -----------------------------
plt.figure()
plt.barh(X.columns, model.feature_importances_)
plt.savefig("graphs/feature_importance.png")
plt.close()

# -----------------------------
# GRAPH 4: Correlation
# -----------------------------
plt.figure(figsize=(10,6))
sns.heatmap(data.corr())
plt.savefig("graphs/correlation.png")
plt.close()

# -----------------------------
# MYSQL
# -----------------------------
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="stress_resilient"
)

cursor = conn.cursor()

cursor.execute("""
CREATE TABLE IF NOT EXISTS model_results (
    id INT AUTO_INCREMENT PRIMARY KEY,
    accuracy FLOAT,
    precision_score FLOAT,
    recall_score FLOAT,
    f1_score FLOAT,
    report TEXT
)
""")

report = classification_report(y_test, y_pred)

cursor.execute("""
INSERT INTO model_results (accuracy, precision_score, recall_score, f1_score, report)
VALUES (%s, %s, %s, %s, %s)
""", (accuracy, precision, recall, f1, report))

conn.commit()
cursor.close()
conn.close()

print("\n✅ SUCCESS - Everything working!")