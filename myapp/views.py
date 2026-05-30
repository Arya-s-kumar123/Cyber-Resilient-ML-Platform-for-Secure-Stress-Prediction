from django.shortcuts import render,HttpResponse,redirect,get_object_or_404
from .models import *
from django.db.models import Q
from django.contrib import messages
from django.contrib.auth import authenticate
from datetime import date,datetime,timedelta
from django.contrib.auth import logout
from django.utils.timezone import now
from django.http import JsonResponse
from django.contrib.auth.decorators import login_required
from django.db.models import Sum
from datetime import datetime, date, time
from django.utils import timezone
import random, smtplib, ssl
from email.message import EmailMessage

import os
import pickle
import pandas as pd
import numpy as np

from django.shortcuts import render
from django.conf import settings
from django.utils import timezone
from .models import StressDetection, Appointment

from django.shortcuts import render, redirect
from django.utils import timezone
import pandas as pd
import numpy as np
import pickle, os
from datetime import date
from django.conf import settings
from datetime import datetime
from django.utils import timezone
from django.contrib import messages
from django.shortcuts import get_object_or_404, redirect, render

# Create your views here.
def index(request):
    return render(request,'index.html')

def about(request):
    return render(request,'about.html')

def patient_register(request):

    district = District.objects.all()

    return render(request,'patient_register.html',{
        'district':district
    })

def log(request):
    return render(request,'login.html')

def doctor_register(request):

    district = District.objects.all()
    speciality = MedicalSpeciality.objects.all()

    return render(request,'master/add_doctor.html',{
        'district':district,
        'speciality':speciality
    })



def update_doctor(request, doctor_id):
    doctor = get_object_or_404(Doctor, pk=doctor_id)
    districts = District.objects.all()
    specialities = MedicalSpeciality.objects.all()
    
    if request.method == "POST":
        # Update doctor fields
        doctor.doctor_first_name = request.POST.get('first_name', doctor.doctor_first_name)
        doctor.doctor_last_name = request.POST.get('last_name', doctor.doctor_last_name)
        doctor.email = request.POST.get('email', doctor.email)
        doctor.phone_number = request.POST.get('phone', doctor.phone_number)
        doctor.address = request.POST.get('address', doctor.address)
        doctor.place = request.POST.get('place', doctor.place)
        doctor.qualification = request.POST.get('qualification', doctor.qualification)
        
        district_id = request.POST.get('district')
        if district_id:
            doctor.district_id = district_id
        
        speciality_id = request.POST.get('speciality')
        if speciality_id:
            doctor.medical_speciality_id = speciality_id
        
        # Photo upload (if new photo is uploaded)
        if 'photo' in request.FILES:
            doctor.photo = request.FILES['photo']
        if 'proof' in request.FILES:
            doctor.proof = request.FILES['proof']
        
        # Update login username if changed
        doctor.login.username = request.POST.get('username', doctor.login.username)
        doctor.login.save()
        
        doctor.save()
        messages.success(request, "Doctor updated successfully!")
        return redirect('view_doctor')
    
    context = {
        'doctor': doctor,
        'district': districts,
        'speciality': specialities
    }
    
    return render(request, 'master/edit_doctor.html', context)
def login_action(request):

    u = request.POST.get("username")
    p = request.POST.get("password")

    # First check Django Admin
    obj = authenticate(username=u, password=p)

    if obj is not None:
        if obj.is_superuser == 1:
            request.session['aname'] = u
            request.session['slogid'] = obj.id
            return redirect('admin_home')

        else:
            messages.info(request,'Invalid User')
            return redirect('log')

    else:

        try:
            obj1 = Login.objects.get(username=u, password=p)

            # ---------------- PATIENT ----------------

            if obj1.Usertype == "Patient":

                if obj1.status == "Approved":

                    request.session['pname'] = u
                    request.session['slogid'] = obj1.login_id

                    return redirect('patient_home')

                elif obj1.status == "Not Approved":

                    messages.info(request,'Waiting For Approval')
                    return redirect('log')

                else:

                    messages.info(request,'Invalid User')
                    return redirect('log')


            # ---------------- DOCTOR ----------------

            elif obj1.Usertype == "Doctor":

                if obj1.status == "Approved":

                    request.session['dname'] = u
                    request.session['slogid'] = obj1.login_id
                    emp = Doctor.objects.get(login_id=obj1.login_id)
                    email = emp.email

                    # Generate OTP
                    otp = generate_otp(4)

                    # Send OTP to employee email
                    send_mail(email, f"Your OTP is: {otp}", "Stress Resilient Prediction Platform -  Doctor OTP Verification")

                    # Store OTP and login_id in session
                    request.session['doctor_otp'] = otp
                    request.session['doctor_logid'] = obj1.login_id

                    return render(request, "check_dr_otp.html", {
                        'logid': obj1.login_id
                    })
                elif obj1.status == "Not Approved":

                    messages.info(request,'Waiting For Approval')
                    return redirect('log')

                else:

                    messages.info(request,'Invalid User')
                    return redirect('log')


            
            elif obj1.Usertype == "Admin":

                request.session['aname'] = u
                request.session['slogid'] = obj1.login_id

                return redirect('admin_home')


            else:

                messages.info(request,'Invalid User')
                return redirect('log')


        except Login.DoesNotExist:

            messages.info(request,'Invalid Username or Password')
            return redirect('log')
        

def check_dr_otp(request):
    logid = request.POST.get("logid")
    entered_otp = request.POST.get("otp")
    session_otp = request.session.get("doctor_otp")

    if session_otp and str(entered_otp) == str(session_otp):
        user_login = Login.objects.get(login_id=logid)
        request.session['dname'] = user_login.username
        request.session['slogid'] = user_login.login_id

        # Clear OTP from session
        del request.session['doctor_otp']

        return redirect("/doctor_home/")
    else:
        messages.info(request, "Invalid OTP")
        return redirect("log")

