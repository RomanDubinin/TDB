use [sql]

exec Departures @boatType = 'Type1', @dateFrom = '2014-11-01', @dateTo = '2014-11-21'

exec AddFishingPlace @placeName = 'pl4', @x = 1, @y = 1

exec BoatsOnPlace @placeName = 'Place1', @qality = 'good'

exec Departures2 @dateFrom = '2014-11-08', @dateTo = '2014-11-25'


