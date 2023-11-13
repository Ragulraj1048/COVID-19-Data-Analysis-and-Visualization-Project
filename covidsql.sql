USE covid_database;

SELECT * FROM location_covid;
SELECT * FROM income_covid;
SELECT * FROM continent_covid;
SELECT * FROM world_covid;

-- exploration
-- total vaccination by all tables
SELECT sum(total_vaccinations) FROM location_covid ;
SELECT sum(total_vaccinations) FROM income_covid ;
SELECT sum(total_vaccinations) FROM continent_covid;
SELECT sum(total_vaccinations) FROM world_covid;

-- total_cases by all tables
SELECT sum(total_cases) FROM location_covid ;
SELECT sum(total_cases) FROM income_covid ;
SELECT sum(total_cases) FROM continent_covid;
SELECT sum(total_cases) FROM world_covid;

-- new_cases by all tables
SELECT sum(new_cases) FROM location_covid ;
SELECT sum(new_cases) FROM income_covid ;
SELECT sum(new_cases) FROM continent_covid;
SELECT sum(new_cases) FROM world_covid;



-- death percentage by continent

SELECT continent,  (sum(total_deaths)/sum(total_cases))*100 AS death_percentage 
FROM location_covid GROUP BY continent ;

-- death percentage by location

SELECT location,  (sum(total_deaths)/sum(total_cases))*100 AS death_percentage 
FROM location_covid GROUP BY location
order by death_percentage desc  ;

SELECT location, sum(total_deaths) AS total_deaths
FROM location_covid GROUP BY location
order by total_deaths desc  ;

-- cross checking Total global COVID-19 statistics
SELECT
    SUM(total_cases) AS total_cases,
    SUM(total_deaths) AS total_deaths,
    SUM(total_vaccinations) AS total_vaccinations
FROM world_covid;

SELECT
    SUM(total_cases) AS total_cases,
    SUM(total_deaths) AS total_deaths,
    SUM(total_vaccinations) AS total_vaccinations
FROM location_covid;

SELECT
    SUM(total_cases) AS total_cases,
    SUM(total_deaths) AS total_deaths,
    SUM(total_vaccinations) AS total_vaccinations
FROM continent_covid;

-- total cases vs total deaths in india

SELECT location,  sum(total_deaths),sum(total_cases)
FROM location_covid GROUP BY location
order by sum(total_cases) desc  ;



SELECT date, location,  sum(total_deaths),sum(total_cases),(sum(total_deaths)/sum(total_cases))*100
FROM location_covid where location = 'India'
group by date, location
order by date, location  ;

-- COVID-19 statistics by continent
SELECT
    continent,
    SUM(total_cases) AS total_cases,
    SUM(total_vaccinations) AS total_vaccinations
FROM continent_covid
GROUP BY continent;

-- COVID-19 statistics by income level
SELECT
    income,
    SUM(total_cases) AS total_cases,
    SUM(total_vaccinations) AS total_vaccinations
FROM income_covid
GROUP BY income
ORDER BY total_cases, total_vaccinations desc;



-- total cases vs total deaths in continents

-- asia
SELECT date, continent,  sum(total_deaths),sum(total_cases),(sum(total_deaths)/sum(total_cases))*100 AS death_percentage
FROM location_covid WHERE continent = 'asia'
GROUP BY DATE, continent
ORDER BY DATE, continent ;

-- europe
SELECT date, continent,  sum(total_deaths),sum(total_cases),(sum(total_deaths)/sum(total_cases))*100 AS death_percentage
FROM location_covid WHERE continent = 'europe'
GROUP BY DATE, continent
ORDER BY DATE, continent ;

-- north america
SELECT date, continent,  sum(total_deaths),sum(total_cases),(sum(total_deaths)/sum(total_cases))*100 AS death_percentage
FROM location_covid WHERE continent = 'north america'
GROUP BY DATE, continent
ORDER BY DATE, continent ;

-- south america
SELECT date, continent,  sum(total_deaths),sum(total_cases),(sum(total_deaths)/sum(total_cases))*100 AS death_percentage
FROM location_covid WHERE continent = 'south america'
GROUP BY DATE, continent
ORDER BY DATE, continent ;

-- africa
SELECT date, continent,  sum(total_deaths),sum(total_cases),(sum(total_deaths)/sum(total_cases))*100 AS death_percentage
FROM location_covid WHERE continent = 'africa'
GROUP BY DATE, continent
ORDER BY DATE, continent ;

-- oceania
SELECT date, continent,  
	sum(total_deaths),
	sum(total_cases),
	(sum(total_deaths)/sum(total_cases))*100 AS death_percentage
FROM location_covid WHERE continent = 'oceania'
GROUP BY DATE, continent
ORDER BY DATE, continent ;


-- -------------------------------------------------questions-------------------------------------------------
-- FOR SLIDE  OVERVIEW
-- TOTAL CASES
SELECT sum(new_cases) FROM location_covid ;

-- TOTAL DEATHS
SELECT sum(new_deaths) FROM location_covid ;

-- AVG LIFE EXPECTANCY
SELECT AVG(life_expectancy) FROM WORLD_covid ;
------------------------------------------------------------------------------------------------------------------------
-- 2ND SLIDE
-- 1. overall total cases and total deaths by each year

-- ANSWER

SELECT
    YEAR(date) AS Year,
    MAX(date) AS YearEnd,
    sum(new_cases) AS TotalCases,
    sum(new_deaths) AS TotalDeaths

FROM world_covid
GROUP BY Year
ORDER BY Year;
-------------------------------------------------------------------------------------------------------------
-- 3RD SLIDE
-- 2. total cases vs total deaths in continents

