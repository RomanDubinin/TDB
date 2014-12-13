create function dbo.IntersectionOfLines(@k1 float, @b1 float, @k2 float, @b2 float)
returns int
as
begin
	declare @eps float = 0.0001
	declare @res float = -1

		if abs(@k1-@k2) > @eps
		begin
			set @res = (@b2 - @b1)/(@k1-@k2)
		end
	return @res
end

print dbo.IntersectionOfLines(2, -14,2, -0.25)

drop Function IntersectionOfLines;