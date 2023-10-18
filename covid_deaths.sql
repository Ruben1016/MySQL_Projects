SELECT location, date, total_cases, new_cases, total_deaths, population
FROM coviddeaths
WHERE Continent IS NOT NULL
ORDER BY 1,2;

-- Looking at total cases vs total deaths

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases) *100 AS DeathPercentage
FROM coviddeaths
WHERE location LIKE '%states%'
ORDER BY 1,2;

-- Looking at total cases vs population

SELECT location, date, total_cases, population, (total_cases/population) *100 AS PopulationInfected
FROM coviddeaths
WHERE location LIKE '%states%'
ORDER BY 1,2;

-- looking at countries with highest infection rate compared to population

SELECT location, 
		population, 
        MAX(total_cases) AS HighestInfectionCount, 
        MAX((total_cases/population)) *100 AS PopulationInfected
FROM coviddeaths
GROUP BY location, population
ORDER BY PopulationInfected DESC;

-- Showing countries with highest death total per population

SELECT location, MAX(cast(total_deaths AS UNSIGNED)) AS TotalDeath
FROM coviddeaths
WHERE Continent IS NOT NULL
GROUP BY location
ORDER BY TotalDeath DESC;

-- Continents with the highest death count

SELECT Continent, MAX(cast(total_deaths AS UNSIGNED)) AS TotalDeath
FROM coviddeaths
WHERE Continent IS NOT NULL
GROUP BY Continent
ORDER BY TotalDeath DESC;

-- Global Numbers

SELECT  
		SUM(new_cases) As TotalCases, 
        SUM(new_deaths) AS TotalDeaths,
        SUM(new_deaths)/SUM(new_cases) * 100 AS DeathPercentage
FROM coviddeaths
WHERE Continent IS NOT NULL
ORDER BY 1,2;


















