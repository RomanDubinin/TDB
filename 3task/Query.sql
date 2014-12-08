
create procedure TotalWealth @nameCurrency varchar(5) as
begin 
	if object_id('tmp1', 'U') IS NOT NULL
	drop table tmp1;
	
	if object_id('ExchengesForMyPurse', 'U') IS NOT NULL
	drop table ExchengesForMyPurse;
	
	if object_id('SeparatedWealth', 'U') IS NOT NULL
	drop table SeparatedWealth;
	
	select ExchangeRates.idCurrencyFrom, ExchangeRates.idCurrencyTo, ExchangeRates.price, Purse.amount
	into tmp1
	from ExchangeRates, Purse
	where ExchangeRates.idCurrencyFrom = Purse.idCurrency
	
	select idCurrencyFrom, idCurrencyTo, price, amount
	into ExchengesForMyPurse
	from tmp1
	where idCurrencyTo in
		(
			select currencyId 
			from Currency
			where currencyName = 'Usd'
		)
	
	select *
	from ExchengesForMyPurse
	
	select idCurrencyFrom, price * amount as wealth
	into SeparatedWealth
	from ExchengesForMyPurse
	
	select *
	from SeparatedWealth
	
	select sum(wealth) as worth
	from SeparatedWealth
end

exec TotalWealth @nameCurrency = 'Usd'

drop procedure TotalWealth;