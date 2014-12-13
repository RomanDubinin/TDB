create procedure BoatsOnPlace 
	@placeName varchar(50),
	@qality varchar(50)
as
begin 

	if object_id('currentId', 'U') IS NOT NULL
	drop table currentId;

	if object_id('greatestId', 'U') IS NOT NULL
	drop table greatestId;

	select Qality.qalityId as 'id'
	into currentId
	from Qality
	where Qality.qalityName = @qality

	select Qality.qalityId as 'id'
	into greatestId
	from Qality, currentId
	where Qality.qalityId >= currentId.id

	select distinct BoatPassport.boatName
	from VisitFishingPlace
	join FishingPlace
	on VisitFishingPlace.idFishingPlace = FishingPlace.fishingPlaceId
	join Qality
	on Qality.qalityId = VisitFishingPlace.idQality
	join BoatPassport
	on BoatPassport.boatId = VisitFishingPlace.idBoat
	where 
		Qality.qalityId in (
			select *
			from greatestId) and 
		FishingPlace.fishingPlaceName = @placeName
end

drop procedure BoatsOnPlace;