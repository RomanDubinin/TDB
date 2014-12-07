use [roman.dubinin]


if object_id('tmp1', 'U') IS NOT NULL
drop table tmp1;

if object_id('ExchengesForMyPurse', 'U') IS NOT NULL
drop table ExchengesForMyPurse;

select ExchangeRates.idCurrencyFrom, ExchangeRates.idCurrencyTo, ExchangeRates.price, Purse.amount
into tmp1
from ExchangeRates, Purse
where ExchangeRates.idCurrencyFrom = Purse.idCurrency



select idCurrencyFrom, idCurrencyTo, price, amount
into ExchengesForMyPurse
from tmp1
where idCurrencyTo = 2

select *
from ExchengesForMyPurse