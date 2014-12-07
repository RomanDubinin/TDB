use [roman.dubinin]

drop table [Journal]	   
go
drop table [Car]		   
go
drop table [CarRegNumber]  
go
drop table [PolicePost]	   
go
drop table [Region]		   
go
drop table [Color]		   
go
drop table [CarModel]	   
go
drop table [Driver]		   
go

drop table [Direct]		   
go
--drop trigger checkCarNumber 
go

create table Region (
	RegionId int primary key not null
	,RegionName varchar(30)
	,RegionNumber tinyint
	CHECK ([RegionNumber] < 200 or ([RegionNumber] >= 700 and [RegionNumber] <800))
);
go

create table CarRegNumber(
	CarRegNumberId tinyint not null primary key
	,Letters CHAR(3)
	,Number CHAR(3)
	,RegionId int 
	,FOREIGN KEY (RegionId) REFERENCES Region (RegionId)
	-- ,CHECK(
-- 		(substring(Letters, 1, 1) in ('A', 'B', 'E', 'K', 'M', 'H', 'O', 'P', 'C', 'T', 'Y', 'X'))
-- 		and (substring(Letters, 2, 1) in ('A', 'B', 'E', 'K', 'M', 'H', 'O', 'P', 'C', 'T', 'Y', 'X'))
-- 		and (substring(Letters, 3, 1) in ('A', 'B', 'E', 'K', 'M', 'H', 'O', 'P', 'C', 'T', 'Y', 'X'))
-- 	)
	);
go

create table CarModel(
	CarModelId int  primary key
	,Model varchar(30)
);
go

create table Color (
	ColorId int  not null primary key
	,ColorName varchar(30)
);
go

create table Driver (
	DriverId int  not null primary key
	, FirstName varchar(30)
	, LastName varchar(30) not null
);
go

create table Car (
	CarId int  primary key not null
	,CarModelId int 
	,ColorId int 
	,CarRegNumberId tinyint
	,FOREIGN KEY (CarModelId) REFERENCES CarModel (CarModelId)
	,FOREIGN KEY (ColorId) REFERENCES Color (ColorId)
	,FOREIGN KEY (CarRegNumberId) REFERENCES CarRegNumber (CarRegNumberId)
);
go

create table PolicePost (
	PolicePostId int  primary key not null
	,PostName varchar(30)
	,RegionId int 
);
go

create table Direct(
	DirectId tinyint primary key not null
	,DirectName varchar(30)
);
go

ALTER TABLE [dbo].[PolicePost]
ADD FOREIGN KEY (RegionId) REFERENCES Region(RegionId)
go

create table Journal (
	RecordId int  identity(0,1) not null primary key
	,RecordTime datetime not null
	,CarId int 
	,DirectId tinyint
	,PolicePostId int 
	,FOREIGN KEY (CarId) REFERENCES Car(CarId)
	,FOREIGN KEY (DirectId) REFERENCES Direct(DirectId)
	,FOREIGN KEY (PolicePostId) REFERENCES PolicePost(PolicePostId)
);
go


create trigger checkCarNumber 
on [dbo].[CarRegNumber] 
after insert
as
	begin
		declare @letters CHAR(3), @number CHAR(3), @regionId int , @regionCode NVARCHAR

		declare insertCursor CURSOR LOCAL
		FOR (SELECT Letters, Number, RegionId
				FROM inserted)

		OPEN insertCursor

		fetch next from insertCursor
		into @letters, @number, @regionId
		set @regionCode = convert(nvarchar(10), (select RegionNumber from [dbo].Region where RegionId = @regionId)) 
		
		while @@FETCH_STATUS = 0
			begin
				if not ((substring(@letters, 1, 1) in ('A', 'B', 'E', 'K', 'M', 'H', 'O', 'P', 'C', 'T', 'Y', 'X'))
				and (substring(@letters, 2, 1) in ('A', 'B', 'E', 'K', 'M', 'H', 'O', 'P', 'C', 'T', 'Y', 'X'))
				and (substring(@letters, 3, 1) in ('A', 'B', 'E', 'K', 'M', 'H', 'O', 'P', 'C', 'T', 'Y', 'X'))
				)
					begin
						print 'INCORRECT LETTERS IN NUMBER! ' + CAST(@letters as varchar(30))
						ROLLBACK TRANSACTION
					end

				if not exists (select RegionId from [dbo].Region where RegionId = @regionId) 
				begin
    				print('ƒанного номера нет в базе данных, но он допустим') 
				end
					FETCH NEXT FROM insertCursor
					INTO @letters, @number, @regionId
			end
	end;
