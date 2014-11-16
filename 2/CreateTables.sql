use [roman.dubinin]

drop table Regions;
drop table Cars;
drop table Colors;
drop table Drivers;
drop table Observation;


create table Regions
(
	RegionNumber int primary key not null,
	RegionName char(50) not null
)

create table Cars
(
	CarNumber char(6) primary key not null,
	ColorId int not null,
	Brand char(50) not null,
	DriverId int
)

create table Colors
(
	ColorId int primary key not null,
	ColorName char(50) not null
)

create table Drivers
(
	DriverId int primary key not null,
	DriverName char(50) not null
)

create table Observation
(
	CarNumber char(6) not null,
	Direction char(3) not null,
	IntersectionTime time not null,
	PostNumber int not null
)