USE BaneOversigt;

DELETE FROM TimeSlot
Where TimeSlotID IN 
(SELECT TimeSlotID FROM TræningsSession WHERE HoldNavn = 'Fodbold B');

DELETE FROM Hold
Where Størrelse < 13 ;

#SELECT StartTime, EndTime, HoldNavn
#FROM TimeSlot 
#NATURAL JOIN Træningssession
#WHERE DayCode = 'M' AND EndTime = '21:00:00';

