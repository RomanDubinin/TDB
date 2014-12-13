create function MostAdvantageous(@minutes int) 
returns int
as
begin
	if @minutes <= 0
	begin
		return 0
	end
	declare @TariffId int = (
								select top 1 Tariffs.id
								from Tariffs
								order by Tariffs.licenseFee + dbo.InlineMax(0, @minutes - Tariffs.limit) * Tariffs.feeOver
							)
	return @TariffId
end	

print dbo.MostAdvantageous(40)

drop function MostAdvantageous