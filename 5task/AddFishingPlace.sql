create procedure AddFishingPlace 
	@placeName varchar(50), 
	@x int,
	@y int 
as
begin 
	insert into FishingPlace
			(fishingPlaceName,
			x, 
			y)
		values
		(@placeName, @x, @y);
end

drop procedure AddFishingPlace;