use [roman.dubinin]

drop function Che�kCarNum;
go

create function Che�kCarNum(@num char(6))
returns bit
as
begin
	return dbo.CgeckLetter(LEFT([@num], 1)) & 
		   dbo.CgeckLetter(LEFT([@num], 5)) & 
		   dbo.CgeckLetter(LEFT([@num], 6));
end;