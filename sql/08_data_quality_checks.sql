--Objective: Data validation, cleansing, and sanity checks
SELECT
    TABLE_NAME,
    COLUMN_NAME,
    DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
ORDER BY TABLE_SCHEMA


--- No financial and Operational Issues found
SELECT
    payment_status,
    COUNT(*) AS total_bills,
    SUM(amount) AS total_billed_amount,
    SUM(
        CASE
            WHEN payment_status IN ('Pending', 'Failed')
            THEN amount
            ELSE 0
        END
    ) AS amount_pending_or_failed
FROM billing
GROUP BY payment_status
ORDER BY amount_pending_or_failed DESC;

-- all hospital records are complete 

SELECT
    d.hospital_branch,
    COUNT(a.appointment_id) AS total_appointments,
    COUNT(DISTINCT d.doctor_id) AS number_of_doctors,
    CAST(
        COUNT(a.appointment_id) * 1.0 /
        NULLIF(COUNT(DISTINCT d.doctor_id), 0)
        AS DECIMAL(10,2)
    ) AS appointments_per_doctor
FROM doctors AS d
LEFT JOIN appointments AS a
    ON d.doctor_id = a.doctor_id
GROUP BY
    d.hospital_branch
ORDER BY
    total_appointments DESC;


---Is there inconsistency in the Dataset
----No missing Values Found
SELECT
    'patients' AS table_name,
    COUNT(*) AS total_records,
    SUM(CASE WHEN patient_id IS NULL THEN 1 ELSE 0 END)
        AS missing_patient_ids,
    SUM(CASE WHEN date_of_birth IS NULL THEN 1 ELSE 0 END)
        AS missing_dates_of_birth,
    SUM(CASE WHEN gender IS NULL THEN 1 ELSE 0 END)
        AS missing_gender
FROM patients

UNION ALL

SELECT
    'appointments',
    COUNT(*),
    SUM(CASE WHEN appointment_id IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN patient_id IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN appointment_date IS NULL THEN 1 ELSE 0 END)
FROM appointments;