# ADD STATE
def add_state(request):

    if request.method == "POST":

        state = request.POST.get("state")

        State.objects.create(
            state=state
        )

        messages.success(request,"State Added Successfully")

        return redirect('add_state')

    data = State.objects.all()

    return render(request,"master/add_state.html",{'data':data})


def delete_state(request,id):

    State.objects.get(state_id=id).delete()

    messages.success(request,"State Deleted Successfully")

    return redirect('add_state')


# ADD DISTRICT
def add_district(request):

    if request.method == "POST":

        district = request.POST.get("district")
        state_id = request.POST.get("state")

        District.objects.create(
            district=district,
            state_id=state_id
        )

        messages.success(request,"District Added Successfully")

        return redirect('add_district')

    state = State.objects.all()
    data = District.objects.all()

    return render(request,"master/add_district.html",{'state':state,'data':data})


def delete_district(request,id):

    District.objects.get(district_id=id).delete()

    messages.success(request,"District Deleted Successfully")

    return redirect('add_district')



# ADD MEDICAL SPECIALITY
def add_speciality(request):

    if request.method == "POST":

        speciality = request.POST.get("speciality")

        MedicalSpeciality.objects.create(
            speciality=speciality
        )

        messages.success(request,"Speciality Added Successfully")

        return redirect('add_speciality')

    data = MedicalSpeciality.objects.all()

    return render(request,"master/add_speciality.html",{'data':data})

def delete_speciality(request,id):

    MedicalSpeciality.objects.get(
        medical_speciality_id=id
    ).delete()

    messages.success(request,"Speciality Deleted Successfully")

    return redirect('add_speciality')
        
def patient_action(request):
    if request.method == "POST":

        username = request.POST.get("username")

        if Login.objects.filter(username=username).exists():
            messages.error(request,"Username already exists")
            return redirect('patient_register')

        login = Login.objects.create(
            username=username,
            password=request.POST.get("password"),
            Usertype="Patient",
            status="Approved"
        )

        Patient.objects.create(
            login=login,
            patient_name=request.POST.get("name"),
            phone_number=request.POST.get("phone"),
            address=request.POST.get("address"),
            place=request.POST.get("place"),
            dob=request.POST.get("dob"),
            created_at=timezone.now(),
            district_id=request.POST.get("district")
        )

        messages.success(request,"Patient Registered Successfully")
        return redirect('patient_register')

    return redirect('patient_register')

def doctor_action(request):
    if request.method == "POST":

        username = request.POST.get("username")

        if Login.objects.filter(username=username).exists():
            messages.error(request, "Username already exists")
            return redirect('doctor_register')

        login = Login.objects.create(
            username=username,
            password=request.POST.get("password"),
            Usertype="Doctor",
            status="Approved"
        )

        Doctor.objects.create(
            login=login,
            doctor_first_name=request.POST.get("first_name"),
            doctor_last_name=request.POST.get("last_name"),
            address=request.POST.get("address"),
            email=request.POST.get("email"),
            phone_number=request.POST.get("phone"),
            place=request.POST.get("place"),
            qualification=request.POST.get("qualification"),
            photo=request.FILES.get("photo"),
            district_id=request.POST.get("district"),
            medical_speciality_id=request.POST.get("speciality"),
            proof=request.FILES.get("proof"),
            consultation_start=request.POST.get("start_time"),
            consultation_end=request.POST.get("end_time"),

        )

        messages.success(request,"Doctor Registered Successfully")
        return redirect('doctor_register')

    return redirect('doctor_register')



def doctor_home(request):
    # Check if doctor is logged in
    if 'dname' not in request.session:
        return redirect('log')  # redirect to login

    # Get doctor data
    doctor_data = Doctor.objects.get(login_id=request.session['slogid'])
    request.session['doctor_id'] = doctor_data.doctor_id

    # Dashboard Counts
    today = timezone.localdate()
    today_count = Appointment.objects.filter(
        doctor=doctor_data, appointment_date=today
    ).count()

    patient_count = Patient.objects.filter(appointment__doctor=doctor_data).distinct().count()
    prescription_count = Prescription.objects.filter(
        appointment__doctor=doctor_data
    ).count()
    stress_count = StressDetection.objects.filter(
        appointment__doctor=doctor_data
    ).count()

    # Upcoming Appointments (future or today)
    appointments = Appointment.objects.filter(
        doctor=doctor_data, appointment_date__gte=today
    ).order_by('appointment_date', 'appointment_time')

    context = {
        'doctor_data': doctor_data,
        'today_count': today_count,
        'patient_count': patient_count,
        'prescription_count': prescription_count,
        'stress_count': stress_count,
        'appointments': appointments
    }

    return render(request, 'doctor/index.html', context)
def patient_home(request):

    if 'pname' in request.session:

        data = Patient.objects.get(login_id=request.session['slogid'])
        request.session['patient_id'] = data.patient_id

        return render(request,'patient/index.html',{'data':data})

    else:
        return redirect('log')
    

def admin_home(request):
    if 'aname' in request.session:
        context = {
            'total_doctors': Doctor.objects.count(),
            'total_patients': Patient.objects.count(),
            'total_appointments': Appointment.objects.count(),
            'total_prescriptions': Prescription.objects.count(),
            'total_stress_predictions': StressDetection.objects.count(),
            'total_complaints': Complaint.objects.count(),
            'total_feedback': Feedback.objects.count(),
        }
        return render(request, 'master/index.html', context)
    else:
        return redirect('log')

def common_logout(request):
    logout(request)
    request.session.delete()
    return redirect('log')

def view_doctor(request):

    data = Doctor.objects.all()

    return render(request,'master/view_doctor.html',{'data':data})

def delete_doctor(request,id):

    doctor = Doctor.objects.get(doctor_id=id)

    doctor.login.delete()   # Login table record also delete
    doctor.delete()

    messages.success(request,"Doctor Deleted Successfully")

    return redirect('view_doctor')

