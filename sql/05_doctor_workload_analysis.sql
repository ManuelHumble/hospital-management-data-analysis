
/*
Project: Hospital Management Data Analytics
Script: 05_doctor_workload_analysis.sql
Analysis: Doctor Workload

Business Question:
How is recorded appointment volume distributed
among doctors?
What is each doctor's Work Rate?



Important:
Appointment volume does not necessarily equal
completed consultations or clinical productivity.
*/

--Doctor Workload Performance
WITH DoctorPerformance AS
(
    SELECT
        d.doctor_id,
        d.first_name,
        d.last_name,
        d.specialization,
        COUNT(DISTINCT a.appointment_id) AS total_appointments,
        COUNT(t.treatment_id) AS total_treatments,
        SUM(t.cost) AS total_revenue
    FROM doctors AS d
    LEFT JOIN appointments AS a
        ON d.doctor_id = a.doctor_id
    LEFT JOIN treatments AS t
        ON a.appointment_id = t.appointment_id
    GROUP BY
        d.doctor_id,
        d.first_name,
        d.last_name,
        d.specialization
)

SELECT *
FROM DoctorPerformance
ORDER BY total_revenue DESC;

WITH DoctorPerformance AS
(
    SELECT
        d.doctor_id,
        d.first_name,
        d.last_name,
        d.specialization,
        COUNT(DISTINCT a.appointment_id) AS total_appointments,
        SUM(t.cost) AS total_revenue
    FROM doctors AS d
    LEFT JOIN appointments AS a
        ON d.doctor_id = a.doctor_id
    LEFT JOIN treatments AS t
        ON a.appointment_id = t.appointment_id
    GROUP BY
        d.doctor_id,
        d.first_name,
        d.last_name,
        d.specialization
),

PerformanceAverage AS
(
    SELECT
        AVG(total_appointments * 1.0) AS avg_appointments,
        AVG(total_revenue) AS avg_revenue
    FROM DoctorPerformance
)

SELECT
    dp.doctor_id,
    dp.first_name,
    dp.last_name,
    dp.specialization,
    dp.total_appointments,
    dp.total_revenue,

    CASE
        WHEN dp.total_appointments > pa.avg_appointments
             AND dp.total_revenue > pa.avg_revenue
            THEN 'High Workload / High Revenue'

        WHEN dp.total_appointments > pa.avg_appointments
             AND dp.total_revenue <= pa.avg_revenue
            THEN 'High Workload / Low Revenue'

        WHEN dp.total_appointments <= pa.avg_appointments
             AND dp.total_revenue > pa.avg_revenue
            THEN 'Low Workload / High Revenue'

        ELSE 'Low Workload / Low Revenue'
    END AS performance_category

FROM DoctorPerformance AS dp
CROSS JOIN PerformanceAverage AS pa
ORDER BY dp.total_revenue DESC;

