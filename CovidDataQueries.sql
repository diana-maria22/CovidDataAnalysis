SELECT * 
FROM app..coviddeaths$ 
WHERE continent IS NOT NULL
ORDER BY 3,4


SELECT Location, date, total_cases, new_cases, total_deaths 
FROM app..coviddeaths$ 
ORDER BY 1,2


SELECT Location, date, CAST(total_cases AS float) AS Cases, CAST(total_deaths AS float) AS Deaths, (CAST(total_deaths AS float)/CAST(total_cases AS float))*100 AS DeathPercentage 
FROM app..coviddeaths$ 
WHERE location='Romania' AND  continent IS NOT NULL
ORDER BY 1, 2


SELECT location, MAX(CAST (total_cases AS float)) AS HighestInfectionCount
FROM app..coviddeaths$ 
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY 2 DESC


SELECT location, MAX(CAST (total_deaths AS float)) AS TotalDeathCount
FROM app..coviddeaths$ 
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY TotalDeathCount DESC


SELECT continent, MAX(CAST (total_deaths AS float)) AS TotalDeathCountByContinent
FROM app..coviddeaths$ 
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCountByContinent DESC


SELECT date, SUM(CAST(new_cases AS float)) AS TotalCases, SUM(CAST(new_deaths AS float)) AS TotalDeaths, SUM(CAST(new_deaths AS float))/NULLIF(SUM(CAST(new_cases AS float)),0)*100 AS DeathsPercentage
FROM app..coviddeaths$ 
WHERE continent IS NOT NULL 
GROUP BY date
ORDER BY 1, 2


SELECT SUM(CAST(new_cases AS float)) AS TotalCases, SUM(CAST(new_deaths AS float)) AS TotalDeaths, SUM(CAST(new_deaths AS float))/NULLIF(SUM(CAST(new_cases AS float)),0)*100 AS DeathsPercentage
FROM app..coviddeaths$ 
WHERE continent IS NOT NULL 
ORDER BY 1, 2


SELECT d.continent, d.location, d.date, v.new_vaccinations
,SUM(CAST(v.new_vaccinations AS float)) OVER (Partition BY d.location ORDER BY d.location, d.date) AS PeopleVaccinated
FROM app..coviddeaths$ d
JOIN app..covidvaccinations$ v
ON d.location = v.location 
AND d.date = v.date
WHERE d.continent IS NOT NULL 
ORDER BY 2,3