def view_patient(request):

    if 'aname' not in request.session:
        return redirect('log')

    data = Patient.objects.all()

    return render(request,'master/view_patient.html',{'data':data})





def patient_view_doctor(request):

    if 'pname' not in request.session:
        return redirect('log')

    speciality = MedicalSpeciality.objects.all()

    spec_id = request.GET.get('speciality')

    if spec_id:
        data = Doctor.objects.filter(medical_speciality_id=spec_id)
    else:
        data = Doctor.objects.all()

    return render(request,'patient/view_doctor.html',{
        'data':data,
        'speciality':speciality
    })
    


def book_appointment(request, id):

    if 'pname' not in request.session:
        return redirect('log')

    doctor = Doctor.objects.get(doctor_id=id)
    patient = Patient.objects.get(login_id=request.session['slogid'])

    # ✅ Generate slots from doctor time
    slots = generate_slots(
        doctor.consultation_start,
        doctor.consultation_end
    )

    if request.method == "POST":

        date = request.POST.get("date")
        time = request.POST.get("time")

        # Leave check
        leave_exists = LeaveDays.objects.filter(
            leave__doctor=doctor,
            leave_date=date,
            leave__leave_status="Approved",
            leave_days_status="Approved"
        ).exists()

        if leave_exists:
            messages.error(request, "Doctor is not available on this date")
            return redirect('book_appointment', id=id)

        # Duplicate check
        if Appointment.objects.filter(
            doctor=doctor,
            appointment_date=date,
            appointment_time=time
        ).exists():

            messages.error(request,"This slot is already booked")
            return redirect('book_appointment',id=id)

        Appointment.objects.create(
            appointment_date=date,
            appointment_time=time,
            created_at=timezone.now(),
            status="Pending",
            doctor=doctor,
            patient=patient
        )

        messages.success(request,"Appointment Booked Successfully")
        return redirect('patient_view_appointment')
    leave_days = LeaveDays.objects.filter(
    leave__doctor=doctor,
    leave__leave_status="Approved",
    leave_days_status="Approved"
).values_list('leave_date', flat=True)
    return render(request,'patient/book_appointment.html',{
        'doctor':doctor,
        'slots': slots,  # ✅ PASS HERE
         'leave_days': leave_days 
    })
def generate_slots(start, end):
    slots = []

    start_time = datetime.strptime(str(start), "%H:%M:%S")
    end_time = datetime.strptime(str(end), "%H:%M:%S")

    while start_time < end_time:
        slot_end = start_time + timedelta(minutes=15)

        slots.append({
            "start": start_time.strftime("%H:%M"),
            "display": f"{start_time.strftime('%H:%M')} - {slot_end.strftime('%H:%M')}"
        })

        start_time = slot_end

    return slots



def check_doctor_availability(request):

    date = request.GET.get("date")
    doctor_id = request.GET.get("doctor_id")

    if not date or not doctor_id:
        return JsonResponse({"status": "error"})

    # Convert string → date
    date = datetime.strptime(date, "%Y-%m-%d").date()

    # ✅ Check LeaveDays
    leave_exists = LeaveDays.objects.filter(
        leave__doctor_id=doctor_id,
        leave_date=date,
        leave__leave_status="Approved",
        leave_days_status="Approved"
    ).exists()

    if leave_exists:
        return JsonResponse({"status": "leave"})
    else:
        return JsonResponse({"status": "available"})
    
from django.http import JsonResponse
from datetime import datetime, timedelta

def get_slots(request):

    doctor_id = request.GET.get("doctor_id")
    date = request.GET.get("date")

    doctor = Doctor.objects.get(doctor_id=doctor_id)

    # Convert date
    date = datetime.strptime(date, "%Y-%m-%d").date()

    # Get booked times
    booked = Appointment.objects.filter(
        doctor=doctor,
        appointment_date=date
    ).values_list('appointment_time', flat=True)

    booked_list = [t.strftime("%H:%M") for t in booked]

    # Generate slots
    slots = []

    start_time = datetime.strptime(str(doctor.consultation_start), "%H:%M:%S")
    end_time = datetime.strptime(str(doctor.consultation_end), "%H:%M:%S")

    while start_time < end_time:

        slot = start_time.strftime("%H:%M")

        slot_end = (start_time + timedelta(minutes=15)).strftime("%H:%M")

        slots.append({
            "time": slot,
            "display": f"{slot} - {slot_end}",
            "booked": slot in booked_list   # 🔥 important
        })

        start_time += timedelta(minutes=15)

    return JsonResponse({"slots": slots})
def patient_view_appointment(request):

    if 'pname' not in request.session:
        return redirect('log')

    patient = Patient.objects.get(login_id=request.session['slogid'])

    data = Appointment.objects.filter(patient=patient).order_by('-appointment_date')

    return render(request,'patient/view_appointment.html',{
        'data':data
    }) 


def cancel_appointment(request):

    if 'pname' not in request.session:
        return redirect('log')

    patient = Patient.objects.get(login_id=request.session['slogid'])

    # ✅ Only future appointments
    data = Appointment.objects.filter(
        patient=patient,
        appointment_date__gt=date.today(),status='Pending'
    ).order_by('appointment_date')

    return render(request,'patient/cancel_appointment.html',{
        'data': data
    })


def cancel_booking(request, id):

    if 'pname' not in request.session:
        return redirect('log')

    appointment = get_object_or_404(Appointment, appointment_id=id)


    # ❗ Prevent cancelling past appointments
    if appointment.appointment_date < date.today():
        messages.error(request, "Cannot cancel past appointment")
        return redirect('cancel_appointment')

    # ❗ Only Pending can be cancelled
    if appointment.status != "Pending":
        messages.error(request, "Only pending appointments can be cancelled")
        return redirect('cancel_appointment')

    # ✅ Update status
    appointment.status = "Cancelled"
    appointment.save()

    messages.success(request, "Appointment Cancelled Successfully")

    return redirect('cancel_appointment')
