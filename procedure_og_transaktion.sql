use BaneOversigt;


DROP PROCEDURE  IF EXISTS insætTrænerMidlerogløn;


DELIMITER //
CREATE PROCEDURE insætTrænerMidlerogløn (
	IN TrænerID VARCHAR(15), TrænerNavn VARCHAR(40), Stilling VARCHAR(40), Telefonnr DECIMAL(8,0), 
	   Løn DECIMAL(4,0),TilhørerBygning	VARCHAR(15),OUT vStatus VARCHAR(45)) 
       
    BEGIN
		DECLARE OldAmountID1, OldAmountID2, NewAmountID2 INT DEFAULT 0; 
		START TRANSACTION;
        
			SET OldAmountID1 = løn;
				INSERT Træner VALUES(TrænerID ,TrænerNavn,Stilling,Telefonnr,Løn, TilhørerBygning);
                
			SET OldAmountID2 = (SELECT Midler FROM Bygning WHERE BygningsNavn = TilhørerBygning); 
            SET NewAmountID2 = OldAmountID2 - OldAmountID1;
				UPDATE Bygning SET Midler = NewAmountID2 WHERE BygningsNavn = TilhørerBygning;
                
		IF NewAmountID2 > 0
            THEN SET vStatus = 'Træner er oprettet - Penge overført!'; COMMIT;
			ELSE SET vStatus = 'Træner er ikke oprettet - Mangler penge'; ROLLBACK; END IF;
END; // DELIMITER ;

call insætTrænerMidlerogløn ('AH','My','Træner','51345520' , '100', 'Håndbold', @TStatus);

SELECT @TStatus;


