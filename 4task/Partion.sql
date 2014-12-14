if object_id('AllX', 'U') IS NOT NULL
drop table AllX;

if object_id('recurringMins', 'U') IS NOT NULL
drop table recurringMins;

if object_id('partion', 'U') IS NOT NULL
drop table partion;

select 
	dbo.IntersectionOfLines(0, tariff1.licenseFee, tariff2.feeOver, -(tariff2.limit - tariff2.licenseFee/tariff2.feeOver)*tariff2.feeOver) as intersection1,
	dbo.IntersectionOfLines(0, tariff2.licenseFee, tariff1.feeOver, -(tariff1.limit - tariff1.licenseFee/tariff1.feeOver)*tariff1.feeOver) as intersection2,
	dbo.IntersectionOfLines(tariff1.feeOver, -(tariff1.limit - tariff1.licenseFee/tariff1.feeOver)*tariff1.feeOver, tariff2.feeOver, -(tariff2.limit - tariff2.licenseFee/tariff2.feeOver)*tariff2.feeOver) as intersection3
into AllX
from Tariffs as tariff1
cross join Tariffs as tariff2


select intersection1 as mins into recurringMins from AllX
where intersection1 > 0
union
select intersection2 from AllX
where intersection2 > 0
union
select intersection3 from AllX
where intersection3 > 0


select *
into partion
from
(
	select mins, dbo.MostAdvantageous(mins-1) as less, dbo.MostAdvantageous(mins) as exactly, dbo.MostAdvantageous(mins+1) as greater
	from recurringMins
) p
where p.less != p.exactly or p.exactly != p.greater

select * from partion

declare @left varchar(50) = ''
declare @right varchar(50) = ''
declare @tar varchar(50) = ''
declare @last varchar(50) = ''
declare @beautifulPartion table (
	tarif varchar(50) not null,
	leftBorder varchar(50) not null,
	rightBorder varchar(50) not null
);

declare x cursor for 
select mins, less, greater from partion
open x

fetch next from x into  @right, @tar, @last
	
	insert into @beautifulPartion values
	(@tar, '0.0', @right)
	set @left = @right

while @@FETCH_STATUS = 0
begin
	fetch next from x into  @right, @tar, @last
	
	if @left != @right
		insert into @beautifulPartion values
		(@tar, @left, @right)
	set @left = @right
	
end

insert into @beautifulPartion values
(@last, @left, '10000')

select * 
from @beautifulPartion

close x
deallocate x