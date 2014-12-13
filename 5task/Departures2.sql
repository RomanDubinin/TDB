create procedure Departures2
	@dateFrom date,
	@dateTo date 
as
begin 
	select Fishery.departure, Fishery.arrival, BoatPassport.boatName, FishCatch.codfish + FishCatch.herring + FishCatch.crab as 'Total Catch'
	from Fishery
	join BoatPassport
	on Fishery.idBoat = BoatPassport.boatId
	join FishCatch
	on Fishery.idFishCatch = FishCatch.fishCatchId
	where 
		Fishery.departure >= @dateFrom and 
		Fishery.arrival <= @dateTo
	order by Fishery.departure
end

drop procedure Departures2;