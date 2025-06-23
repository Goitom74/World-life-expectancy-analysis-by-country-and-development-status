-- World Life Expectancy (Exploratory Data Analysis)

select *
from worldlifeexpectancy
;

select Country, 
min(`Life expectancy`), 
max(`Life expectancy`),
round(max(`Life expectancy`) - min(`Life expectancy`),1) AS lifeexpimproveover15years
from worldlifeexpectancy
group by country
having min(`Life expectancy`) <> 0
and max(`Life expectancy`) <> 0  
order by lifeexpimproveover15years desc
;

select *
from worldlifeexpectancy
;

select Country, 
min(`BMI`), 
max(`BMI`),
round(max(`BMI`) - min(`BMI`),1) AS bmiimprove
from worldlifeexpectancy
group by country
having min(`BMI`) <> 0
and max(`BMI`) <> 0  
order by bmiimprove desc
;

select *
from worldlifeexpectancy
order by GDP desc
;

select avg(gdp) AS over_all_average
from worldlifeexpectancy
where gdp is not null and gdp > 0
;

select
sum(case when gdp >= 7483 then 1 else 0 end) high_gdp_count,
round(avg(case when gdp >= 7483 then `Life expectancy` else null end),2) high_gdp_Life_expectancy,
sum(case when gdp <= 7483 then 1 else 0 end) low_gdp_count,
round(avg(case when gdp <= 7483 then `Life expectancy` else null end),2) low_gdp_Life_expectancy
from worldlifeexpectancy;

select status, round(avg(`Measles`),1)
from worldlifeexpectancy
group by Status;

select status, round(avg(`HIV/AIDS`),1)
from worldlifeexpectancy
group by Status;
-- World Life Expectancy _ Exploratory Data Analysis

select status, count(distinct Country)
from worldlifeexpectancy
group by Status;

select *
from worldlifeexpectancy;

select status, round(avg(`Adult Mortality`),1) AS Adult_Mortality
from worldlifeexpectancy
group by Status;

select status, count(distinct Country), round(avg(`HIV/AIDS`),1) as HIV_AIDS, round(avg(`Polio`),1)as Polio, round(avg(`Measles`),1) as Measles, round(avg(`infant deaths`),1) AS Infant_deaths, round(avg(`Adult Mortality`),1) AS Adult_Mortality, round(avg(`Life expectancy`),1) as Life_exp
from worldlifeexpectancy
group by Status;

select Status, round(avg (`BMI`),1) as bmi, round(avg(`Life expectancy`),1) as Life_exp 
from worldlifeexpectancy
group by status;


select country, year, `life expectancy`, `adult mortality`,
Sum(`adult mortality`) over(partition by country order by year) AS rolling_total
from worldlifeexpectancy
where country LIKE '%United%';