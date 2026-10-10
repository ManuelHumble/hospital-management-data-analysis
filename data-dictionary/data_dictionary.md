# Hospital Management Analytics — Data Dictionary

## 1. Project Overview

This document describes the tables, columns, data types, business meanings, and relationships in the Hospital Management dataset used for this analytics project.

The purpose is to establish a clear understanding of the available data before performing SQL analysis and building Power BI dashboards.

## 2. Data Sources

The dataset was provided as multiple CSV files and imported into an Excel workbook, with each CSV represented on a separate worksheet.

The database analysis uses the actual tables and columns available in the source dataset.

## 3. Table Inventory

| patients | Stores patient demographic and registration information. |
| doctors | Stores doctor details and professional information. |
| appointments | Stores appointment records and links patients with doctors. |


## 4. Patients Table

| patient_id | Identifier for a patient. |
| first_name | Patient's first name. |
| last_name | Patient's last name. |
| gender | Patient's recorded gender. |
| date_of_birth | Patient's date of birth. |
| contact_number | Patient's contact number. |
| address | Patient's recorded address. |
| registration_date | Date the patient registered with the hospital. |
| insurance_provider | Patient's insurance provider. |
| insurance_number | Patient's insurance identification number. |
| email | Patient's email address. |


## 5. Doctors Table

| doctor_id | Identifier for a doctor. |
| first_name | Doctor's first name. |
| last_name | Doctor's last name. |
| specialization | Doctor's medical specialization. |
| phone_number | Doctor's phone number. |
| years_experience | Doctor's years of professional experience. |
| hospital_branch | Hospital branch associated with the doctor. |
| email | Doctor's email address. |


## 6. Appointments Table

| appointment_id | Identifier for an appointment. |
| patient_id | Patient identifier associated with the appointment. |
| doctor_id | Doctor identifier associated with the appointment. |
| appointment_date | Date of the appointment. |
| appointment_time | Scheduled appointment time. |
| reason_for_visit | Recorded reason for the visit. |


## 7. Billing table 

1	bill_id	Unique identifier for each bill.
2	patient_id	Identifier of the patient associated with the bill.
3	treatment_id	Identifier of the treatment associated with the bill.
4	bill_date	Date the bill was recorded.
5	amount	Amount billed.
6	payment_method	Method used to make payment.
7	payment_status	Recorded status of the payment.

## 8. Table Relationships

| Primary/Referenced Table | Key | Related Table | Relationship |
|---|---|---|---|
No.	Primary/referenced table	Foreign key table	Relationship
1	patients.patient_id	appointments.patient_id	One-to-many
2	doctors.doctor_id	appointments.doctor_id	One-to-many
3	appointments.appointment_id	treatments.appointment_id	One-to-many
4	patients.patient_id	billing.patient_id	One-to-many
5	treatments.treatment_id	billing.treatment_id	One-to-many


