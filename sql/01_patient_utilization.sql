
/*
Project: Hospital Management Data Analytics
Analysis: Patient Service Utilization
Business Question:
Which patients have the highest recorded appointment frequency?

Metrics:
1. Total recorded appointments
2. First recorded appointment date
3. Most recent recorded appointment date

Note: Appointment records do not necessarily represent
completed consultations.
*/

SELECT
    p.patient_id,
    p.first_name,
    p.last_name,
    COUNT(a.appointment_id) AS total_appointments,
    MIN(a.appointment_date) AS first_appointment_date,
    MAX(a.appointment_date) AS most_recent_appointment_date
FROM patients AS p
LEFT JOIN appointments AS a
    ON p.patient_id = a.patient_id
GROUP BY
    p.patient_id,
    p.first_name,
    p.last_name
ORDER BY
    total_appointments DESC,
    most_recent_appointment_date DESC;

--Patient Demographic data and Number of visits
SELECT
    p.patient_id,
    p.first_name,
    p.last_name,
    p.gender,
    p.date_of_birth,
      DATEDIFF(YEAR, P.date_of_birth,GETDATE()) AS age,
    COUNT(a.appointment_id) AS total_appointments
FROM patients AS p
LEFT JOIN appointments AS a
    ON p.patient_id = a.patient_id
GROUP BY
    p.patient_id,
    p.first_name,
    p.last_name,
    p.gender,
    p.date_of_birth
ORDER BY total_appointments DESC;
