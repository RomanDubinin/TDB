use sql

if object_id('Tariffs', 'U') IS NOT NULL
drop table Tariffs;

create table Tariffs(
	id int primary key not null,
	name varchar(50) not null,
	licenseFee int not null,
	limit int not null,
	feeOver int not null
);

insert Tariffs values
	(1, 'tariff1', 30, 40, 2),
	(2, 'tariff2', 0, 0, 1),
	(3, 'tariff3', 40, 40, 1.5),
	(4, 'tariff4', 0, 5, 2)