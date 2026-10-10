
/*
Project: Hospital Management Data Analytics
Script: 03_appointment_trends.sql
Analysis: Appointment Trends

Business Question:
How does recorded appointment volume change over time?

Approach:
Group appointment records by year and month
to identify changes in recorded demand.
This Dataset has just one year

Important:
This analysis counts appointment records, not
necessarily completed consultations.
*/

SELECT
    YEAR(appointment_date) AS appointment_year,
    MONTH(appointment_date) AS appointment_month,
    COUNT(appointment_id) AS total_appointments
FROM appointments
WHERE appointment_date IS NOT NULL
GROUP BY
    YEAR(appointment_date),
    MONTH(appointment_date)
ORDER BY
    appointment_year,
    appointment_month;