go


INSERT INTO [dbo].[Direct]
          ([DirectId],
		  [DirectName])
    VALUES
          (0,N'To the city'),
		  (1,N'From the city')
go

INSERT INTO [dbo].[Color]
          ([ColorId],
		  [ColorName])
    VALUES
          (0,N'White'),
		  (1,N'Black'),
		  (2,N'Green'),
		  (3,N'Pink'),
		  (4,N'Orange')
go

INSERT INTO [dbo].[Driver]
          ([DriverId],
		  [FirstName],
		  [LastName])
    VALUES
          (0,N'Ivan',N'Ivanov'),
		  (1,N'Igor',N'Igorev'),
		  (2,N'Arkady',N'Arkadiev'),
		  (3,N'Gennady',N'Gennadiev')
go

INSERT INTO [dbo].[Region]
          ([RegionId],
		  [RegionName],
		  [RegionNumber])
    VALUES
          (0, N'Sverdlovskaya oblast', 66),
		  (1, N'Sverdlovskaya oblast', 96),
		  (2, N'Sverdlovskaya oblast', 196),
		  (3, N'Chelyabinskaya oblast', 74),
		  (4, N'Chelyabinskaya oblast', 174)
go

INSERT INTO [dbo].[PolicePost]
          ([PolicePostId],
		  [PostName],
		  [RegionId])
    VALUES
          (0,N'Post 1',0),
		  (1,N'Post 2',1),
		  (2,N'Post 3',0),
		  (3,N'Post 4',1)
go

INSERT INTO [dbo].[CarModel]
          ([CarModelId]
          ,[Model])
    VALUES
          (0,N'BMW'),
		  (1,N'Mercedes'),
		  (2,N'Audi')
go

INSERT INTO [dbo].[CarRegNumber]
          ([CarRegNumberId],
		  [Letters],
		  [Number],
		  [RegionId])
    VALUES
          (0,N'ABE',123,0),
		  (1,N'AMP',777,0),
		  (2,N'EKX',666,0),
		  (3,N'AAA',123,0),
		  (4,N'ATE',123,0),
		  (5,N'AHE',123,0)
go


INSERT INTO [dbo].[Car]
          ([CarId],
		  [CarModelId],
		  [ColorId],
		  [CarRegNumberId])
    VALUES
          (0, 0, 2, 0),
		  (1, 1, 1, 1),
		  (2, 2, 0, 2),
		  (3, 0, 3, 3),
		  (4, 2, 4, 4)
go


INSERT INTO [dbo].[Journal]
          ([RecordTime],
		  [CarId],
		  [DirectId],
		  [PolicePostId])
    VALUES
          ('2013-15-04 08:15:30.0', 0, 0, 3),
		  ('2013-15-04 08:20:30.0', 1, 1, 2),
		  ('2013-21-04 08:25:30.0', 2, 1, 3),
		  ('2013-22-04 08:30:30.0', 2, 0, 1),
		  ('2013-27-04 08:35:30.0', 1, 0, 1),
		  ('2013-25-04 08:40:30.0', 1, 0, 3),
		  ('2013-26-04 08:45:30.0', 1, 1, 2),
		  ('2013-25-04 08:50:30.0', 1, 0, 2),
		  ('2013-24-04 08:55:30.0', 2, 0, 2),
		  ('2013-23-04 09:00:30.0', 1, 1, 2),
		  ('2013-25-04 09:05:30.0', 1, 1, 3),
		  ('2013-06-04 09:10:30.0', 2, 0, 1),
		  ('2013-08-05 09:15:30.0', 1, 1, 1)
go
