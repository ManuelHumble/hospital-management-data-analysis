
/*
Project: Hospital Management Data Analytics
Script: 04_patient_visit_intervals.sql
Analysis: Patient Visit Intervals

Business Question:
How much time passes between consecutive recorded
appointments for each patient?

Approach:
Use LAG() to compare each appointment date with
the previous recorded appointment date.

Important:
An appointment is not necessarily a completed visit.
Multiple appointments on the same date produce a
zero-day interval.
*/

WITH PatientAppointmentHistory AS (
    SELECT
        patient_id,
        appointment_id,
        appointment_date,
        LAG(appointment_date) OVER (
            PARTITION BY patient_id
            ORDER BY appointment_date, appointment_id
        ) AS previous_appointment_date
    FROM appointments
    WHERE appointment_date IS NOT NULL
)
SELECT
    patient_id,
    appointment_id,
    previous_appointment_date,
    appointment_date AS current_appointment_date,
    DATEDIFF(
        DAY,
        previous_appointment_date,
        appointment_date
    ) AS days_between_appointments
FROM PatientAppointmentHistory
WHERE previous_appointment_date IS NOT NULL
ORDER BY
    patient_id,
    appointment_date,
    appointment_id;


---Which patients have the longest history of interaction with the hospital?

SELECT
    p.patient_id,
    p.first_name,
    p.last_name,
    COUNT(a.appointment_id) AS total_appointments,
    MIN(a.appointment_date) AS first_appointment,
    MAX(a.appointment_date) AS most_recent_appointment,
    DATEDIFF(DAY, MIN(a.appointment_date),MAX(a.appointment_date)) AS Utilization_days
FROM patients AS p
LEFT JOIN appointments AS a
    ON p.patient_id = a.patient_id
GROUP BY
    p.patient_id,
    p.first_name,
    p.last_name
ORDER BY Utilization_days DESC;

--Which patients have visited the hospital frequently enough to be considered high-utilization patients?
--I'm using 5+ appointments as our working threshold.
SELECT
    patient_id,
    COUNT(appointment_id) AS total_appointments,
    MIN(appointment_date) AS first_visit,
    MAX(appointment_date) AS most_recent_visit
FROM appointments
GROUP BY patient_id
HAVING COUNT(appointment_id) >= 5
ORDER BY total_appointments DESC;

----===Patient Recency grouped based on active Days since last visit====----	
--Patient status is grouped into 
--0–90	Active
--91–180	Moderately Active
--181+	Inactive
SELECT
    patient_id,
    COUNT(appointment_id) AS total_appointments,
    MIN(appointment_date) AS first_visit,
    MAX(appointment_date) AS most_recent_visit,
    DATEDIFF(
        DAY,
        MAX(appointment_date),
        (SELECT MAX(appointment_date) FROM appointments)
    ) AS days_since_last_visit,
 CASE
        WHEN DATEDIFF(
            DAY,
            MAX(appointment_date),
            (SELECT MAX(appointment_date) FROM appointments)
        ) <= 90 THEN 'Active'

        WHEN DATEDIFF(
            DAY,
            MAX(appointment_date),
            (SELECT MAX(appointment_date) FROM appointments)
        ) <= 180 THEN 'Moderately Active'

        ELSE 'Inactive'
    END AS patient_status
FROM appointments
GROUP BY patient_id
ORDER BY days_since_last_visit ASC;

---Patient Activity Summary
SELECT
    patient_status,
    COUNT(*) AS patient_count,
    CAST(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER ()
        AS DECIMAL(5,2)
    ) AS patient_percentage
FROM (
    SELECT
        patient_id,
        CASE
            WHEN DATEDIFF(
                DAY,
                MAX(appointment_date),
                (SELECT MAX(appointment_date) FROM appointments)
            ) <= 90 THEN 'Active'

            WHEN DATEDIFF(
                DAY,
                MAX(appointment_date),
                (SELECT MAX(appointment_date) FROM appointments)
            ) <= 180 THEN 'Moderately Active'

            ELSE 'Inactive'
        END AS patient_status
    FROM appointments
    GROUP BY patient_id
) AS patient_activity
GROUP BY patient_status
ORDER BY patient_percentage DESC;

----How is hospital utilization distributed across the patient population?
--divides patients into 5 equal groups based on appointment frequency

WITH patient_utilization AS (
    SELECT
        patient_id,
        COUNT(appointment_id) AS total_appointments
    FROM appointments
    GROUP BY patient_id
),
ranked_patients AS (
    SELECT
        patient_id,
        total_appointments,
        NTILE(5) OVER (
            ORDER BY total_appointments DESC
        ) AS utilization_group
    FROM patient_utilization
)
SELECT
    utilization_group,
    COUNT(*) AS patient_count,
    SUM(total_appointments) AS appointment_count,
    CAST(
        SUM(total_appointments) * 100.0 /
        SUM(SUM(total_appointments)) OVER ()
        AS DECIMAL(5,2)
    ) AS appointment_percentage,
    CAST(
        AVG(total_appointments * 1.0)
        AS DECIMAL(10,2)
    ) AS avg_appointments_per_patient
FROM ranked_patients
GROUP BY utilization_group
ORDER BY utilization_group;

