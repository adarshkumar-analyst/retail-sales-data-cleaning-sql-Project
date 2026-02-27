📊 **Retail Store Sales Data Cleaning Project**

📌 Project Overview

This project focuses on cleaning and standardizing a raw retail sales dataset using MySQL.

The dataset was initially imported in raw format, and a structured data cleaning workflow was applied to ensure data quality, consistency, and readiness for analysis.

🏗️ Data Import Strategy (Staging Approach)

Instead of directly importing the CSV file with predefined data types, a staging table was created manually with all columns defined as VARCHAR.

This approach helped:

Prevent datatype mismatch errors during import

Handle inconsistent raw data formats

Perform controlled data cleaning before standardization

Data was imported using MySQL Workbench Import Wizard, and transformations were applied afterward.


🧹 Data Cleaning Steps Performed
1️⃣ Initial Data Inspection

Checked total record count

Examined table structure

Identified NULL and blank values

2️⃣ Handling Missing & Blank Values

Converted empty strings to NULL

Replaced missing Item values with 'Unknown'

Removed rows with missing Price_Per_Unit or Quantity

Recalculated missing Total_Spent

Standardized Discount_Applied values

3️⃣ Data Type Standardization

Converted:

Price_Per_Unit → DECIMAL(10,2)

Quantity → INT

Total_Spent → DECIMAL(10,2)

Converted Transaction_Date from VARCHAR to proper DATE format (DD-MM-YYYY → YYYY-MM-DD)

4️⃣ Data Validation

Verified calculated totals

Checked for inconsistent records

Ensured no unintended NULL values

Optimized table structure


🛠️ Technologies Used

MySQL

MySQL Workbench

SQL (Data Cleaning & Validation)


🎯 Key Learning Outcomes

Implemented staging table strategy for raw data import

Performed structured data cleaning workflow

Handled date format inconsistencies

Applied data validation techniques

Standardized numeric and categorical data


📂 Final Dataset Status

The dataset is now:

Clean

Standardized

Validated

Ready for analysis or dashboard development


🚀 Next Steps

This cleaned dataset can now be used for:

Exploratory Data Analysis (EDA)

Business Insights Generation

Power BI / Tableau Dashboard Development

## 👤 Author

Adarsh Kumar 
Data Analyst | SQL | Excel | Power BI | Data Cleaning & Transformation  

Passionate about transforming raw data into structured,
analysis-ready datasets using SQL-based workflows.
