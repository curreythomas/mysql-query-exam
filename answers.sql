/*
1. Select a distinct list of ordered airports codes. Be sure to name the column correctly. Be sure to order the results correctly.
*/

-- SELECT DISTINCT departAirport as Airports FROM flight ORDER BY departAirport ASC;


/*
2. Provide a list of delayed flights departing from San Francisco (SFO).
*/

-- SELECT airline.name,  flight.flightNumber, flight.scheduledDepartDateTime, flight.arriveAirport, flight.status FROM airline INNER JOIN flight ON airline.ID = flight.airlineID WHERE flight.status = 'delayed' && flight.departAirport = 'SFO'


/*
3. Provide a distinct list of cities that American airlines departs from.
*/

-- SELECT DISTINCT f.departAirport AS Cities FROM flight AS f INNER JOIN airline AS a ON a.ID = f.airlineID WHERE a.name = 'American' ORDER BY Cities ASC;

/*
4. Provide a distinct list of airlines that conduct flights departing from ATL. 
*/

-- SELECT DISTINCT a.name AS Airline FROM airline AS a INNER JOIN flight AS f ON f.airlineID = a.ID WHERE f.departAirport = 'ATL' ORDER BY Airline ASC;

/*
5. Provide a list of airlines, flight numbers, departing airports, and arrival airports where flights departed on time.
HINT: The scheduled and actual depart date times can be used to determine if a flight is on time.
*/

-- SELECT a.name, f.flightNumber, f.departAirport, f.arriveAirport  FROM airline AS a INNER JOIN flight AS f ON f.airlineID = a.ID WHERE f.scheduledDepartDateTime = f.actualDepartDateTime ORDER BY f.flightNumber ASC;

/*
6. Provide a list of airlines, flight numbers, gates, status, and arrival times arriving into Charlotte (CLT) on 10-30-2017. 
Order your results by the arrival time.
*/

-- SELECT a.name AS Airline, f.flightNumber AS Flight, f.gate AS Gate, TIME(f.scheduledArriveDateTime) as Arrival, f.status AS Status FROM airline AS a INNER JOIN flight AS f ON f.airlineID = a.ID WHERE f.arriveAirport = 'CLT' AND DATE(f.scheduledArriveDateTime) = '2017-10-30' ORDER BY Arrival ASC;

/*
7. List the number of reservations by flight number. Order by reservations in descending order
*/

-- SELECT f.flightNumber AS flight, COUNT(r.ID) AS reservations FROM flight AS f INNER JOIN reservation AS r ON f.ID = r.flightID GROUP BY flight ORDER BY reservations DESC;

/*
8. List the average ticket cost for coach by airline and route. Order by AverageCost in descending order.
*/

-- SELECT a.name as airline, f.departAirport, f.arriveAirport, AVG(r.cost) AS AverageCost FROM airline AS a INNER JOIN flight AS f ON f.airlineID = a.ID INNER JOIN reservation as r ON f.id = r.flightID WHERE r.class = 'coach' GROUP BY f.departAirport, f.arriveAirport, a.name ORDER BY AverageCost DESC;

/*
9. Which route is the longest?
*/

-- SELECT departAirport, arriveAirport, miles FROM flight ORDER BY miles DESC LIMIT 1;

/*
10. List the top 5 passengers that have flown the most miles. Order by miles.
*/

-- SELECT p.firstName, p.lastName, SUM(f.miles) AS miles FROM flight AS f INNER JOIN reservation AS r ON r.flightID = f.ID INNER JOIN passenger AS p ON p.ID = r.passengerID GROUP BY p.firstName, p.lastName ORDER BY miles DESC LIMIT 5;


/*
11. Provide a list of American airline flights ordered by route and arrival date and time.
*/

-- SELECT a.name AS Name, CONCAT_WS(' --> ', f.departAirport, f.arriveAirport) AS Route, DATE(f.scheduledArriveDateTime) AS 'Arrive Date', TIME(f.scheduledArriveDateTime) AS 'Arrive Time' FROM airline AS a INNER JOIN flight AS f ON f.airlineID = a.ID WHERE Name = 'American' ORDER BY Route, f.scheduledArriveDateTime ASC;

/*
12. Provide a report that counts the number of reservations and totals the reservation 
costs (as Revenue) by Airline, flight, and route. 
Order the report by total revenue in descending order.
*/

-- SELECT a.name AS Airline, f.flightNumber AS Flight, CONCAT_WS(' --> ', f.departAirport, f.arriveAirport) AS Route, COUNT(r.id) AS 'Reservation Count', SUM(r.cost) as Revenue  FROM reservation AS r INNER JOIN flight AS f ON r.flightID = f.ID INNER JOIN airline AS a ON f.airlineID = a.ID GROUP BY Airline, Flight, Route ORDER BY Revenue DESC;


/*
13. List the average cost per reservation by route. Round results down to the dollar.
*/

-- SELECT CONCAT_WS(' --> ', f.departAirport, f.arriveAirport) AS Route, FLOOR(AVG(r.cost)) AS 'Avg Revenue' FROM flight AS f INNER JOIN reservation AS r ON f.ID = r.flightID GROUP BY Route ORDER BY FLOOR(AVG(r.cost)) DESC;

/*
14. List the average miles per flight by airline.
*/

-- SELECT a.name as Airline, AVG(f.miles) AS 'Avg Miles Per Flight' FROM flight AS f INNER JOIN airline AS a ON f.airlineID = a.ID GROUP BY Airline ORDER BY Airline ASC;

/*
15. Which airlines had flights that arrived early?
*/

-- SELECT DISTINCT a.name AS Airline FROM flight AS f INNER JOIN airline AS a ON a.ID = f.airlineID WHERE (f.actualArriveDateTime - f.scheduledArriveDateTime) < 0 ;