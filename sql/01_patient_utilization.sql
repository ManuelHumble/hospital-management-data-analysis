
/*
Project: Hospital Management Data Analytics
Analysis: Patient Service Utilization
Business Question:
Which patients have the highest recorded appointment frequency?
Which Gender Visits Most
Which Age Group Visits Most 


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

-----Utilization by Age Group
SELECT
    CASE
        WHEN DATEDIFF(YEAR, p.date_of_birth, GETDATE()) < 18
            THEN 'Under 18'
        WHEN DATEDIFF(YEAR, p.date_of_birth, GETDATE()) BETWEEN 18 AND 34
            THEN '18–34'
        WHEN DATEDIFF(YEAR, p.date_of_birth, GETDATE()) BETWEEN 35 AND 49
            THEN '35–49'
        WHEN DATEDIFF(YEAR, p.date_of_birth, GETDATE()) BETWEEN 50 AND 64
            THEN '50–64'
        ELSE '65+'
    END AS age_group,

    COUNT(a.appointment_id) AS total_appointments,
    COUNT(DISTINCT a.patient_id) AS unique_patients,

    CAST(
        COUNT(a.appointment_id) * 1.0 /
        COUNT(DISTINCT a.patient_id)
        AS DECIMAL(10,2)
    ) AS appointments_per_patient

FROM appointments AS a
INNER JOIN patients AS p
    ON a.patient_id = p.patient_id

GROUP BY
    CASE
        WHEN DATEDIFF(YEAR, p.date_of_birth, GETDATE()) < 18
            THEN 'Under 18'
        WHEN DATEDIFF(YEAR, p.date_of_birth, GETDATE()) BETWEEN 18 AND 34
            THEN '18–34'
        WHEN DATEDIFF(YEAR, p.date_of_birth, GETDATE()) BETWEEN 35 AND 49
            THEN '35–49'
        WHEN DATEDIFF(YEAR, p.date_of_birth, GETDATE()) BETWEEN 50 AND 64
            THEN '50–64'
        ELSE '65+'
    END

ORDER BY total_appointments DESC;

--Which genders account for the greatest hospital utilization?
SELECT
    p.gender,
    COUNT(a.appointment_id) AS total_appointments,
    COUNT(DISTINCT a.patient_id) AS unique_patients,

    CAST(
        COUNT(a.appointment_id) * 1.0 /
        COUNT(DISTINCT a.patient_id)
        AS DECIMAL(10,2)
    ) AS appointments_per_patient

FROM appointments AS a
INNER JOIN patients AS p
    ON a.patient_id = p.patient_id

GROUP BY
    p.gender

ORDER BY
    total_appointments DESC;



