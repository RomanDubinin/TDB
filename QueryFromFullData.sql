USE [roman.dubinin]
GO


/* Выдать упорядоченный список дат, в которые проводились измерения (без повторений). */
select distinct TimeDate
from FullData
order by TimeDate asc

GO

/* Выдать максимальное и минимальное значение различных измерений. */
select MeasurementTypeId, min(Value) as "Min", max(Value) as "Max"
from FullData
group by MeasurementTypeId

/* Напишите запрос с подзапросом для получения данных, (Влож. ыудусе)которые измеряются в градусах. */
select Value as 'Температура' 
from FullData where MeasurementTypeId in
	(select id from MeasurementTypes where id in
		(select id from MeasurementValueNames where MeasurementValueName = 'градусы цельсия')
	)


/*Напишите команду SELECT, использующую связанные подзапросы и выполняющую вывод дат, в которые были минимальное значение измерений.*/
select TimeDate, MeasurementTypeId, Value as "Min"
from FullData
where Value in
	(select min(Value)
	from FullData
	group by MeasurementTypeId)

/* Выдать средние значения разных типов измерений ( c единицами измерений) на определенную дату по каждой станции. 
Заголовки полей итоговых таблиц должны быть на русском языке, даты в виде dd.month.yy(yyyy).  */
select 
	format (TimeDate, 'dd-MM-yyyy') as 'Дата', 
	(select StationName 
		from StationNames where Id = StationId) as 'Станция',
	(select  MeasurementType
		from MeasurementTypes where Id = MeasurementTypeId) as 'тип измерения',
	avg(Value) as 'среднее зн-е',
	(select MeasurementValueName
		from MeasurementValueNames where Id = MeasurementTypeId) as 'ед-цы измерения'
from FullData 
	group by TimeDate, StationId, MeasurementTypeId