# Doctor View Appointments
def doctor_view_appointment(request):
    if 'dname' not in request.session:
        return redirect('log')

    doctor = Doctor.objects.get(login_id=request.session['slogid'])
    today = date.today()

    # Today's appointments
    today_data = Appointment.objects.filter(
        doctor=doctor,
        appointment_date=today
    ).order_by('appointment_time')

    # Other appointments
    old_data = Appointment.objects.filter(
        doctor=doctor
    ).exclude(appointment_date=today).order_by('appointment_date', 'appointment_time')

    # Store prescription existence
    prescription_dict = {}

    for appt in old_data:
        prescription_dict[appt.appointment_id] = Prescription.objects.filter(
            appointment=appt
        ).first()  # returns object or None

    return render(request, 'doctor/view_appointment.html', {
        'today_data': today_data,
        'old_data': old_data,
        'prescription_dict': prescription_dict,
    })




def pending_appointments(request):

    if 'slogid' not in request.session:
        return redirect('log')

    doctor = get_object_or_404(Doctor, login_id=request.session['slogid'])

    # ✅ Pending + future appointments only
    data = Appointment.objects.filter(
        doctor=doctor,
        status="Pending",
        appointment_date__lt=date.today()
    ).order_by('appointment_date')

    return render(request, 'doctor/pending_appointments.html', {
        'data': data
    })
# Approve Appointment
def approve_appointment(request, id):
    if 'dname' not in request.session:
        return redirect('log')

    appointment = get_object_or_404(Appointment, appointment_id=id)
    appointment.status = "Approved"
    appointment.save()

    return redirect('doctor_view_appointment')


# Reject Appointment
def reject_appointment(request, id):
    if 'dname' not in request.session:
        return redirect('log')

    appointment = get_object_or_404(Appointment, appointment_id=id)
    appointment.status = "Rejected"
    appointment.save()

    return redirect('doctor_view_appointment')


def add_prescription(request, id):
    if 'dname' not in request.session:
        return redirect('log')

    appointment = get_object_or_404(Appointment, appointment_id=id)

    # Only allow if appointment is approved
    if appointment.status != "Approved":
        return redirect('doctor_view_appointment')

    # Check if prescription already exists
    prescription = Prescription.objects.filter(appointment=appointment).first()

    if request.method == "POST":
        visiting_date = request.POST.get("date")
        symptoms = encrypt_data(request.POST.get("symptoms"))
        medicine = encrypt_data(request.POST.get("medicine"))
        uses = encrypt_data(request.POST.get("uses", ""))
        details = encrypt_data(request.POST.get("details", ""))

        if prescription:
            # Update existing prescription
            prescription.visiting_date = visiting_date
            prescription.symptoms = symptoms
            prescription.medicine = medicine
            prescription.uses = uses
            prescription.details = details
            prescription.created_at = timezone.now()
            prescription.save()
        else:
            # Create new prescription
            Prescription.objects.create(
                appointment=appointment,
                visiting_date=visiting_date,
                symptoms=symptoms,
                medicine=medicine,
                uses=uses,
                details=details,
                created_at=timezone.now()
            )

        return redirect('doctor_view_appointment')

    # Pre-fill form with decrypted data if prescription exists
    context = {'appointment': appointment}
    if prescription:
        context.update({
            'visiting_date': prescription.visiting_date,
            'symptoms': decrypt_data(prescription.symptoms),
            'medicine': decrypt_data(prescription.medicine),
            'uses': decrypt_data(prescription.uses),
            'details': decrypt_data(prescription.details)
        })

    return render(request, 'doctor/add_prescription.html', context)

# View Prescription
def view_prescription(request, id):
    if 'dname' not in request.session:
        return redirect('log')

    appointment = get_object_or_404(Appointment, appointment_id=id)
    prescription = get_object_or_404(Prescription, appointment=appointment)

    return render(request, 'doctor/view_prescription.html', {
        'prescription': prescription,
        'appointment': appointment
    })
    


def patient_consult_history(request):
    if 'pname' not in request.session:
        return redirect('log')

    patient = Patient.objects.get(login_id=request.session['slogid'])
    appointments = Appointment.objects.filter(
        patient=patient,
        status="Approved"
    ).order_by('-appointment_date', '-appointment_time')

    
    return render(request, 'patient/consult_history.html', {
        'appointments': appointments
    })
    
    
def doctor_view_patients(request):
    if 'dname' not in request.session:
        return redirect('log')

    doctor = Doctor.objects.get(login_id=request.session['slogid'])

    # Get search query from GET
    patient_id = request.GET.get('patient_id')

    if patient_id:
        # Filter by patient_id for this doctor
        patients = Patient.objects.filter(
            patient_id=patient_id,
            appointment__doctor=doctor
        ).distinct()
    else:
        # All patients for this doctor
        patients = Patient.objects.filter(
            appointment__doctor=doctor
        ).distinct()

    return render(request, 'doctor/view_patients.html', {
        'patients': patients
    })

def p_view_prescription(request, id):
    if 'pname' not in request.session:
        return redirect('log')

    prescriptions = Prescription.objects.filter(appointment_id=id)

    data = []
    for p in prescriptions:
        data.append({
            'date': p.visiting_date,
            'symptoms': decrypt_data(p.symptoms) if p.symptoms else "",
            'medicine': decrypt_data(p.medicine) if p.medicine else "",
            'uses': decrypt_data(p.uses) if p.uses else "",
            'details': decrypt_data(p.details) if p.details else "",
        })

    return render(request, 'patient/view_prescription.html', {
        'prescriptions': data
    })    
def doctor_profile(request):
    if 'dname' not in request.session:
        return redirect('log')
    
    doctor = Doctor.objects.get(login_id=request.session['slogid'])
    
    return render(request, 'doctor/profile.html', {'doctor': doctor})



