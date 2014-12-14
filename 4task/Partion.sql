if object_id('AllX', 'U') IS NOT NULL
drop table AllX;

if object_id('recurringX', 'U') IS NOT NULL
drop table recurringX;

select 
	dbo.IntersectionOfLines(0, tariff1.licenseFee, tariff2.feeOver, -(tariff2.limit - tariff2.licenseFee/tariff2.feeOver)*tariff2.feeOver) as intersection1,
	dbo.IntersectionOfLines(0, tariff2.licenseFee, tariff1.feeOver, -(tariff1.limit - tariff1.licenseFee/tariff1.feeOver)*tariff1.feeOver) as intersection2,
	dbo.IntersectionOfLines(tariff1.feeOver, -(tariff1.limit - tariff1.licenseFee/tariff1.feeOver)*tariff1.feeOver, tariff2.feeOver, -(tariff2.limit - tariff2.licenseFee/tariff2.feeOver)*tariff2.feeOver) as intersection3
into AllX
from Tariffs as tariff1
cross join Tariffs as tariff2


select intersection1 as x into recurringX from AllX
where intersection1 > 0
union
select intersection2 from AllX
where intersection2 > 0
union
select intersection3 from AllX
where intersection3 > 0


select *
from
(
	select x, dbo.MostAdvantageous(x-1) as less, dbo.MostAdvantageous(x) as exactly, dbo.MostAdvantageous(x+1) as greater
	from recurringX
) partion
where partion.less != partion.exactly or partion.exactly != partion.greater

