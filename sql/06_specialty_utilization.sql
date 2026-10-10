

/*
Project: Hospital Management Data Analytics
Script: 06_specialty_utilization.sql
Analysis: Specialty Utilization

Business Question:
Which medical specialties account for the highest
recorded appointment volume?
Which medical specialties account for the highest for the highest Revenue? 

Approach:
Join doctors to appointments, billing and aggregate
appointment records by specialization.

Important:
Appointment volume measures recorded demand,
not necessarily completed consultations,
clinical outcomes, or staffing adequacy.
*/


SELECT
    d.specialization,
    COUNT(a.appointment_id) AS total_appointments,
    COUNT(DISTINCT d.doctor_id) AS number_of_doctors,
    SUM(b.amount)               AS Total_Revenue
    
FROM doctors AS d
LEFT JOIN appointments AS a
    ON d.doctor_id = a.doctor_id
JOIN billing b 
    ON b.patient_id =a.patient_id
GROUP BY
    d.specialization
ORDER BY
    total_appointments DESC;
