
from django.contrib import admin
from django.urls import path
from .import views

urlpatterns = [
    path('', views.index,name='index'),
    path('about/', views.about,name='about'),
    path("patient_register/", views.patient_register, name="patient_register"),
    path("log/", views.log, name="log"),
    path("doctor_register/", views.doctor_register, name="doctor_register"),
    path("login_action/", views.login_action, name="login_action"),
    path("patient_action/", views.patient_action, name="patient_action"),
    path("doctor_action/", views.doctor_action, name="doctor_action"),
    path("doctor_home/", views.doctor_home, name="doctor_home"),
    path("patient_home/", views.patient_home, name="patient_home"),
    path("admin_home/", views.admin_home, name="admin_home"),
    path("common_logout/", views.common_logout, name="common_logout"),
    path('add_state',views.add_state,name="add_state"),
    path('delete_state/<int:id>',views.delete_state,name="delete_state"),
    path('add_district',views.add_district,name="add_district"),
    path('delete_district/<int:id>',views.delete_district,name="delete_district"),
    path('add_speciality',views.add_speciality,name="add_speciality"),
    path('delete_speciality/<int:id>',views.delete_speciality,name="delete_speciality"),
    path('view_doctor/',views.view_doctor,name='view_doctor'),
    path('delete_doctor/<int:id>',views.delete_doctor,name='delete_doctor'),
    path('view_patient',views.view_patient,name='view_patient'),
    path('book_appointment/<int:id>',views.book_appointment,name='book_appointment'),
    path('patient_view_doctor',views.patient_view_doctor,name='patient_view_doctor'),
    path('patient_view_appointment',views.patient_view_appointment,name='patient_view_appointment'),
    path("doctor_view_appointment/", views.doctor_view_appointment, name="doctor_view_appointment"),
    path('approve_appointment/<int:id>',views.approve_appointment,name='approve_appointment'),

    path('reject_appointment/<int:id>',views.reject_appointment,name='reject_appointment'),
    path('add_prescription/<int:id>',views.add_prescription,name='add_prescription'),
    path("patient_consult_history/", views.patient_consult_history, name="patient_consult_history"),
    path("doctor_view_patients/", views.doctor_view_patients, name="doctor_view_patients"),
    path('doctor_profile/', views.doctor_profile, name='doctor_profile'),
    path('doctor_update_profile/', views.doctor_update_profile, name='doctor_update_profile'),
    path('doctor_change_password/', views.doctor_change_password, name='doctor_change_password'),
    path('view_prescription/<int:id>/', views.view_prescription, name='view_prescription'),
    path('patient_profile/', views.patient_profile, name='patient_profile'),
    path('patient_update_profile/', views.patient_update_profile, name='patient_update_profile'),
    path('complaint_page/', views.complaint_page, name='complaint_page'),
    path('admin_complaints/', views.admin_complaints, name='admin_complaints'),
    path('feedback_page/', views.feedback_page, name='feedback_page'),
    path('admin_feedback/', views.admin_feedback, name='admin_feedback'),
    path('admin_view_appointments/', views.admin_view_appointments, name='admin_view_appointments'),


    # urls.py
path('predict/<int:appointment_id>/', views.predict, name='predict'),

path('result/<int:id>/', views.prediction_result, name='prediction_result'),

  path('prediction/graph/<int:patient_id>/', views.prediction_graph, name='prediction_graph'),
    path('doctor/patient/<int:patient_id>/records/', views.patient_all_details, name='patient_all_details'),
 path('doctor/update/<int:doctor_id>/', views.update_doctor, name='update_doctor'),  # Edit Doctor

    path('model-result/', views.model_result, name='model_result'),

    path('p_view_prescription/<int:id>/', views.p_view_prescription, name='p_view_prescription'),

path('p_view_stress_result/<int:id>/', views.p_view_stress_result, name='p_view_stress_result'),
path('p_view_stress_graph/<int:id>/', views.p_view_stress_graph, name='p_view_stress_graph'),

  path('check_dr_otp/', views.check_dr_otp, name='check_dr_otp'),

  # Leave

  
    path('leave_apply/', views.leave_apply,name="leave_apply"),
    path('leave_list/', views.leave_list,name="leave_list"),
    path('check_leave_exist/', views.check_leave_exist,name="check_leave_exist"),
    path('save_leave_apply', views.save_leave_apply,name="save_leave_apply"),

 path('new_leave_request/', views.new_leave_request,name="new_leave_request"),

path('leave_status/', views.leave_status,name="leave_status"),

path('check_doctor_availability/', views.check_doctor_availability, name='check_doctor_availability'),

path('cancel_appointment', views.cancel_appointment, name='cancel_appointment'),
path('cancel_booking/<int:id>/', views.cancel_booking, name='cancel_booking'),

path('pending_appointments', views.pending_appointments, name='pending_appointments'),

path('get_slots/', views.get_slots, name='get_slots'),

]