Exploratory Data Analysis (EDA) of Layoffs Dataset

About This Analysis
This exploratory data analysis (EDA) aims to uncover insights from the `layoffs` dataset by cleaning, transforming, and analyzing records of layoffs across different companies, industries, and countries. The process includes data preparation, deduplication, formatting, and trend analysis to extract meaningful insights.

Objectives
- Inspect and understand the raw dataset.
- Clean and standardize the data to improve accuracy.
- Identify and remove duplicate records.
- Transform and format data for consistency.
- Analyze layoffs across industries, countries, and time periods.
- Identify trends and patterns in layoffs over time.

Key Analyses Conducted

1. Initial Data Inspection
- Loaded the dataset to review its structure and contents.
- Created a staging table (`layoffs_staging`) as a copy of the original dataset to ensure data integrity.

2. Data Cleaning and Deduplication
- Identified potential duplicate records based on company, industry, total layoffs, percentage laid off, and date.
- Created a second staging table (`layoffs_staging2`) to store cleaned data.
- Removed duplicate records to ensure data accuracy.

3. Data Standardization and Formatting
- Trimmed whitespace from company names to maintain consistency.
- Standardized industry names (e.g., consolidating variations of "Crypto").
- Removed trailing periods from country names.
- Converted date formats to SQL date type for accurate time-based analysis.

4. Handling Missing Values
- Identified and updated missing industry values by referencing existing company records.
- Removed records with null values in both `total_laid_off` and `percentage_laid_off` to maintain data integrity.

5. Final Data Refinements
- Ensured consistency in key attributes like company names, industry classifications, and date formats.
- Dropped the `row_num` column after deduplication was completed.

6. Layoff Analysis and Trends
- Conducted exploratory queries to analyze layoffs across different dimensions such as:
  - Layoffs by company, industry, and country.
  - Trends over time (daily, monthly, yearly).
  - Rolling totals and cumulative impact.
  - Business stage impact on layoffs.
  - Ranking of top companies impacted each year.

Methodology
This analysis was conducted using SQL, leveraging staging tables for data transformation. The cleaning process included deduplication, standardization, missing value handling, and column format adjustments. Aggregations, ranking functions, and date transformations were applied to extract meaningful insights.

Conclusion
This EDA ensures that the dataset is clean, structured, and optimized for analysis. By identifying trends in layoffs across industries, countries, and time periods, this project provides valuable insights into the impact of layoffs and their patterns over time. The findings can be useful for economic analysis, workforce planning, and business decision-making.

