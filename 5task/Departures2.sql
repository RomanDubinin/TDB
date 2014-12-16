create procedure Departures2
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


	select Fishery.fisheryId, Fishery.departure, Fishery.arrival, BoatPassport.boatName, TotalCatch.Kg as 'Total Catch'
	from Fishery
	join BoatPassport
	on Fishery.idBoat = BoatPassport.boatId
	join TotalCatch
	on Fishery.fisheryId = TotalCatch.fisheryId
	where 
		Fishery.departure >= @dateFrom and 
		Fishery.arrival <= @dateTo
	order by Fishery.departure
end

drop procedure Departures2;