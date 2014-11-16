USE [roman.dubinin]
GO


/* ������ ������������� ������ ���, � ������� ����������� ��������� (��� ����������). */
select distinct TimeDate
from FullData
order by TimeDate asc

GO

/* ������ ������������ � ����������� �������� ��������� ���������. */
select MeasurementTypeId, min(Value) as "Min", max(Value) as "Max"
from FullData
group by MeasurementTypeId

/* �������� ������ � ����������� ��� ��������� ������, (����. ������)������� ���������� � ��������. */
select Value as '�����������' 
from FullData where MeasurementTypeId in
	(select id from MeasurementTypes where id in
		(select id from MeasurementValueNames where MeasurementValueName = '������� �������')
	)


/*�������� ������� SELECT, ������������ ��������� ���������� � ����������� ����� ���, � ������� ���� ����������� �������� ���������.*/
select TimeDate, MeasurementTypeId, Value as "Min"
from FullData
where Value in
	(select min(Value)
	from FullData
	group by MeasurementTypeId)

/* ������ ������� �������� ������ ����� ��������� ( c ��������� ���������) �� ������������ ���� �� ������ �������. 
��������� ����� �������� ������ ������ ���� �� ������� �����, ���� � ���� dd.month.yy(yyyy).  */
select 
	format (TimeDate, 'dd-MM-yyyy') as '����', 
	(select StationName 
		from StationNames where Id = StationId) as '�������',
	(select  MeasurementType
		from MeasurementTypes where Id = MeasurementTypeId) as '��� ���������',
	avg(Value) as '������� ��-�',
	(select MeasurementValueName
		from MeasurementValueNames where Id = MeasurementTypeId) as '��-�� ���������'
from FullData 
	group by TimeDate, StationId, MeasurementTypeId