
/*
Project: Hospital Management Data Analytics
Script: 05_doctor_workload_analysis.sql
Analysis: Doctor Workload

Business Question:
How is recorded appointment volume distributed
among doctors?
What is each doctor's Work Rate?
How does each doctor's revenue rank against other doctors, and what % do they contribute to revenue?



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

--How does each doctor's revenue rank against other doctors, and what % do they contribute to revenue?
WITH DoctorRevenue AS (
    SELECT 
        d.doctor_id,
        CONCAT(d.first_name, ' ', d.last_name) AS doctor_name,
        d.specialization,
        ISNULL(SUM(b.amount), 0) AS total_revenue
    FROM dbo.doctors d
    LEFT JOIN dbo.appointments a 
        ON d.doctor_id = a.doctor_id
    LEFT JOIN dbo.treatments t 
        ON a.appointment_id = t.appointment_id
    LEFT JOIN dbo.billing b 
        ON t.treatment_id = b.treatment_id
    GROUP BY 
        d.doctor_id, 
        d.first_name, 
        d.last_name, 
        d.specialization
)
SELECT 
    doctor_id,
    doctor_name,
    specialization,
    total_revenue,
    DENSE_RANK() OVER (ORDER BY total_revenue DESC) AS revenue_rank,
    -- Calculates percentage contribution to grand total revenue
    ROUND(
        (total_revenue * 100.0) / NULLIF(SUM(total_revenue) OVER (), 0), 
        2
    ) AS pct_of_total_revenue
FROM DoctorRevenue
ORDER BY 
    revenue_rank ASC;

