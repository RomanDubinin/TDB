create function MostAdvantageous(@minutes int) 
returns varchar(50)
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
	declare @TariffName varchar(50) = (
										select top 1 Tariffs.name
										from Tariffs
										where Tariffs.id = @TariffId
									)
	return @TariffName
end	

print dbo.MostAdvantageous(40)

drop function MostAdvantageous