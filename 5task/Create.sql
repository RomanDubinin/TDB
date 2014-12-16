use [sql]


if object_id('Fishery', 'U') IS NOT NULL
drop table Fishery;

if object_id('VisitFishingPlace', 'U') IS NOT NULL
drop table VisitFishingPlace;

if object_id('FishingPlace', 'U') IS NOT NULL
drop table FishingPlace;

if object_id('Qality', 'U') IS NOT NULL
drop table Qality;

if object_id('BoatPassport', 'U') IS NOT NULL
drop table BoatPassport;

if object_id('Team', 'U') IS NOT NULL
drop table Team;

if object_id('CrewmanPassport', 'U') IS NOT NULL
drop table CrewmanPassport;

if object_id('FishCatch', 'U') IS NOT NULL
drop table FishCatch;

if object_id('Fish', 'U') IS NOT NULL
drop table Fish;

create table BoatPassport(
	boatId int primary key not null,
	boatName varchar(50) not null,
	boatType varchar(50) not null,
	displacement int not null,
	birthday date not null
)

create table CrewmanPassport(
	crewmanId int primary key not null,
	crewmanName varchar(50) not null,
	addr varchar(50) not null
)

create table FishCatch(
	idFishery int not null,
	idFish int,
	kilograms float
)

create table Fish(
	fishId int primary key not null,
	fishName varchar(50)
)

create table Qality(
	qalityId int primary key not null,
	qalityName varchar(50) not null
)

create table FishingPlace(
	fishingPlaceId int IDENTITY primary key not null,
	fishingPlaceName varchar(50) not null,
	x int not null,
	y int not null
)

create table Team(
	teamId int primary key not null,
	idCaptain	int references CrewmanPassport (crewmanId),
	idCook		int references CrewmanPassport (crewmanId),
	idSkipper	int references CrewmanPassport (crewmanId),
	idBoatswain int references CrewmanPassport (crewmanId),
	idFisher1	int references CrewmanPassport (crewmanId),
	idFisher2	int references CrewmanPassport (crewmanId),
	idFisher3	int references CrewmanPassport (crewmanId)
)

create table Fishery(
	fisheryId int primary key not null,
	idBoat int not null,
	idTeam int references Team (teamId) not null,
	departure date not null,
	arrival date not null
)

create table VisitFishingPlace(
	idFishingPlace int not null references FishingPlace (fishingPlaceId),
	idBoat int not null,
	arrival date not null,
	departure date not null,
	idQality int references Qality (qalityId)
)

insert into BoatPassport
			(boatId,
			boatName,
			boatType,
			displacement,
			birthday)
		values
		(1, 'Adventure', 'Type1', 200, '2014-07-07'),
		(2, 'Crabber', 'Type2', 400, '2004-04-03');

insert into CrewmanPassport
			(crewmanId,
			crewmanName,
			addr)
		values
		(1, 'Vasily','addr1'),
		(2, 'Ivan', 'addr2'),
		(3, 'Artur', 'addr3'),
		(4, 'Dmitry', 'addr4'),
		(5, 'Roman', 'addr5'),
		(6, 'Alexander', 'addr6'),
		(7, 'Gennady', 'addr7'),
		(8, 'Evgeny', 'addr8');

insert into Fish
			(fishId,
			fishName)
		values
		(1, 'codfish'),
		(2, 'herring'),
		(3, 'crab');

insert into FishCatch
			(idFishery,
			idFish,
			kilograms)
		values
		(1, 1, 10),
		(1, 2, 10),
		(1, 3, 15),
		(2, 1, 15),
		(2, 2, 14),
		(2, 3, 15),
		(3, 1, 21),
		(3, 2, 16),
		(3, 3, 15),
		(4, 1, 22),
		(4, 2, 15),
		(4, 3, 16),
		(5, 1, 18),
		(5, 2, 14),
		(5, 3, 23),
		(6, 1, 27),
		(6, 2, 12),
		(6, 3, 11),
		(7, 1, 24),
		(7, 2, 12),
		(7, 3, 12),
		(8, 1, 27),
		(8, 2, 17),
		(8, 3, 15);

insert into Qality
			(qalityId,
			qalityName)
		values
		(1, 'bad'),
		(2, 'good'),
		(3, 'verygood');

insert into FishingPlace
			(fishingPlaceName,
			x, 
			y)
		values
		('Place1', 100, 250),
		('Place2', 300, 300),
		('Place3', 100, 350);

insert into Team
			(teamId,
			idCaptain,
			idCook,
			idSkipper,
			idBoatswain,
			idFisher1,
			idFisher2, 
			idFisher3)
		values
		(1, 7, 3, 5, 4, 1, 2, 6),
		(2, 7, 2, 3, 8, 4, 5, 6),
		(3, 7, 1, 2, 8, 3, 5, 6);

insert into Fishery
			(fisheryId,
			idBoat,
			idTeam,
			departure,
			arrival)
		values
		(1, 1, 3, '2014-11-01', '2014-11-03'),
		(2, 1, 2, '2014-11-04', '2014-11-05'),
		(3, 2, 1, '2014-11-01', '2014-11-02'),
		(4, 1, 2, '2014-11-06', '2014-11-08'),
		(5, 2, 3, '2014-11-07', '2014-11-09'),
		(6, 2, 1, '2014-11-10', '2014-11-14'),
		(7, 2, 3, '2014-11-15', '2014-11-17'),
		(8, 1, 1, '2014-11-16', '2014-11-17');

insert into VisitFishingPlace
			(idFishingPlace,
			idBoat,
			arrival,
			departure,
			idQality)
		values
		(1, 1, '2014-11-02', '2014-11-02', 1),
		(2, 1, '2014-11-03', '2014-11-03', 2),
		(3, 2, '2014-11-01', '2014-11-01', 2),
		(1, 1, '2014-11-04', '2014-11-04', 3),
		(2, 2, '2014-11-02', '2014-11-02', 2),
		(3, 2, '2014-11-07', '2014-11-08', 2),
		(1, 2, '2014-11-08', '2014-11-09', 2),
		(2, 1, '2014-11-16', '2014-11-17', 3);
