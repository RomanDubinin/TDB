use [roman.dubinin]

drop table ValidLetters;
drop function CheckLetter;


create table ValidLetters
(
	Letter char(1) PRIMARY KEY not null,
	Allowability bit not null
)
go

insert into [dbo].ValidLetters
           (Letter
           ,Allowability)
     VALUES
		('a', 1),
		('b', 0);
go

create function CheckLetter(@letter char)
returns bit
as
begin
	return
		case
			when 
				(select 'allowability'
				from ValidLetters
				where letter = @letter) = 1 then 1

			else 0
		end
end;