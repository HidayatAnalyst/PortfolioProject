
---- data cleaning ---

select *
from layoffs;

CREATE TABLE layoffs1
LIKE layoffs;

INSERT layoffs1
select *
from layoffs;

---- 1. remove duplicate
---- 2. standradize the data
---- 3. null values and blannk values
---- 4. remove any columns

--- remove duplicates ---

WITH DUPLICATE_CTE AS 
(SELECT*, ROW_NUMBER() OVER(PARTITION BY company,location,total_laid_off,percentage_laid_off,
`date`,stage,country,funds_raised_millions) AS row_num
from layoffs1
)
select *
from DUPLICATE_CTE
where row_num>1;

CREATE TABLE `layoffs2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


select *
from layoffs2;

INSERT INTO layoffs2
(SELECT*, ROW_NUMBER() OVER(PARTITION BY company,location,total_laid_off,percentage_laid_off,
`date`,stage,country,funds_raised_millions) AS row_num
from layoffs1
);

SELECT *
from layoffs2
WHERE row_num >1;

DELETE 
from layoffs2
WHERE row_num >1;

SELECT *
from layoffs2;

------     -MOVING TOWARDS COMPANY COLUMN-

SELECT DISTINCT COMPANY
from layoffs2
;

SELECT  COMPANY, TRIM(company)
from layoffs2
;

UPDATE layoffs2
SET company= TRIM(company);

SELECT *
from layoffs2;


--- location column is fine---

--- now on industr---
SELECT distinct industry
from layoffs2
order by 1;

SELECT industry
from layoffs2
where industry LIKE 'crypto%'
order by 1;

UPDATE layoffs2
SET industry = 'Crypto'
where industry LIKE 'crypto%';


select *
from layoffs2;

--- move towards country column--- 

select  distinct Country
from layoffs2
order by 1
;


select  distinct Country, TRIM(TRAILING '.' FROM country)
from layoffs2
where country LIKE 'united states%'
order by 1
;

UPDATE layoffs2
SET country = 'United states'
where country LIKE 'united states%';

--- null and blank values ---

select *
from layoffs2;

select *
from layoffs2
where industry is null 
or industry='';

select *
from layoffs2
WHERE company ='Airbnb';

select t1.industry, t2.industry 
from layoffs2 t1
JOIN layoffs2 t2
	ON t1.company= t2.company
where (t1.industry is null or industry ='')
and t2.industry is not null;

UPDATE layoffs2
SET industry = NULL
where industry= '';

UPDATE layoffs2 t1
JOIN layoffs2 t2
	ON t1.company= t2.company
SET t1.industry= t2.industry
where t1.industry is NULL
and t2.industry is not null;

 
select *
from layoffs2
where total_laid_off is null and 
percentage_laid_off is null;

delete
from layoffs2
where total_laid_off is null and 
percentage_laid_off is null;



--- date column----
select `date`, str_to_date(`date` ,'%m/%d/%Y' ) 
from layoffs2;

UPDATE layoffs2
set `date`= str_to_date(`date` ,'%m/%d/%Y' );

ALTER TABLE layoffs2
MODIFY COLUMN `date` date;

---- Now removing extra column---- 

ALTER TABLE layoffs2
DROP COLUMN row_num;

select *
from layoffs2;