-- ANSWER
SELECT  continent,  
	sum(total_deaths) AS total_death, 
	sum(total_cases) AS total_cases,
	(sum(total_deaths)/sum(total_cases))*100 AS death_percentage
FROM location_covid 
GROUP BY  continent
ORDER BY  continent ;



-- ANSWER
SELECT  continent,  
		sum(new_deaths) AS total_death, 
		sum(new_cases) AS total_cases,
	    (sum(new_deaths)/sum(new_cases))*100 AS death_percentage
	FROM location_covid 
	GROUP BY  continent
	ORDER BY  continent ;

-----------------------------------------------------------------------------------------------------------------
-- 4TH SLIDE
-- 3.continents with highest infection rate

SELECT distinct population AS total_population,
		location, 
        continent
	FROM location_covid;

 --  ANSWER
SELECT continent, 
	   avg(new_cases_per_million) AS infection_rate_per_million
	FROM location_covid
	group by continent;

--------------------------------------------------------------------------------------------------------------------
-- 5TH SLIDE
-- 4.TOP 5 location WITH highest TOTAL CASES VS TOTAL DEATHS
-- ANSWER


SELECT  location, MAX(total_cases) AS TOTAL_CASES
FROM location_covid
GROUP BY location, continent
ORDER BY TOTAL_CASES DESC
LIMIT 5;

SELECT  location, MAX(total_DEATHS) AS TOTAL_DEATHS
FROM location_covid
GROUP BY location, continent
ORDER BY TOTAL_DEATHS DESC
LIMIT 5;



--------------------------------------------------------------------------------------------------------------------
-- 6TH SLIDE
-- 5.TIMELINE FOR people_fully_vaccinated vs total cases in asia
-- ANSWER
SELECT
    date AS year,
    SUM(new_cases) AS total_cases,
    SUM(people_fully_vaccinated) AS fully_vaccinated
FROM location_covid
WHERE continent = 'asia'
GROUP BY year
HAVING SUM(new_cases) != 0 AND SUM(people_fully_vaccinated) != 0
ORDER BY year;

--------------------------------------------------------------------------------------------------------------------
-- 7TH SLIDE
--  6.location with highest cases in each continent

 SELECT continent, MAX(total_cases) AS max_total_cases
    FROM location_covid
    GROUP BY continent;

-- ANSWER
SELECT
    lc.continent,
    lc.location,
    lc.total_cases
FROM location_covid AS lc
JOIN (
    SELECT continent, MAX(total_cases) AS max_total_cases
    FROM location_covid
    GROUP BY continent
) AS max_tab
ON lc.continent =max_tab.continent
AND lc.total_cases = max_tab.max_total_cases
ORDER BY lc.continent;

--------------------------------------------------------------------------------------------------------------------
-- 8TH SLIDE
-- 7.timeline for cases in  india when vaccination started 

SELECT
    date AS year,
   
    SUM(total_vaccinations) AS total_vaccinations
FROM location_covid  where location = 'india'
GROUP BY year
ORDER BY year;


SELECT
    date AS year,
    SUM(new_cases) AS total_cases,
     SUM(total_vaccinations) AS total_vaccinations
FROM location_covid
WHERE location = 'India'
GROUP BY year
HAVING SUM(new_cases) != 0
ORDER BY year;

SELECT
    date AS year,
   SUM(total_vaccinations) AS total_vaccinations
FROM location_covid
WHERE location = 'India'
GROUP BY year
HAVING SUM(total_vaccinations) != 0
ORDER BY year;

-- answer
SELECT
    date AS year,
    SUM(new_cases) AS total_cases,
    SUM(total_vaccinations) AS total_vaccinations
FROM location_covid
WHERE location = 'India'
GROUP BY year
HAVING SUM(new_cases) != 0 AND SUM(total_vaccinations) != 0
ORDER BY year;




--------------------------------------------------------------------------------------------------------------------
-- 9TH SLIDE
-- 8. pATIENTS fully vaccinated in terms of income
-- ANSWER
SELECT
    income,
    MAX(date) AS LatestDate,
    SUM(people_fully_vaccinated) AS TotalFullyVaccinated
FROM income_covid
GROUP BY income;





--------------------------------------------------------------------------------------------------------------------
-- 10TH SLIDE
-- 9. SMOKERS vs total DEATHS

SELECT
    continent,
    AVG(female_smokers) AS AvgFemaleSmokers,
    AVG(male_smokers) AS AvgMaleSmokers,
    SUM(new_deaths) AS TotalCases
FROM location_covid
GROUP BY continent;

-- answer
SELECT continent, (AvgFemaleSmokers + AvgMaleSmokers)  AS smokers,  TotalDEATHS
 FROM 
(SELECT
    continent,
    AVG(female_smokers) AS AvgFemaleSmokers,
    AVG(male_smokers) AS AvgMaleSmokers,
    SUM(new_deaths) AS TotalDEATHS
FROM location_covid
GROUP BY continent) as smo;



--------------------------------------------------------------------------------------------------------------------
-- 11TH SLIDE
-- 10. AVERAGE BED PER 1000 and AvgPatientsPer1000 IN CONTINENTS


SELECT
    continent,
     AVG(hosp_patients) AS avs_patients,
    AVG(hospital_beds_per_thousand) AS AverageHospitalBedsPerThousand
FROM location_covid
GROUP BY continent
ORDER BY AVG(hospital_beds_per_thousand);

-- answer


SELECT
    continent,
    AVG(hosp_patients) / (AVG(population) / 1000) AS AvgPatientsPer1000,
    AVG(hospital_beds_per_thousand) AS AverageHospitalBedsPerThousand
FROM location_covid
GROUP BY continent
ORDER BY AvgPatientsPer1000;







