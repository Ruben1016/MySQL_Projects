
-- Looking at total population vs vaccinations

SELECT dea.continent, 
		dea.location,
        dea.date, 
        dea.population,
        vac.new_vaccinations,
        SUM(vac.new_vaccinations) 
        OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS PeopleVaccinated
FROM Covid_Death.coviddeaths dea
JOIN CovidVacines.covidvaccinations vac
	ON dea.location = vac. location
    AND dea.date = vac.date
    WHERE dea.continent IS NOT NULL
    ORDER BY 2,3;
    
    
-- USE CTE
    
   WITH PopvsVac (continet, locaton, date, population, new_vaccinations, PeopleVaccinated)
   AS (
    SELECT dea.continent, 
		dea.location,
        dea.date, 
        dea.population,
        vac.new_vaccinations,
        SUM(vac.new_vaccinations) 
        OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS PeopleVaccinated
FROM Covid_Death.coviddeaths dea
JOIN CovidVacines.covidvaccinations vac
	ON dea.location = vac. location
    AND dea.date = vac.date
    WHERE dea.continent IS NOT NULL
    -- ORDER BY 2,3
    )
    SELECT *, (PeopleVaccinated/population)*100
    FROM PopvsVac;
    
    
    -- Temp table
    DROP TABLE IF exists PercentPopulationVaccinated;
    CREATE TABLE PercentPopulationVaccinated
    (
    continent nvarchar(1000),
    location nvarchar(1000),
    date datetime,
    population integer,
   --  new_vaccinations double,
    Peoplevaccinated integer
    );
    INSERT INTO PercentPopulationVaccinated
    
    SELECT dea.continent, 
		dea.location,
        dea.date, 
        dea.population,
        vac.new_vaccinations,
        SUM(vac.new_vaccinations) 
        OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS PeopleVaccinated
FROM Covid_Death.coviddeaths dea
JOIN CovidVacines.covidvaccinations vac
	ON dea.location = vac. location
    AND dea.date = vac.date
    WHERE dea.continent IS NOT NULL;
    -- ORDER BY 2,3
    
	SELECT *, (PeopleVaccinated/population)*100
    FROM PercentPopulationVaccinated;
    
    -- create view to store data for later visualizations
    CREATE VIEW PercentPopulationVaccin AS
    
    SELECT dea.continent, 
		dea.location,
        dea.date, 
        dea.population,
        vac.new_vaccinations,
        SUM(vac.new_vaccinations) 
        OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS PeopleVaccinated
FROM Covid_Death.coviddeaths dea
JOIN CovidVacines.covidvaccinations vac
	ON dea.location = vac. location
    AND dea.date = vac.date
  -- WHERE dea.continent IS NOT NULL
   -- ORDER BY 2,3
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    