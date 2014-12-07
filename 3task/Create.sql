use [roman.dubinin]

if object_id('ExchangeRates', 'U') IS NOT NULL
drop table ExchangeRates;

if object_id('Currency', 'U') IS NOT NULL
drop table Currency;

if object_id('Purse', 'U') IS NOT NULL
drop table Purse;


create table Currency(
	currencyId int primary key not null,
	currencyName varchar(50) not null
)

create table Purse(
	idCurrency int not null,
	amount float not null
)

create table ExchangeRates(
	idCurrencyFrom int not null references Currency (currencyId),
	idCurrencyTo int not null references Currency (currencyId),
	price float not null,
	primary key (idCurrencyFrom, idCurrencyTo)
)

insert into Currency
           (currencyId,
		   currencyName)
     values
		(1, 'Rub'),
		(2, 'Usd'),
		(3, 'Eur'),
		(4, 'Aud'),
		(5, 'Btc');

insert into Purse
           (idCurrency,
		   amount)
     values
		(1, 5),
		(2, 3),
		(3, 3),
		(4, 1),
		(5, 3);

insert into ExchangeRates
           (idCurrencyFrom,
		   idCurrencyTo,
		   price)
     values
		(1, 1, 1),
		(2, 1, 1),
		(3, 1, 1),
		(4, 1, 1),
		(5, 1, 1),
		(1, 2, 3),
		(2, 2, 1),
		(3, 2, 1),
		(4, 2, 2),
		(5, 2, 1),
		(1, 3, 1),
		(2, 3, 1),
		(3, 3, 1),
		(4, 3, 1),
		(5, 3, 1),
		(1, 4, 2),
		(2, 4, 1),
		(3, 4, 1),
		(4, 4, 1),
		(5, 4, 1),
		(1, 5, 1),
		(2, 5, 1),
		(3, 5, 1),
		(4, 5, 1),
		(5, 5, 1);