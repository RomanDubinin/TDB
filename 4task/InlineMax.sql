create function dbo.InlineMax(@val1 int, @val2 int)
returns int
as
begin
	if @val1 > @val2
		return @val1
	return @val2
end

drop Function InlineMax;