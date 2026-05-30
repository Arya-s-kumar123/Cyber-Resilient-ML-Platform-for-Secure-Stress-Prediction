from django.db import models

# Create your models here.
class Login(models.Model):
    login_id = models.AutoField(primary_key=True)
    username = models.CharField(max_length=50)
    password = models.TextField()
    Usertype = models.CharField(max_length=50)
    status = models.CharField(max_length=50)

    class Meta:
        db_table = 'tbl_login'
        
class State(models.Model):
    state_id = models.AutoField(primary_key=True)
    state = models.CharField(max_length=50)

    class Meta:
        db_table = "tbl_state"
        
class District(models.Model):
    district_id = models.AutoField(primary_key=True)
    district = models.CharField(max_length=50)
    state = models.ForeignKey(State, on_delete=models.CASCADE)

    class Meta:
        db_table = "tbl_district"
        
class MedicalSpeciality(models.Model):
    medical_speciality_id = models.AutoField(primary_key=True)
    speciality = models.CharField(max_length=50)

    class Meta:
        db_table = "tbl_medical_speciality"
        
class Doctor(models.Model):
    doctor_id = models.AutoField(primary_key=True)
    doctor_first_name = models.CharField(max_length=50)
    doctor_last_name = models.CharField(max_length=50)
    address = models.CharField(max_length=50)
    email = models.EmailField(max_length=50)
    phone_number = models.BigIntegerField()
    place = models.CharField(max_length=50)
    qualification = models.CharField(max_length=50)
    photo = models.ImageField(upload_to="doctor_photos/")

    district = models.ForeignKey(District, on_delete=models.CASCADE)
    login = models.ForeignKey(Login, on_delete=models.CASCADE)
    medical_speciality = models.ForeignKey(MedicalSpeciality, on_delete=models.CASCADE)
    proof = models.FileField(upload_to="doctor_proofs/")
    consultation_start = models.TimeField(null=True,blank=True)
    consultation_end = models.TimeField(null=True,blank=True)

    class Meta:
        db_table = "tbl_doctor"

class Patient(models.Model):
    patient_id = models.AutoField(primary_key=True)
    patient_name = models.CharField(max_length=50)
    phone_number = models.BigIntegerField()
    address = models.TextField()
    place = models.CharField(max_length=50)
    dob = models.DateField()
    created_at = models.DateTimeField()

    district = models.ForeignKey(District, on_delete=models.CASCADE)
    login = models.ForeignKey(Login, on_delete=models.CASCADE)

    class Meta:
        db_table = "tbl_patient"
        
class Appointment(models.Model):
    appointment_id = models.AutoField(primary_key=True)
    appointment_date = models.DateField()
    appointment_time = models.TimeField(null=True)
    created_at = models.DateTimeField()
    status = models.CharField(max_length=50)

    doctor = models.ForeignKey(Doctor, on_delete=models.CASCADE)
    patient = models.ForeignKey(Patient, on_delete=models.CASCADE)

    class Meta:
        db_table = "tbl_appointment"
        
class Prescription(models.Model):
    prescription_id = models.AutoField(primary_key=True)
    visiting_date = models.DateField()
    symptoms = models.TextField()
    medicine = models.TextField()
    uses = models.TextField()
    details = models.TextField()
    created_at = models.DateTimeField()

    appointment = models.ForeignKey(Appointment, on_delete=models.CASCADE)

    class Meta:
        db_table = "tbl_prescription"

class StressDetection(models.Model):
    prediction_id = models.AutoField(primary_key=True)

    rf_prediction = models.TextField()   # encrypted
    confidence_score = models.FloatField()
    prediction_date = models.DateTimeField()

    # -----------------------------
    # Encrypted Input Features
    # -----------------------------
    age = models.TextField()
    gender = models.TextField()
    occupation = models.TextField()
    marital_status = models.TextField()

    sleep_duration = models.TextField()
    sleep_quality = models.TextField()
    wake_time = models.TextField()
    bed_time = models.TextField()

    physical_activity = models.TextField()
    screen_time = models.TextField()
    caffeine = models.TextField()
    alcohol = models.TextField()
    smoking = models.TextField()

    work_hours = models.TextField()
    travel_time = models.TextField()
    social = models.TextField()

    meditation = models.TextField()
    exercise = models.TextField()

    bp = models.TextField()
    cholesterol = models.TextField()
    sugar = models.TextField()

    appointment = models.ForeignKey(Appointment, on_delete=models.CASCADE)

    class Meta:
        db_table = "tbl_stress_detection"

class Complaint(models.Model):
    complaint_id = models.AutoField(primary_key=True)
    patient = models.ForeignKey('Patient', on_delete=models.CASCADE)
    complaint = models.TextField()
    reply = models.TextField(null=True, blank=True)
    status = models.CharField(max_length=20, default="Pending")
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = "tbl_complaint"
        
class Feedback(models.Model):
    feedback_id = models.AutoField(primary_key=True)
    patient = models.ForeignKey('Patient', on_delete=models.CASCADE)
    feedback = models.TextField()

    reply = models.TextField(null=True, blank=True)  
    status = models.CharField(max_length=20, default="Pending")  

    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = "tbl_feedback"


class ModelResults(models.Model):
    id = models.AutoField(primary_key=True)
    accuracy = models.FloatField(null=True, blank=True)
    precision_score = models.FloatField(null=True, blank=True)
    recall_score = models.FloatField(null=True, blank=True)
    f1_score = models.FloatField(null=True, blank=True)
    report = models.TextField(null=True, blank=True)

    class Meta:
        db_table = 'model_results'

class Leave(models.Model):
    leave_id=models.AutoField(primary_key=True)
    doctor=models.ForeignKey(Doctor,on_delete=models.CASCADE)
    leave_type=models.CharField(max_length=50,null=True, blank=True)
    reason=models.TextField(null=True, blank=True)
    leave_status=models.CharField(max_length=50,default="Not Approved")
    start_date=models.DateField(null=True, blank=True)
    end_date=models.DateField(null=True, blank=True)
    created_at=models.DateTimeField(auto_now_add=True)
   
    class Meta:
        db_table='tbl_leave'
class LeaveDays(models.Model):
    leave_days_id=models.AutoField(primary_key=True)
    leave=models.ForeignKey(Leave,on_delete=models.CASCADE)
    leave_date=models.DateField(null=True, blank=True)
    created_at=models.DateTimeField(auto_now_add=True)
    leave_days_status=models.CharField(max_length=50,default="Not Approved")
   
    class Meta:
        db_table='tbl_leave_days'