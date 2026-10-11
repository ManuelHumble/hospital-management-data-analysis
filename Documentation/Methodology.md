# Methodology & Analytical Process

## Phase 1: Data Ingestion and Setup

- **Data Source:** Hospital Management Dataset containing five core tables: `patients`, `doctors`, `appointments`, `billing`, and `treatments`.
- **Initial Preparation:** Imported the supplied CSV files into Microsoft Excel, with each table organized in a separate worksheet.
- **SQL Environment:** Imported the data into SQL Server and executed analytical queries using SQL Server Management Studio (SSMS).

## Phase 2: Data Familiarization

Reviewed the available tables and columns to understand the dataset structure, identify relevant fields, and determine the relationships required for analysis.
----------------------------------------------------------------------------------
## Phase 3: Data Structure Documentation

### 3.1 Establishing Table Relationships

![Creating Relationships](..Creating_Relationship.png)

The relationships between the five core tables were examined and documented by identifying primary keys (PKs), foreign keys (FKs), and the connections between related entities.

### 3.2 Documenting the Initial Structure

![Tables Before Relationships](..data-dictionary/No_Relationship.png)

The initial table structure was reviewed to understand how the dataset was organized before documenting the relationships between the tables.

### 3.3 Data Dictionary and Relationship Mapping

Prepared a data dictionary documenting all five tables, their columns, primary keys (PKs), foreign keys (FKs), and relationship types.

A database schema diagram was prepared to provide a visual reference for the documented table relationships.






## Phase 3: Data Structure Documentation

![SQL Query](..Creating_Relationship.png)

Prepared a data dictionary documenting all five tables, their columns, primary keys (PKs), foreign keys (FKs), and relationships.
![Non Structured Data](..data-dictionary/No_Relationship.png)

A database schema diagram to illustrate the documented relationships.

![Database Schema](../data-dictionary/Structured%20Schema.png)

## Phase 4: Data Validation and Preprocessing

Reviewed the dataset for data quality issues that could affect the accuracy of the analysis.

Validation activities included examining data types, checking key fields, investigating potential duplicate records, and assessing the consistency of relationships between tables.

Data cleaning and transformation steps are documented only where they were actually performed and validated.

## Phase 5: Data Modeling and Relationship Analysis

Documented the relationships among the five core tables:

- `patients`
- `doctors`
- `appointments`
- `billing`
- `treatments`

Primary and foreign key relationships were examined to support accurate joins and reliable analysis. The documented structure was used to guide the development of SQL queries and reduce the risk of duplicated counts or incorrect aggregations.

## Phase 6: Exploratory Data Analysis and SQL Business Analysis

Developed SQL scripts to investigate business questions relating to patient utilization, appointment activity, treatment records, and billing performance.

Analytical techniques included:

- Filtering and sorting
- Table joins
- Grouping and aggregate functions
- Date calculations
- Common Table Expressions (CTEs)
- Window functions and ranking, where appropriate
- Data validation and analytical checks

SQL scripts were organized into separate files according to their analytical focus.

## Phase 7: Business Interpretation and Recommendations

Interpreted query results in the context of hospital operations and management.

Findings and recommendations are based on verified analytical results. Limitations in the available data are acknowledged, and conclusions are not drawn where the dataset does not provide sufficient evidence.

## Phase 8: Visualization and Reporting with Power BI

Developed a Power BI dashboard and supporting report pages to communicate verified analytical findings.

The reports focus on relevant patterns in patient utilization, appointment activity, treatments, and billing, where supported by the available data.

Dashboard metrics are checked against SQL query results to maintain consistency between the analysis and the visual reports.

## Tools and Technologies

| Tool | Purpose |
|---|---|
| Microsoft Excel | Initial dataset organization and inspection |
| SQL Server Management Studio (SSMS) | SQL querying, joins, aggregations, and validation |
| Microsoft Power BI | Dashboard development and data visualization |
| GitHub | Source control, documentation, and portfolio presentation |

## Project Deliverables

- Documented data dictionary and database schema diagram.
- Organized SQL scripts addressing hospital management business questions.
- Data validation queries and documented observations.
- Evidence-based analytical findings and recommendations.
- Power BI dashboard supported by verified metrics.
- GitHub repository presenting the methodology, SQL scripts, and project findings.

---

**Project:** Hospital Management Analytics  
**Primary Analytical Tool:** Microsoft SQL Server  
**Reporting Tool:** Microsoft Power BI  
**Documentation Status:** Updated as analysis and validation progress.