def doctor_update_profile(request):
    if 'dname' not in request.session:
        return redirect('log')
    
    doctor = Doctor.objects.get(login_id=request.session['slogid'])
    
    if request.method == "POST":
        doctor.doctor_first_name = request.POST.get('doctor_first_name')
        doctor.doctor_last_name = request.POST.get('doctor_last_name')
        doctor.address = request.POST.get('address')
        doctor.phone_number = request.POST.get('phone_number')
        doctor.place = request.POST.get('place')
        doctor.qualification = request.POST.get('qualification')
        doctor.email = request.POST.get('email')

        if 'photo' in request.FILES:
            doctor.photo = request.FILES['photo']
        
        doctor.save()
        messages.success(request, "Profile updated successfully!")
        return redirect('doctor_profile')
    
    return render(request, 'doctor/update_profile.html', {'doctor': doctor})


def doctor_change_password(request):
    if 'dname' not in request.session:
        return redirect('log')

    login = Login.objects.get(login_id=request.session['slogid'])

    if request.method == "POST":
        current_password = request.POST.get("current_password")
        new_password = request.POST.get("new_password")
        confirm_password = request.POST.get("confirm_password")

        # Check current password in plain text
        if current_password != login.password:
            messages.error(request, "Current password is incorrect")
        elif new_password != confirm_password:
            messages.error(request, "New password and confirm password do not match")
        else:
            login.password = new_password  # store plain text password
            login.save()
            messages.success(request, "Password changed successfully!")

    return render(request, 'doctor/change_password.html')




def patient_profile(request):
    if 'pname' not in request.session:
        return redirect('log')

    patient = Patient.objects.get(login_id=request.session['slogid'])

    return render(request, 'patient/profile.html', {'patient': patient})



def patient_update_profile(request):
    if 'pname' not in request.session:
        return redirect('log')

    patient = Patient.objects.get(login_id=request.session['slogid'])

    if request.method == "POST":
        patient.patient_name = request.POST.get('patient_name')
        patient.phone_number = request.POST.get('phone_number')
        patient.address = request.POST.get('address')
        patient.place = request.POST.get('place')
        patient.dob = request.POST.get('dob')
        patient.district_id = request.POST.get('district')

        patient.save()

        messages.success(request, "Profile updated successfully!")
        return redirect('patient_profile')

    districts = District.objects.all()

    return render(request, 'patient/update_profile.html', {
        'patient': patient,
        'districts': districts
    })
    
 
def complaint_page(request):
    if 'pname' not in request.session:
        return redirect('log')

    patient = Patient.objects.get(login_id=request.session['slogid'])

    if request.method == "POST":
        complaint_text = request.POST.get('complaint')

        Complaint.objects.create(
            patient=patient,
            complaint=complaint_text
        )

        messages.success(request, "Complaint submitted successfully!")
        return redirect('complaint_page')

    complaints = Complaint.objects.filter(patient=patient).order_by('-complaint_id')

    return render(request, 'patient/complaint.html', {
        'complaints': complaints
    })
    
    
def admin_complaints(request):
    complaints = Complaint.objects.all().order_by('-complaint_id')

    if request.method == "POST":
        cid = request.POST.get('complaint_id')
        reply = request.POST.get('reply')

        complaint = Complaint.objects.get(complaint_id=cid)
        complaint.reply = reply
        complaint.status = "Replied"
        complaint.save()

        return redirect('admin_complaints')

    return render(request, 'master/complaints.html', {
        'complaints': complaints
    })
    
    
def feedback_page(request):
    if 'pname' not in request.session:
        return redirect('log')

    patient = Patient.objects.get(login_id=request.session['slogid'])

    if request.method == "POST":
        feedback_text = request.POST.get('feedback')

        Feedback.objects.create(
            patient=patient,
            feedback=feedback_text
        )

        return redirect('feedback_page')

    feedbacks = Feedback.objects.filter(patient=patient).order_by('-feedback_id')

    return render(request, 'patient/feedback.html', {
        'feedbacks': feedbacks
    })
    
def admin_feedback(request):
    feedbacks = Feedback.objects.all().order_by('-feedback_id')

    if request.method == "POST":
        fid = request.POST.get('feedback_id')
        reply = request.POST.get('reply')

        fb = Feedback.objects.get(feedback_id=fid)
        fb.reply = reply
        fb.status = "Replied"
        fb.save()

        return redirect('admin_feedback')

    return render(request, 'master/feedback.html', {
        'feedbacks': feedbacks
    })
    
    

def admin_view_appointments(request):
    if 'aname' not in request.session:
        return redirect('log')

    today = date.today()

    # 🔹 Today's appointments
    today_data = Appointment.objects.filter(
        appointment_date=today
    ).order_by('appointment_time')

    # 🔹 Old / History
    history_data = Appointment.objects.exclude(
        appointment_date=today
    ).order_by('-appointment_date', 'appointment_time')

    return render(request, 'master/view_appointments.html', {
        'today_data': today_data,
        'history_data': history_data,
    })

# Load model
model_path = os.path.join(settings.MEDIA_ROOT, 'ML', 'stress_model.pkl')
encoder_path = os.path.join(settings.MEDIA_ROOT, 'ML', 'encoders.pkl')

model = pickle.load(open(model_path, 'rb'))
encoders = pickle.load(open(encoder_path, 'rb'))


  # your functions
