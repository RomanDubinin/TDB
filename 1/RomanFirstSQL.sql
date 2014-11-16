use [roman.dubinin]

DROP TABLE FullData;
DROP TABLE MeasurementValueNames;
DROP TABLE MeasurementTypes;
DROP TABLE StationNames;


CREATE TABLE StationNames
(
	StationName char(50) not null
	,Id int PRIMARY KEY not null
)

CREATE TABLE MeasurementTypes
(
	MeasurementType char(50) not null
	,Id int PRIMARY KEY not null
)

CREATE TABLE FullData
(
	StationId int not null
	,MeasurementTypeId int not null
	,TimeDate date not null
	,Value real not null
)

ALTER TABLE FullData
ADD FOREIGN KEY (StationId) 
    REFERENCES StationNames (Id) 

ALTER TABLE FullData
ADD FOREIGN KEY (MeasurementTypeId) 
    REFERENCES MeasurementTypes (Id) 

ALTER TABLE StationNames
ADD addr text NULL
DEFAULT ('Россия')


CREATE TABLE MeasurementValueNames
(
	Id int not null primary key
	,MeasurementValueName char(50) not null
	,symbol char not null
)

ALTER TABLE MeasurementValueNames
ADD FOREIGN KEY (Id) 
    REFERENCES MeasurementTypes (Id) 



