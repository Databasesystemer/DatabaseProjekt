use baneoversigt;

select * from TimeSlot;
select * from Bygning;
select * from Baner;
select * from Hold;
select * from eventss;
select * from Træner;
select * from HoldTræner;
select * from TræningsSession; 	

select * from HoldLog;
select * from TrænerLog;

DROP TABLE IF exists TrænerLog;
DROP TABLE IF EXISTS HoldLog;
DROP PROCEDURE IF EXISTS Oprydningsevent;
CREATE TABLE TrænerLog like Træner;
CREATE TABLE HoldLog like Hold;
DELIMITER //
CREATE PROCEDURE Oprydningsevent ()
BEGIN
INSERT INTO Trænerlog SELECT TrænerID, TrænerNavn, Stilling, Telefonnr, Løn, TilhørerBygning 
FROM Træner Where Træner.TrænerID NOT IN (SELECT Holdtræner.TrænerID FROM Holdtræner);
DELETE FROM Træner Where Træner.TrænerID NOT IN (SELECT Holdtræner.TrænerID FROM Holdtræner);

INSERT INTO Holdlog SELECT * 
FROM Hold Where Hold.Holdnavn NOT IN (SELECT Holdtræner.Holdnavn FROM Holdtræner);
DELETE FROM Hold Where Hold.Holdnavn NOT IN (SELECT Holdtræner.Holdnavn FROM Holdtræner);
END; //
DELIMITER ; 

DROP EVENT IF EXISTS Oprydning;
CREATE EVENT Oprydning
ON SCHEDULE EVERY 1 Minute
STARTS '2017-01-01 09:00:01'
DO CALL Oprydningsevent;
SET GLOBAL event_scheduler = 1;
SHOW VARIABLES LIKE 'event_scheduler';


DROP FUNCTION IF EXISTS HoldLimit;
DELIMITER //
CREATE FUNCTION HoldLimit(h_TrænerID VARCHAR(2))
RETURNS BOOLEAN
BEGIN
	DECLARE HoldCount INT;
	SELECT COUNT(holdtræner.TrænerID) INTO HoldCount FROM HoldTræner
    WHERE h_TrænerID=HoldTræner.TrænerID;
    IF HoldCount >1 THEN
		Return FALSE;
	ELSE
		IF h_trænerID not in (select Træner.TrænerID FROM Træner) THEN 
        Return FALSE; 
        ELSE
		Return TRUE;
        END IF;
	END IF;
END; // 
DELIMITER ;

select HoldLimit(AA);

DROP PROCEDURE IF EXISTS RegistrerHOLD;
DELIMITER //
CREATE PROCEDURE RegistrerHOLD (
	in r_TrænerID  VARCHAR(2),
	in r_HoldNavn  VARCHAR(40),
    in r_Niveau	   VARCHAR(40),
    in r_Størrelse DECIMAL(2,0),
    out message VARCHAR(100))
BEGIN
	DECLARE HoldFunk INT;
	SELECT HoldLimit(r_TrænerID) into HoldFunk;
    
	IF HoldFunk = 1 
		THEN INSERT Hold VALUES(r_HoldNavn,r_Niveau,r_Størrelse);
     SET message = 'Hold er oprettet';
	ELSEIF HoldFunk = 0
		THEN SET message = 'Fejl!: Træner findes ikke eller har for mange hold';
    END IF;
END //
DELIMITER ;
    
CALL RegistrerHOLD('AA','Fodbold C', 'Niveau B', '20',@v);
SELECT @v;
    
    