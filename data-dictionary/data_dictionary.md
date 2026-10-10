# Hospital Management Analytics — Data Dictionary

## 1. Project Overview

This document describes the five tables in the Hospital Management dataset, their columns, primary keys, foreign keys, and relationships.

The purpose of the data dictionary is to establish a clear understanding of the database structure before performing SQL analysis and developing Power BI dashboards.

### Tables covered

1. `patients`
2. `doctors`
3. `appointments`
4. `treatments`
5. `billing`

## 2. Key Definitions

| Term | Definition |
|---|---|
| Primary Key (PK) | A column that uniquely identifies each record in a table. |
| Foreign Key (FK) | A column that references a key in another table to establish a relationship. |
| One-to-One (1:1) | One record in a table relates to one record in another table. |
| One-to-Many (1:M) | One record in a parent table can relate to multiple records in a child table. |
| Many-to-Many (M:M) | Multiple records in one table can relate to multiple records in another table. |

## 3. Table: `patients`

**Purpose:** Stores patient demographic, contact, registration, and insurance information.

| Column | Key | Description |
|---|---|---|
| `patient_id` | PK | Unique identifier for each patient. |
| `first_name` | — | Patient's first name. |
| `last_name` | — | Patient's last name. |
| `gender` | — | Patient's recorded gender. |
| `date_of_birth` | — | Patient's date of birth. |
| `contact_number` | — | Patient's contact telephone number. |
| `address` | — | Patient's recorded address. |
| `registration_date` | — | Date the patient registered with the hospital. |
| `insurance_provider` | — | Name of the patient's insurance provider. |
| `insurance_number` | — | Patient's insurance identification number. |
| `email` | — | Patient's email address. |

**Primary key:** `patient_id`

**Foreign keys:** None identified in this table.

## 4. Table: `doctors`

**Purpose:** Stores doctor identification, professional specialization, experience, contact, and hospital branch information.

| Column | Key | Description |
|---|---|---|
| `doctor_id` | PK | Unique identifier for each doctor. |
| `first_name` | — | Doctor's first name. |
| `last_name` | — | Doctor's last name. |
| `specialization` | — | Doctor's medical specialization. |
| `phone_number` | — | Doctor's contact telephone number. |
| `years_experience` | — | Recorded years of professional experience. |
| `hospital_branch` | — | Hospital branch associated with the doctor. |
| `email` | — | Doctor's email address. |

**Primary key:** `doctor_id`

**Foreign keys:** None identified in this table.

## 5. Table: `appointments`

**Purpose:** Records patient appointments, assigned doctors, appointment dates and times, reasons for visits, and appointment statuses.

| Column | Key | Description |
|---|---|---|
| `appointment_id` | PK | Unique identifier for each appointment. |
| `patient_id` | FK | Identifies the patient associated with the appointment. |
| `doctor_id` | FK | Identifies the doctor assigned to the appointment. |
| `appointment_date` | — | Scheduled or recorded appointment date. |
| `appointment_time` | — | Scheduled or recorded appointment time. |
| `reason_for_visit` | — | Recorded reason for the visit. |
| `status` | — | Appointment status, as recorded in the dataset. |

**Primary key:** `appointment_id`

**Foreign keys:**
- `patient_id` references `patients.patient_id`.
- `doctor_id` references `doctors.doctor_id`.

## 6. Table: `treatments`

**Purpose:** Records treatments associated with appointments, including treatment type, description, cost, and treatment date.

| Column | Key | Description |
|---|---|---|
| `treatment_id` | PK | Unique identifier for each treatment record. |
| `appointment_id` | FK | Identifies the appointment associated with the treatment. |
| `treatment_type` | — | Category or type of treatment provided. |
| `description` | — | Description of the treatment. |
| `cost` | — | Recorded cost of the treatment. |
| `treatment_date` | — | Date the treatment was recorded as occurring. |

**Primary key:** `treatment_id`

**Foreign key:**
- `appointment_id` references `appointments.appointment_id`.

