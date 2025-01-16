-- Section 1: Initial Data Inspection

SELECT *
FROM layoffs;

-- Section 2: Create Staging Table

CREATE TABLE layoffs_staging
LIKE layoffs;

SELECT *
FROM layoffs_staging;

-- Section 3: Insert Data into Staging Table

INSERT INTO layoffs_staging
SELECT *
FROM layoffs;

-- Section 4: Identify Potential Duplicates

SELECT *,
ROW_NUMBER() OVER (
  PARTITION BY company, industry, total_laid_off, percentage_laid_off, `date`
) AS row_num
FROM layoffs_staging;

WITH duplicate_cte AS (
  SELECT *,
  ROW_NUMBER() OVER (
    PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions
  ) AS row_num
  FROM layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

-- Section 5: Create Second Staging Table to Store Cleaned Data

CREATE TABLE `layoffs_staging2` (
  `company` TEXT,
  `location` TEXT,
  `industry` TEXT,
  `total_laid_off` INT DEFAULT NULL,
  `percentage_laid_off` TEXT,
  `date` TEXT,
  `stage` TEXT,
  `country` TEXT,
  `funds_raised_millions` INT DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM layoffs_staging2
WHERE row_num > 1;

-- Section 6: Insert Data into Second Staging Table

INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER (
  PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions
) AS row_num
FROM layoffs_staging;
delete
from layoffs_staging2
WHERE row_num>1;

-- Section 7:Various Transformation and Cleanup Process

select company, trim(company)
from layoffs_staging2;

update layoffs_staging2
set company=trim(company);

select distinct industry
from layoffs_staging2
order by 1;

select *
from layoffs_staging2
where industry like 'crypto%';

update layoffs_staging2
set industry ='Crypto'
where industry like 'Crypto%';

UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE '%.';


select distinct country
from layoffs_staging2
order by 1;

select `date`,
STR_TO_DATE (`date`, '%m/%d/%Y')
from layoffs_staging2;

SELECT DISTINCT `date` FROM layoffs_staging2 LIMIT 10;

update layoffs_staging2
set date = STR_TO_DATE (`date`, '%m/%d/%Y');

alter table layoffs_staging2
modify column `date` DATE;

select *
from layoffs_staging2
where total_laid_off is null;

select *
from layoffs_staging2
where industry is null 
or industry = '';

select *
from layoffs_staging2
where company like 'Bally%';

update layoffs_staging2
set industry= null
where industry = '';

select *
from layoffs_staging2 AS t1
JOIN layoffs_staging2 AS t2
  ON t1.company = t2.company
WHERE t1.industry IS NULL or t1.industry =''
 AND t2.industry IS NOT NULL;


UPDATE layoffs_staging2 AS t1
JOIN layoffs_staging2 AS t2
  ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
 AND t2.industry IS NOT NULL;
 
 select *
 from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

delete 
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

 select *
 from layoffs_staging2;
 
 alter table layoffs_staging2
 drop column row_num;
