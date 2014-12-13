use [sql]


if object_id('Fishery', 'U') IS NOT NULL
drop table Fishery;

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
	fishCatchId int primary key not null,
	codfish float,
	herring float,
	crab float
)

create table Qality(
	qalityId int primary key not null,
	qalityName varchar(50) not null
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
	arrival date not null,
	idFishCatch int references FishCatch (fishCatchId)
)

create table FishingPlace(
	fishingPlaceId int not null,
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

insert into FishCatch
			(fishCatchId,
			codfish,
			herring,
			crab)
		values
		(1, 10, 15, 15),
		(2, 13, 24, 13),
		(3, 20, 14, 27),
		(4, 25, 10, 12),
		(5, 30, 23, 15),
		(6, 25, 32, 18),
		(7, 34, 24, 15),
		(8, 31, 15, 22);

insert into Qality
			(qalityId,
			qalityName)
		values
		(1, 'bad'),
		(2, 'good'),
		(3, 'verygood');

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
			arrival,
			idFishCatch)
		values
		(1, 1, 3, '2014-11-01', '2014-11-03', 1),
		(2, 1, 2, '2014-11-04', '2014-11-05', 2),
		(3, 2, 1, '2014-11-01', '2014-11-02', 3),
		(4, 1, 2, '2014-11-06', '2014-11-08', 4),
		(5, 2, 3, '2014-11-07', '2014-11-09', 5),
		(6, 2, 1, '2014-11-10', '2014-11-14', 6),
		(7, 2, 3, '2014-11-15', '2014-11-17', 7),
		(8, 1, 1, '2014-11-16', '2014-11-17', 8);

insert into FishingPlace
			(fishingPlaceId,
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
