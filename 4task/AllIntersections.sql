select 
	dbo.IntersectionOfLines(0, tariff1.licenseFee, tariff2.feeOver, -(tariff2.limit - tariff2.licenseFee/tariff2.feeOver)*tariff2.feeOver),
	dbo.IntersectionOfLines(0, tariff2.licenseFee, tariff1.feeOver, -(tariff1.limit - tariff1.licenseFee/tariff1.feeOver)*tariff1.feeOver),
	dbo.IntersectionOfLines(tariff1.feeOver, -tariff1.limit + tariff1.licenseFee, tariff2.feeOver, -tariff2.limit + tariff2.licenseFee)
from Tariffs as tariff1
cross join Tariffs as tariff2