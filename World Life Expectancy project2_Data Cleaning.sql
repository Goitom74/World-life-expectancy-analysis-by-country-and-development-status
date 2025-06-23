-- World Life Expectancy Project (Data Cleaning)

select *
from worldlifeexpectancy;

select country, year, concat(country, year), count(concat(country, year))
from worldlifeexpectancy
group by country, year, concat(country, year)
;

select country, year, concat(country, year), count(concat(country, year))
from worldlifeexpectancy
group by country, year, concat(country, year)
having count(concat(country, year)) > 1
;

select *
from 
(select row_id, concat(country, year), 
row_number () over (partition by Concat(country, year) order by concat(country, year)) as row_num
from worldlifeexpectancy) as row_table
where row_num > 1;

delete from worldlifeexpectancy
where row_id in (
select row_id 
from 
(select row_id, concat(country, year), 
row_number () over (partition by Concat(country, year) order by concat(country, year)) as row_num
from worldlifeexpectancy) as row_table
where row_num > 1);

select *
from worldlifeexpectancy
where status = '';

update worldlifeexpectancy t1
join worldlifeexpectancy t2
on t1.country = t2.country
set t1.status ='developing'
where t1.status = ''
and t2.status <> ''
and t2.status ='developing'
;

update worldlifeexpectancy t1
join worldlifeexpectancy t2
on t1.country = t2.country
set t1.status ='developed'
where t1.status = ''
and t2.status <> ''
and t2.status ='developed'
;
select *
from worldlifeexpectancy
;

select t1.Country, t1.Year, t1.`Life expectancy`,
t2.Country, t2.Year, t2.`Life expectancy`,
t3.Country, t3.Year, t3.`Life expectancy`,
round((t3.`Life expectancy` + t2.`Life expectancy`)/2, 1)
from worldlifeexpectancy t1
join worldlifeexpectancy t2
on t1.Country = t2.Country
AND t1.Year = t2.Year - 1
join  worldlifeexpectancy t3
on t1.Country = t3.Country
AND t1.Year = t3.Year + 1
where t1.`Life expectancy` = ''
;

update worldlifeexpectancy t1
join worldlifeexpectancy t2
on t1.Country = t2.Country
AND t1.Year = t2.Year - 1
join  worldlifeexpectancy t3
on t1.Country = t3.Country
AND t1.Year = t3.Year + 1
set t1.`Life expectancy` = round((t3.`Life expectancy` + t2.`Life expectancy`)/2, 1)
where t1.`Life expectancy` = ''
;

select country, year, `life expectancy`
from  worldlifeexpectancy
#where 'Life expectancy' = '';