**Important relationship note:** The `treatments` table does not contain a `doctor_id` column. To analyze treatments by doctor, the relationship must be traced through `appointments`:

`doctors → appointments → treatments`

## 7. Table: `billing`

**Purpose:** Stores billing records associated with patients and treatments, including amounts, billing dates, payment methods, and payment statuses.

| Column | Key | Description |
|---|---|---|
| `bill_id` | PK | Unique identifier for each billing record. |
| `patient_id` | FK | Identifies the patient associated with the bill. |
| `treatment_id` | FK | Identifies the treatment associated with the bill. |
| `bill_date` | — | Date the bill was recorded. |
| `amount` | — | Amount recorded on the bill. |
| `payment_method` | — | Recorded method of payment. |
| `payment_status` | — | Recorded payment status. |

**Primary key:** `bill_id`

**Foreign keys:**
- `patient_id` references `patients.patient_id`.
- `treatment_id` references `treatments.treatment_id`.

## 8. Primary and Foreign Key Summary

| Table | Primary Key | Foreign Keys |
|---|---|---|
| `patients` | `patient_id` | None identified |
| `doctors` | `doctor_id` | None identified |
| `appointments` | `appointment_id` | `patient_id`, `doctor_id` |
| `treatments` | `treatment_id` | `appointment_id` |
| `billing` | `bill_id` | `patient_id`, `treatment_id` |

## 9. Relationship Map

The database relationships are represented below.

```text
PATIENTS
  |
  | 1:M
  v
APPOINTMENTS <--------- DOCTORS
  |                       ^
  |                       |
  | 1:M                   | 1:M
  v                       |
TREATMENTS                 |
  |                       |
  |                       |
  | 1:M                   |
  v                       |
BILLING ------------------+
```

The direct relationships represented by the schema are:

```text
patients.patient_id
    → appointments.patient_id

doctors.doctor_id
    → appointments.doctor_id

appointments.appointment_id
    → treatments.appointment_id

patients.patient_id
    → billing.patient_id

treatments.treatment_id
    → billing.treatment_id
```

The arrows above indicate key references, not necessarily enforced database constraints.

## 10. Relationship Types and Cardinality

| Parent Table | Parent Key | Child Table | Foreign Key | Relationship |
|---|---|---|---|---|
| `patients` | `patient_id` | `appointments` | `patient_id` | One-to-many (1:M) |
| `doctors` | `doctor_id` | `appointments` | `doctor_id` | One-to-many (1:M) |
| `appointments` | `appointment_id` | `treatments` | `appointment_id` | One-to-many (1:M) |
| `patients` | `patient_id` | `billing` | `patient_id` | One-to-many (1:M) |
| `treatments` | `treatment_id` | `billing` | `treatment_id` | One-to-many (1:M) |

### Interpretation of the relationships

**1. Patients and appointments — 1:M**

A patient can have multiple appointments over time. Each appointment is associated with a patient through `appointments.patient_id`.

**2. Doctors and appointments — 1:M**

A doctor can be associated with multiple appointments. Each appointment references a doctor through `appointments.doctor_id`.

**3. Appointments and treatments — 1:M**

An appointment can have multiple treatment records. Each treatment references its appointment through `treatments.appointment_id`.

**4. Patients and billing — 1:M**

A patient can have multiple billing records. Each billing record identifies its patient through `billing.patient_id`.

**5. Treatments and billing — 1:M**

A treatment can be associated with multiple billing records under the modeled relationship. Each bill references a treatment through `billing.treatment_id`. Actual billing behavior should be validated against the records.

## 11. Indirect Relationship: Doctors and Treatments

There is no direct foreign-key relationship between `doctors` and `treatments`.

The connection is established through the appointments table:

```text
doctors.doctor_id
    → appointments.doctor_id

appointments.appointment_id
    → treatments.appointment_id
```

This allows treatment analysis by doctor using joins across the three tables.

**Project:** Hospital Management Analytics  
**Documentation file:** `data-dictionary/data_dictionary.md`  
**Purpose:** Establish the dataset structure and relational model for SQL analysis, business findings, and Power BI reporting.
