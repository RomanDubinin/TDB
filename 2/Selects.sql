use [roman.dubinin]

select Journal.RecordId as '¹',
		Journal.RecordTime as 'Time', 
		Car.CarId as '¹ Auto',
		CarRegion.RegionName as 'Region Car', 
		CarRegNumber.Letters as 'Number Words', 
		CarRegNumber.Number as 'Number Nums', 
		Direct.DirectId as 'Dir', 
		Journal.PolicePostId as 'Post num', 
		PolicePostRegion.RegionName as 'Post region',
		Color.ColorName as 'color'
into #TempDB
from Journal 
	INNER JOIN Car on Journal.CarId = Car.CarId
	INNER JOIN Direct on Journal.DirectId = Direct.DirectId
	INNER JOIN CarRegNumber on Car.CarRegNumberId = CarRegNumber.CarRegNumberId
	INNER JOIN Region as CarRegion on CarRegNumber.RegionId = CarRegion.RegionId
	INNER JOIN PolicePost on Journal.PolicePostId = PolicePost.PolicePostId
	INNER JOIN Region as PolicePostRegion on PolicePost.RegionId = PolicePostRegion.RegionId
	INNER JOIN Color on Color.ColorId = Car.ColorId
	order by RecordTime

--select *
--into #AllIn
--from #TempDB
--where [Dir] = 0

--select *
--into #AllOut
--from #TempDB
--where [Dir] = 1

select distinct temp1.[¹ Auto]
into #Transit
from #TempDB as temp1 INNER JOIN #TempDB  as temp2 on temp1.[¹ Auto] = temp2.[¹ Auto]
where 
	temp1.[¹] <> temp2.[¹]
	and temp1.[Region Car] <> temp1.[Post region] 
	and temp2.[Region Car] <> temp2.[Post region]
	and temp1.[Post num] <> temp2.[Post num] 
	and temp1.[Dir] <> temp2.[Dir]
	--and temp1.[Time] < temp2.[Time]

select distinct temp1.[¹ Auto]
into #Foreign
from #TempDB as temp1 INNER JOIN #TempDB  as temp2 on temp1.[¹ Auto] = temp2.[¹ Auto]
where 
	temp1.[¹] <> temp2.[¹]
	and temp1.[Region Car] <> temp1.[Post region]
	and temp1.[Post num] = temp2.[Post num] 
	and temp1.[Dir] <> temp2.[Dir]
	--and temp1.[Time] > temp2.[Time]

select distinct temp1.[¹ Auto]
into #Local
from #TempDB as temp1 INNER JOIN #TempDB  as temp2 on temp1.[¹ Auto] = temp2.[¹ Auto]
where
	temp1.[Post region] = temp2.[Post region]
	and temp1.[Dir] <> temp2.[Dir]
	and temp1.[¹] <> temp2.[¹]



select [¹], [Color], [Region Car] from #TempDB
go

--select distinct journal.[¹ Auto]
--into #ListOfCars
--from #TempDB as journal


--select count(*)
--from #Transit
----group by [¹ Auto]

--select count(*)
--from #Foreign

--select count(*)
--from #Local



--select *
--into #Others
--from #ListOfCars 
--except select * from #Foreign
--except select * from #Local
--except select * from #Transit

--select count(*)
--from #Others

--drop table #ListOfCars
--go
drop table #TempDB
--go
drop table #Foreign
--go
--drop table #Local
go
drop table #Transit
go
--drop table #Others
go

