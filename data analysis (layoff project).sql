
--- DATA ANALYSIS--- 

SELECT *
FROM Layoffs2;

SELECT company, percentage_laid_off
FROM Layoffs2
where percentage_laid_off=1
order by 2 ;
SELECT *
FROM Layoffs2
where percentage_laid_off=1
order by total_laid_off desc;
SELECT *
FROM Layoffs2
where percentage_laid_off=1
order by funds_raised_millions desc;


SELECT company, total_laid_off
FROM Layoffs2
where total_laid_off is not null
order by 2 desc;

SELECT industry, total_laid_off
FROM Layoffs2
where total_laid_off is not null
order by 2 desc;


SELECT company, `date`,total_laid_off
FROM Layoffs2
where total_laid_off is not null
order by 2 desc;

SELECT company, subtring(`date`) as data_1,total_laid_off
FROM Layoffs2
where total_laid_off is not null
group by company
order by 2 desc;

SELECT company,sum(total_laid_off)
FROM Layoffs2
group by company
order by 2 desc;

SELECT Industry,sum(total_laid_off)
FROM Layoffs2
group by Industry
order by 2 desc;

SELECT country,sum(total_laid_off)
FROM Layoffs2
group by country
order by 2 desc;

SELECT MIN(`DATE`), MAX(`DATE`)
FROM Layoffs2
;
SELECT `date`,sum(total_laid_off)
FROM Layoffs2
group by `date`
order by 2 desc;
SELECT Stage,sum(total_laid_off)
FROM Layoffs2
group by Stage
order by 2 desc;

SELECT YEAR(`date`),sum(total_laid_off)
FROM Layoffs2
group by YEAR(`date`)
order by 2 desc;

SELECT  substring(`date` ,1,7) as `month`, sum(total_laid_off) 
FROM Layoffs2
where substring(`date` ,1,7) is not null
group by substring(`date` ,1,7)
order by 1 asc;

WITH rolling_total as
(SELECT   substring(`date` ,1,7) AS `MONTH`, sum(total_laid_off) AS Laid_off
FROM Layoffs2
where substring(`date` ,1,7) IS NOT NULL
group by substring(`date` ,1,7)
ORDER by 1 asc
)
SELECT `MONTH` , Laid_off, sum(Laid_off) over( order by `MONTH` ) as rolling_total
FROM rolling_total;

SELECT Company, YEAR(`date`),sum(total_laid_off)
FROM Layoffs2
group by Company,YEAR(`date`)
order by 3 desc;	

with company_year (company, years, laid_off) as
(SELECT Company, YEAR(`date`),sum(total_laid_off)
FROM Layoffs2
group by Company,YEAR(`date`)
), company_ranking AS
(select *, dense_rank() over(partition by Years order by laid_off desc) as ranking
from company_year
where years is not null
)
select *
from company_ranking
where ranking <= 5
;




WITH ROLLING_TOTAL3 AS
(SELECT  substring(`date` ,1,7) as `month`, sum(total_laid_off) as laid_s
FROM Layoffs2
where substring(`date` ,1,7) is not null
group by substring(`date` ,1,7)
order by 1 asc
)
SELECT  `MONTH` , laid_s,sum(laid_s) OVER( order by `MONTH` ) as ROLLING_TOTAL3
FROM ROLLING_TOTAL3;

select company, YEAR(`DATE`), sum(total_laid_off)
from Layoffs2
where total_laid_off is not null
group by company, YEAR(`DATE`)
order by 3 desc;

with company_year (company, years, laid_off) as
(select company, YEAR(`DATE`), sum(total_laid_off)
from Layoffs2
where total_laid_off is not null
group by company, YEAR(`DATE`)
), company_ranking as
( 
select*, dense_rank() 
over( partition by  years order by laid_off desc) 
as ranking_new
from company_year
where  years is not null
)
select *
from company_ranking
where ranking_new<= 5;


with company_year (company, years, laid_off) as
(SELECT Company, YEAR(`date`),sum(total_laid_off)
FROM Layoffs2
group by Company,YEAR(`date`)
), company_ranking AS
(select *, dense_rank() over(partition by Years order by laid_off desc) as ranking
from company_year
where years is not null
)
select *
from company_ranking
where ranking <= 5
;