def predict(request, appointment_id):

    if 'dname' not in request.session:
        return redirect('log')

    appointment = Appointment.objects.get(pk=appointment_id)

    # Age from DOB
    dob = appointment.patient.dob
    today = date.today()
    age = today.year - dob.year - ((today.month, today.day) < (dob.month, dob.day))

    # ✅ Check existing prediction
    record = StressDetection.objects.filter(appointment=appointment).first()

    if request.method == "POST":

        data = {
            'Age': age,
            'Gender': request.POST['gender'],
            'Occupation': request.POST['occupation'],
            'Marital_Status': request.POST['marital_status'],
            'Sleep_Duration': request.POST['sleep_duration'],
            'Sleep_Quality': request.POST['sleep_quality'],
            'Wake_Up_Time': request.POST['wake_time'],
            'Bed_Time': request.POST['bed_time'],
            'Physical_Activity': request.POST['physical_activity'],
            'Screen_Time': request.POST['screen_time'],
            'Caffeine_Intake': request.POST['caffeine'],
            'Alcohol_Intake': request.POST['alcohol'],
            'Smoking_Habit': request.POST['smoking'],
            'Work_Hours': request.POST['work_hours'],
            'Travel_Time': request.POST['travel_time'],
            'Social_Interactions': request.POST['social'],
            'Meditation_Practice': request.POST['meditation'],
            'Exercise_Type': request.POST['exercise'],
            'Blood_Pressure': request.POST['bp'],
            'Cholesterol_Level': request.POST['cholesterol'],
            'Blood_Sugar_Level': request.POST['sugar']
        }

        df = pd.DataFrame([data])

        # Time conversion
        df["Wake_Up_Time"] = pd.to_datetime(df["Wake_Up_Time"], errors='coerce').dt.hour
        df["Bed_Time"] = pd.to_datetime(df["Bed_Time"], errors='coerce').dt.hour

        # Encoding
        for col in encoders:
            if col in df.columns:
                try:
                    df[col] = encoders[col].transform(df[col].astype(str).str.strip())
                except:
                    df[col] = encoders[col].transform([encoders[col].classes_[0]])

        df = df.apply(pd.to_numeric, errors='coerce').fillna(0)

        # Prediction
        prediction = model.predict(df)
        probabilities = model.predict_proba(df)

        result = encoders["Stress_Detection"].inverse_transform(prediction)[0]
        confidence = float(np.max(probabilities))

        # =============================
        # ✅ CREATE OR UPDATE
        # =============================
        if record:
            # UPDATE
            record.rf_prediction = encrypt_data(result)
            record.confidence_score = confidence
            record.prediction_date = timezone.now()

            record.age = encrypt_data(str(age))
            record.gender = encrypt_data(request.POST['gender'])
            record.occupation = encrypt_data(request.POST['occupation'])
            record.marital_status = encrypt_data(request.POST['marital_status'])

            record.sleep_duration = encrypt_data(request.POST['sleep_duration'])
            record.sleep_quality = encrypt_data(request.POST['sleep_quality'])
            record.wake_time = encrypt_data(request.POST['wake_time'])
            record.bed_time = encrypt_data(request.POST['bed_time'])

            record.physical_activity = encrypt_data(request.POST['physical_activity'])
            record.screen_time = encrypt_data(request.POST['screen_time'])
            record.caffeine = encrypt_data(request.POST['caffeine'])
            record.alcohol = encrypt_data(request.POST['alcohol'])
            record.smoking = encrypt_data(request.POST['smoking'])

            record.work_hours = encrypt_data(request.POST['work_hours'])
            record.travel_time = encrypt_data(request.POST['travel_time'])
            record.social = encrypt_data(request.POST['social'])

            record.meditation = encrypt_data(request.POST['meditation'])
            record.exercise = encrypt_data(request.POST['exercise'])

            record.bp = encrypt_data(request.POST['bp'])
            record.cholesterol = encrypt_data(request.POST['cholesterol'])
            record.sugar = encrypt_data(request.POST['sugar'])

            record.save()

        else:
            # CREATE
            record = StressDetection.objects.create(
                rf_prediction=encrypt_data(result),
                confidence_score=confidence,
                prediction_date=timezone.now(),

                age=encrypt_data(str(age)),
                gender=encrypt_data(request.POST['gender']),
                occupation=encrypt_data(request.POST['occupation']),
                marital_status=encrypt_data(request.POST['marital_status']),

                sleep_duration=encrypt_data(request.POST['sleep_duration']),
                sleep_quality=encrypt_data(request.POST['sleep_quality']),
                wake_time=encrypt_data(request.POST['wake_time']),
                bed_time=encrypt_data(request.POST['bed_time']),

                physical_activity=encrypt_data(request.POST['physical_activity']),
                screen_time=encrypt_data(request.POST['screen_time']),
                caffeine=encrypt_data(request.POST['caffeine']),
                alcohol=encrypt_data(request.POST['alcohol']),
                smoking=encrypt_data(request.POST['smoking']),

                work_hours=encrypt_data(request.POST['work_hours']),
                travel_time=encrypt_data(request.POST['travel_time']),
                social=encrypt_data(request.POST['social']),

                meditation=encrypt_data(request.POST['meditation']),
                exercise=encrypt_data(request.POST['exercise']),

                bp=encrypt_data(request.POST['bp']),
                cholesterol=encrypt_data(request.POST['cholesterol']),
                sugar=encrypt_data(request.POST['sugar']),

                appointment=appointment
            )

        return redirect('prediction_result', record.prediction_id)

    # =============================
    # ✅ PREFILL FORM IF EXISTS
    # =============================
    context = {"age": age}

    if record:
        context.update({
            "gender": decrypt_data(record.gender),
            "occupation": decrypt_data(record.occupation),
            "marital_status": decrypt_data(record.marital_status),
            "sleep_duration": decrypt_data(record.sleep_duration),
            "sleep_quality": decrypt_data(record.sleep_quality),
            "wake_time": decrypt_data(record.wake_time),
            "bed_time": decrypt_data(record.bed_time),
            "physical_activity": decrypt_data(record.physical_activity),
            "screen_time": decrypt_data(record.screen_time),
            "caffeine": decrypt_data(record.caffeine),
            "alcohol": decrypt_data(record.alcohol),
            "smoking": decrypt_data(record.smoking),
            "work_hours": decrypt_data(record.work_hours),
            "travel_time": decrypt_data(record.travel_time),
            "social": decrypt_data(record.social),
            "meditation": decrypt_data(record.meditation),
            "exercise": decrypt_data(record.exercise),
            "bp": decrypt_data(record.bp),
            "cholesterol": decrypt_data(record.cholesterol),
            "sugar": decrypt_data(record.sugar),
        })

    return render(request, "doctor/predict.html", context)
