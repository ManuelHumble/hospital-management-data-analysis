# Hospital Management Data Analytics Project
**SQL Server | Healthcare Operations | Business Intelligence**

## 1. Project Overview

This project analyzes a hospital management dataset to investigate patient utilization, appointment demand, doctor workload, specialization activity, hospital branch performance, and operational efficiency.

The objective is to transform structured hospital records into meaningful business insights that can support evidence-based decision-making by hospital administrators and healthcare managers.

SQL Server is used for data exploration, aggregation, analysis, and validation. Power BI will be used separately to develop interactive visualizations and communicate the findings.

## 2. Business Problem

Healthcare organizations generate operational data through patient registrations, appointments, medical treatments, and billing activities. However, raw records do not automatically provide the insights needed to understand service demand, resource distribution, or financial performance.

This project addresses the following business questions:

- Which patients use hospital services most frequently?
- How is appointment demand distributed across doctors and medical specializations?
- How does appointment volume vary across hospital branches?
- How does recorded appointment demand change over time?
- What operational and financial insights can be extracted from treatment and billing records?
- How can data quality and relationship validation support reliable reporting?

## 3. Dataset Description

The project uses a Hospital Management Dataset organized into separate tables.

| Table | Analytical purpose |
|---|---|
| Patients | Patient demographics, registration details, and patient identification |
| Doctors | Doctor profiles, specializations, experience, and hospital branches |
| Appointments | Appointment records, dates, patients, and assigned doctors |
| Treatments | Recorded treatment information and associated costs, where available |
| Billing | Billing records and payment information, where available |

**Relationship considerations:** Patient and doctor records are connected to appointments through their respective identifiers. Doctor-level treatment analysis must follow the appointment relationship because the treatment table does not contain a `doctor_id` field.

All analyses must use the actual columns and relationships in the source workbook.

## 4. Tools and Technologies

- **Microsoft SQL Server Management Studio (SSMS):** Query execution and data analysis.
- **SQL:** Filtering, aggregation, joins, common table expressions, window functions, date functions, and data validation.
- **Microsoft Power BI:** Planned visualization, reporting, and interactive dashboard development.
- **Excel:** Initial organization of the source CSV files into separate worksheets.

## 5. Analytical Methodology

The project follows a business-question-driven analytical workflow.

1. **Data familiarization:** Examine available tables, fields, identifiers, and relationships.
2. **Patient utilization analysis:** Aggregate patient-level activity to investigate service-use frequency and utilization patterns.
3. **Operational analysis:** Compare appointment volumes across doctors, specializations, branches, and months.
4. **Treatment and financial analysis:** Investigate treatment activity, recorded costs, billing outcomes, and financial discrepancies where supported by the available data.
5. **Data validation:** Check record validity, missing values, duplicate records, and consistency across related tables.
6. **Business interpretation:** Translate analytical findings into defensible observations and recommendations.
7. **Visualization:** Develop a Power BI dashboard from validated analytical results.

## 6. Key Analytical Findings

### 6.1 Appointment demand by specialization

The analysis included 200 appointments across three medical specializations.

| Specialization | Appointments | Doctors | Appointments per doctor |
|---|---:|---:|---:|
| Pediatrics | 98 | 5 | 19.6 |
| Dermatology | 70 | 3 | 23.3 |
| Oncology | 32 | 2 | 16.0 |
| **Total** | **200** | **10** | **20.0** |

**Finding:** Pediatrics accounted for 49% of recorded appointments, followed by Dermatology at 35% and Oncology at 16%.

Dermatology had the highest average appointment count per doctor among the three specializations. This difference may warrant further investigation, but appointment counts alone cannot establish differences in productivity, workload intensity, or care quality.

### 6.2 Appointment volume by hospital branch

| Hospital branch | Appointments | Doctors | Appointments per doctor |
|---|---:|---:|---:|
| Central Hospital | 84 | 4 | 21.0 |
| Eastside Clinic | 62 | 3 | 20.7 |
| Westside Clinic | 54 | 3 | 18.0 |
| **Total** | **200** | **10** | **20.0** |

**Finding:** Central Hospital recorded the highest appointment volume, representing 42% of the 200 appointments. Eastside Clinic accounted for 31%, while Westside Clinic accounted for 27%.

Central Hospital also had the highest average appointment count per doctor, although its average was only slightly above Eastside Clinic's.

Management could investigate whether these differences reflect patient demand, staffing arrangements, appointment availability, or differences in service delivery.

### 6.3 Monthly appointment demand

The monthly appointment analysis covered January through December 2023.

| Measure | Result |
|---|---:|
| Total recorded appointments | 200 |
| Monthly average | 16.7 |
| Highest-volume month | April — 25 |
| Lowest-volume month | September — 11 |

**Finding:** April recorded the highest appointment volume, while September recorded the lowest. The monthly distribution varied throughout the year.

Because the available results cover only one year, the analysis cannot establish recurring seasonal patterns.

## 7. Data Quality and Validation

The dataset was reviewed for record validity and suitability for analysis.

**Validation outcome:** All records were confirmed valid based on the checks performed.

The analysis also recognizes that record validity and relationship integrity are different considerations. A valid record can still have a missing relationship, duplicate representation, or an issue affecting a particular calculation. Related-table checks should therefore be documented separately from general record validation.

## 8. Business Recommendations

Based on the verified appointment findings, the following are appropriate areas for further investigation.

**1. Review appointment demand across specializations.**  
Compare appointment volumes with staffing levels, operating hours, and clinical complexity before making resource allocation decisions.

**2. Investigate branch-level differences.**  
Examine whether the differences in appointment volume reflect demand, available appointment slots, staffing schedules, or service availability.

**3. Monitor monthly appointment patterns.**  
Continue monitoring appointment activity over additional years to distinguish normal fluctuations from persistent trends.

**4. Strengthen operational reporting.**  
Use validated SQL outputs and Power BI reporting to help management monitor service activity and identify areas requiring investigation.

These recommendations are preliminary and should be supported by additional evidence before operational changes are implemented.

## 9. Project Limitations

- Appointment volume does not measure clinical outcomes or service quality.
- Appointments recorded in the dataset may not necessarily represent completed consultations.
- Appointment counts per doctor do not account for working hours, appointment duration, or clinical complexity.
- One year of monthly results is insufficient to establish recurring seasonality.
- Financial conclusions require verified billing fields, payment definitions, and reconciled relationships.
- Recommendations about capacity and staffing require additional operational evidence.

## 10. Conclusion

This project demonstrates the application of SQL-based healthcare analytics to investigate patient utilization, appointment demand, specialization activity, and branch-level operations.

The analysis converts raw hospital records into interpretable measures and identifies questions that hospital management can investigate further. It also emphasizes the importance of data validation, correct table relationships, and appropriate interpretation of analytical results.

The next stage is to complete the remaining treatment, billing, and cross-table analyses, then build a Power BI dashboard using validated results.

## 11. Portfolio Deliverables

The completed portfolio should include:

- SQL scripts organized by business question.
- A data dictionary and relationship map.
- Documentation of analytical methods and findings.
- Evidence of data-quality validation.
- A Power BI dashboard based on verified SQL results.
- An executive summary explaining business implications and limitations.
