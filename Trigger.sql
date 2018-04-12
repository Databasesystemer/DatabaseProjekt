DROP TRIGGER Eventss_for_Before_Insert;
USE BaneOversigt;

select * from Eventss; 

DELIMITER $$
CREATE TRIGGER Eventss_for_Before_Insert
BEFORE INSERT ON Eventss FOR EACH ROW
BEGIN
DECLARE Uge_ INT(2);
DECLARE TimeSlotID_ VARCHAR(2);
SELECT Uge,TimeSlotID INTO Uge_,TimeSlotID_ FROM Eventss WHERE Uge = NEW.Uge;
IF ( NEW.TimeSlotID = TimeSlotID_ ) THEN
SIGNAL SQLSTATE 'HY000'
SET MYSQL_ERRNO = 1525, 
MESSAGE_TEXT = 'Uge og TimeSlotID er allerede optaget til et andet event'; 
END IF;
END; $$ 
DELIMITER ;

INSERT Eventss VALUES
('KA', 'g','K', '2','Fodbold');

select * from Eventss; 
delete from Eventss where EventID = 'KA';