def prediction_result(request, id):
    if 'dname' not in request.session:
        return redirect('log') 
    data = StressDetection.objects.get(pk=id)

    context = {
        "result": decrypt_data(data.rf_prediction),
        "confidence": round(data.confidence_score * 100, 2),

        "age": decrypt_data(data.age),
        "gender": decrypt_data(data.gender),
        "occupation": decrypt_data(data.occupation),
        "marital_status": decrypt_data(data.marital_status),

        "sleep_duration": decrypt_data(data.sleep_duration),
        "sleep_quality": decrypt_data(data.sleep_quality),
        "wake_time": decrypt_data(data.wake_time),
        "bed_time": decrypt_data(data.bed_time),

        "physical_activity": decrypt_data(data.physical_activity),
        "screen_time": decrypt_data(data.screen_time),
        "caffeine": decrypt_data(data.caffeine),
        "alcohol": decrypt_data(data.alcohol),
        "smoking": decrypt_data(data.smoking),

        "work_hours": decrypt_data(data.work_hours),
        "travel_time": decrypt_data(data.travel_time),
        "social": decrypt_data(data.social),

        "meditation": decrypt_data(data.meditation),
        "exercise": decrypt_data(data.exercise),

        "bp": decrypt_data(data.bp),
        "cholesterol": decrypt_data(data.cholesterol),
        "sugar": decrypt_data(data.sugar),

        "appointment": data.appointment
    }

    return render(request, "doctor/prediction_result.html", context)





def patient_all_details(request, patient_id):
    if 'dname' not in request.session:
        return redirect('log')
    
    patient = get_object_or_404(Patient, pk=patient_id)
    appointments = Appointment.objects.filter(patient=patient).order_by('-appointment_date')

    # Attach prediction to each appointment
    for appt in appointments:
        try:
            pred = StressDetection.objects.get(appointment=appt)
            # Decrypt all fields
            pred.rf_prediction = decrypt_data(pred.rf_prediction)
            pred.age = decrypt_data(pred.age)
            pred.gender = decrypt_data(pred.gender)
            pred.occupation = decrypt_data(pred.occupation)
            pred.marital_status = decrypt_data(pred.marital_status)
            pred.sleep_duration = decrypt_data(pred.sleep_duration)
            pred.sleep_quality = decrypt_data(pred.sleep_quality)
            pred.wake_time = decrypt_data(pred.wake_time)
            pred.bed_time = decrypt_data(pred.bed_time)
            pred.physical_activity = decrypt_data(pred.physical_activity)
            pred.screen_time = decrypt_data(pred.screen_time)
            pred.caffeine = decrypt_data(pred.caffeine)
            pred.alcohol = decrypt_data(pred.alcohol)
            pred.smoking = decrypt_data(pred.smoking)
            pred.work_hours = decrypt_data(pred.work_hours)
            pred.travel_time = decrypt_data(pred.travel_time)
            pred.social = decrypt_data(pred.social)
            pred.meditation = decrypt_data(pred.meditation)
            pred.exercise = decrypt_data(pred.exercise)
            pred.bp = decrypt_data(pred.bp)
            pred.cholesterol = decrypt_data(pred.cholesterol)
            pred.sugar = decrypt_data(pred.sugar)
            appt.stress_prediction = pred
        except StressDetection.DoesNotExist:
            appt.stress_prediction = None

    context = {
        "patient": patient,
        "appointments": appointments
    }
    return render(request, 'doctor/patient_all_details.html', context)

# View to show stress graph for a patient
def prediction_graph(request, patient_id):
    if 'dname' not in request.session:
        return redirect('log')
    
    patient = get_object_or_404(Patient, pk=patient_id)
    records = StressDetection.objects.filter(appointment__patient=patient).order_by('prediction_date')
    
    # Map stress labels to numeric values for chart
    stress_mapping = {
        "Low": 1,
        "Medium": 2,
        "High": 3
    }

    dates = [r.prediction_date.strftime("%Y-%m-%d") for r in records]
    stress_values = [stress_mapping.get(decrypt_data(r.rf_prediction), 0) for r in records]
    stress_labels = [decrypt_data(r.rf_prediction) for r in records]  # for tooltips

    context = {
        "patient": patient,
        "dates": dates,
        "stress_values": stress_values,
        "stress_labels": stress_labels
    }
    return render(request, 'doctor/prediction_graph.html', context)



def model_result(request):
    if 'aname' not in request.session:
        return redirect('log')
    
    results = ModelResults.objects.all().order_by('-id')
    
    graphs = {
        "Confusion Matrix": "ML/graphs/confusion_matrix.png",
        "Correlation": "ML/graphs/correlation.png",
        "Feature Importance": "ML/graphs/feature_importance.png",
        "Performance": "ML/graphs/performance.png",
    }

    return render(request, 'master/model_result.html', {
        'results': results,
        'graphs': graphs,
         'MEDIA_URL': settings.MEDIA_URL
    })
