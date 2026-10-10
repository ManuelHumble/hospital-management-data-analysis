Use [Health Project]
--How many appointments did the hospital have?
SELECT
    COUNT(*) AS total_appointments
FROM appointments;

-- What was the status of those appointments?
SELECT
    status,
    COUNT(*) AS appointment_count
FROM appointments
GROUP BY status
ORDER BY appointment_count DESC;

--What percentage of appointments were completed, cancelled, or missed?
SELECT
    status,
    COUNT(*) AS appointment_count,
    CAST(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER ()
        AS DECIMAL(5,2)
    ) AS percentage_of_appointments
FROM appointments
GROUP BY status
ORDER BY appointment_count DESC;

