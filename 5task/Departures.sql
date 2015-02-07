create procedure Departures 
	@boatType varchar(50), 
	@dateFrom date,
	@dateTo date 
as
begin 
	if object_id('TotalCatch', 'U') IS NOT NULL
	drop table TotalCatch;

	select Fishery.fisheryId, sum(FishCatch.kilograms) as 'Kg'
	into TotalCatch
	from Fishery
	join FishCatch
	on Fishery.fisheryId = FishCatch.idFishery
	group by Fishery.fisheryId

	select Fishery.departure, BoatPassport.boatName, TotalCatch.Kg as 'Total Catch'
	from Fishery
	join BoatPassport
	on Fishery.idBoat = BoatPassport.boatId
	join TotalCatch
	on Fishery.fisheryId = TotalCatch.fisheryId
	where 
		Fishery.departure >= @dateFrom and 
		Fishery.departure <= @dateTo and
		BoatPassport.boatType = @boatType
	order by Fishery.departure
end

drop procedure Departures;