def p_view_stress_result(request, id):
    if 'pname' not in request.session:
        return redirect('log')

    stress_data = StressDetection.objects.filter(appointment_id=id)

    decrypted_data = []

    for s in stress_data:
        decrypted_data.append({
            'rf_prediction': decrypt_data(s.rf_prediction) if s.rf_prediction else "",
            'confidence_score': s.confidence_score,
            'age': decrypt_data(s.age) if s.age else "",
            'gender': decrypt_data(s.gender) if s.gender else "",
            'occupation': decrypt_data(s.occupation) if s.occupation else "",
            'marital_status': decrypt_data(s.marital_status) if s.marital_status else "",

            'sleep_duration': decrypt_data(s.sleep_duration) if s.sleep_duration else "",
            'sleep_quality': decrypt_data(s.sleep_quality) if s.sleep_quality else "",
            'wake_time': decrypt_data(s.wake_time) if s.wake_time else "",
            'bed_time': decrypt_data(s.bed_time) if s.bed_time else "",

            'physical_activity': decrypt_data(s.physical_activity) if s.physical_activity else "",
            'screen_time': decrypt_data(s.screen_time) if s.screen_time else "",
            'caffeine': decrypt_data(s.caffeine) if s.caffeine else "",
            'alcohol': decrypt_data(s.alcohol) if s.alcohol else "",
            'smoking': decrypt_data(s.smoking) if s.smoking else "",

            'work_hours': decrypt_data(s.work_hours) if s.work_hours else "",
            'travel_time': decrypt_data(s.travel_time) if s.travel_time else "",
            'social': decrypt_data(s.social) if s.social else "",

            'meditation': decrypt_data(s.meditation) if s.meditation else "",
            'exercise': decrypt_data(s.exercise) if s.exercise else "",

            'bp': decrypt_data(s.bp) if s.bp else "",
            'cholesterol': decrypt_data(s.cholesterol) if s.cholesterol else "",
            'sugar': decrypt_data(s.sugar) if s.sugar else "",
            
            'prediction_date': s.prediction_date
        })

    return render(request, 'patient/view_stress_result.html', {
        'stress_data': decrypted_data
    })

def p_view_stress_graph(request, id):
    if 'pname' not in request.session:
        return redirect('log')

    stress_data = StressDetection.objects.filter(appointment_id=id)

    # Example: prepare chart data
    chart_data = []
    for s in stress_data:
        chart_data.append({
            'parameter': 'Confidence Score',
            'value': s.confidence_score
        })
        # add more metrics as needed

    return render(request, 'patient/view_stress_graph.html', {
        'chart_data': chart_data
    })

# -------------- Project leave---------------------------------------

def leave_apply(request):
 if 'dname' in request.session:
    today = datetime.today()
    return render(request,'Doctor/leave_apply.html',{'today':today})
 elif 'mname' in request.session:
     return render(request,'Doctor/leave_apply.html')
 else:
      return redirect('/log/')
def leave_list(request):
 if 'dname' in request.session:
    logid=request.session['slogid']
    doctor_id=getdoctor(logid)
    data=Leave.objects.filter(doctor_id=doctor_id)
    return render(request,'Doctor/leave_list.html',{'data':data})

 elif 'aname' in request.session:
    data=Leave.objects.filter(~Q(leave_status="Not Approved"))
    return render(request,'Master/leave_list.html',{'data':data})

 else:
      return redirect('/log/')
def new_leave_request(request):
    if 'aname' in request.session:
        data = Leave.objects.all()
        return render(request,'Master/new_leave_request.html',{'data':data})
    else:
        return redirect('/log/')
  
def leave_status(request):
    if 'aname' in request.session:
        if 'leave_id' in request.GET:
            obj = Leave.objects.get(leave_id=request.GET['leave_id'])
            obj.leave_status = request.GET['status']
            obj.save()
           # Update the status of each related LeaveDays instance
            leave_days = LeaveDays.objects.filter(leave_id=obj.leave_id)
            for day in leave_days:
                day.leave_days_status = request.GET['status']
                day.save()
            messages.success(request, 'Approved successfully.')
            return redirect('new_leave_request')
        else:
            return redirect('new_leave_request')
    else:
        return redirect('/log/')
def check_leave_exist(request):
    logid=request.session['slogid']
    doctor_id=getdoctor(logid)
    start_date = datetime.strptime(request.GET.get('start_date', None), '%Y-%m-%d').date()
    end_date= datetime.strptime(request.GET.get('end_date', None), '%Y-%m-%d').date()
    exists = Leave.objects.filter(
    Q(doctor_id=doctor_id) &
    (
        Q(start_date__lte=end_date, end_date__gte=start_date)  
    )
    ).exists()
    return JsonResponse({'exists': exists})
def save_leave_apply(request):
    if 'dname' in request.session:
        obj = Leave()
        logid=request.session['slogid']
        doctor_id=getdoctor(logid)
        obj.reason = request.POST['reason']
        obj.start_date = request.POST['start_date']
        obj.end_date = request.POST['end_date']
        obj.leave_type = request.POST['leave_type_id']
        
        obj.start_date = datetime.strptime(request.POST['start_date'], "%Y-%m-%d").date()
        obj.end_date = datetime.strptime(request.POST['end_date'], "%Y-%m-%d").date()
        obj.doctor_id=doctor_id
        obj.save()

        # Insert records into LeaveDays for each date in the leave range
        start_date = obj.start_date
        end_date = obj.end_date
        current_date = start_date

        while current_date <= end_date:
            leave_day = LeaveDays(
                leave=obj,
                leave_date=current_date,
                leave_days_status="Not Approved"
            )
            leave_day.save()
            current_date += timedelta(days=1)

        
        messages.add_message(request, messages.INFO, 'Added successfully.')
        return redirect('/leave_apply/')
    else:
        return redirect('/log/')
   








from cryptography.fernet import Fernet

key = b'XjV-LVXLL-U6cfTCOYvDB4Hth270gY3wdMEDRBHUDYA='
cipher = Fernet(key)

def encrypt_data(data):
    return cipher.encrypt(data.encode()).decode()

def decrypt_data(data):
    return cipher.decrypt(data.encode()).decode()
def generate_otp(length):
    return ''.join(str(random.randint(0, 9)) for _ in range(length))

def send_mail(receiver_email, msg, subject):
    email_sender = "aryaskumar030@gmail.com"
    email_password = "uoonbcpsinxrvpgj"

    em = EmailMessage()
    em['From'] = email_sender
    em['To'] = receiver_email
    em['Subject'] = subject
    em.set_content(msg)

    context = ssl.create_default_context()
    with smtplib.SMTP_SSL('smtp.gmail.com', 465, context=context) as smtp:
        smtp.login(email_sender, email_password)
        smtp.send_message(em)

def getdoctor(id):
    data=Doctor.objects.get(login_id=id)
    return data.doctor_id
