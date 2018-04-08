create database BaneOversigt;
use BaneOversigt;

# Names of tables and attributes are changed slightly to improve the naming standard!

# If the tables already exists, then they are deleted!

DROP TABLE IF EXISTS TimeSlot;
DROP TABLE IF EXISTS Hold;
DROP TABLE IF EXISTS Træner;
DROP TABLE IF EXISTS TræningSektion;
DROP TABLE IF EXISTS Eventss;
DROP TABLE IF EXISTS Bygning;
DROP TABLE IF EXISTS Baner;

# Table creation! Create Tables with Foreign Keys after the referenced tables are created!
CREATE TABLE TimeSlot
	(TimeSlotID 	VARCHAR(15) NOT NULL,
	 DayCode		ENUM('M','Ti','O','To','F','L','S'),
	 StartTime		TIME,
	 EndTime		TIME,
	 PRIMARY KEY(TimeSlotID, DayCode, StartTime)
	);
    
CREATE TABLE Bygning
	(BygningsNavn			VARCHAR(15) NOT NULL,
     Kapacitet				DECIMAL(3,0),
     Handicapfaciliteter	ENUM('Nej','Ja'),
     Badefacilitet 			ENUM('Nej','Ja'),
     Midler					DECIMAL(6,0),
	 PRIMARY KEY(BygningsNavn)
     );
    

CREATE TABLE Baner
	(BaneNavn			VARCHAR(15) NOT NULL,
     BygningsNavn		VARCHAR(15),
	 PRIMARY KEY(BaneNavn),
     FOREIGN KEY(BygningsNavn) 	REFERENCES Bygning(BygningsNavn) 	ON DELETE SET NULL
	);
    
    CREATE TABLE Hold
	(HoldNavn 		VARCHAR(40) NOT NULL,
	 Niveau			VARCHAR(40),
     Størrelse      DECIMAL(2,0),
	 PRIMARY KEY(HoldNavn)
	);
    

CREATE TABLE Eventss
	(EventID		VARCHAR(15) NOT NULL,
	 EventNavn		VARCHAR(50),
	 TimeSlotID		VARCHAR(15),
	 Uge			DECIMAL(2,0),
     BygningsNavn	VARCHAR(15),
	 PRIMARY KEY(EventID),
     FOREIGN KEY(TimeslotID) 	REFERENCES TimeSlot(TimeSlotID) 	ON DELETE SET NULL,
     FOREIGN KEY(BygningsNavn) 	REFERENCES Bygning(BygningsNavn) 		ON DELETE SET NULL
	);
    

CREATE TABLE Træner
	(TrænerID		VARCHAR(15) NOT NULL,
	 TrænerNavn 	VARCHAR(40),
	 Stilling		VARCHAR(40),
     Telefonnr		DECIMAL(8,0),
     Løn			DECIMAL(4,0),
	 PRIMARY KEY(TrænerID)
	);

    
CREATE TABLE Holdtræner
	(HoldtrænerID	VARCHAR(15) NOT NULL,
	 HoldNavn 		VARCHAR(15) NOT NULL,
	 TrænerID		VARCHAR(15) NOT NULL,
	 PRIMARY KEY(HoldtrænerID, TrænerID, HoldNavn)
	);
 
CREATE TABLE TræningsSession
	(TræningID		VARCHAR(15) NOT NULL,
	 BaneNavn	 	VARCHAR(15) NOT NULL,
	 TimeslotID		VARCHAR(15) NOT NULL,
     HoldtrænerID   VARCHAR(15) NOT NULL, 
	 PRIMARY KEY(TræningID),
     FOREIGN KEY(BaneNavn) 		REFERENCES Baner(BaneNavn) ON DELETE cascade,
     FOREIGN KEY(TimeSlotID) 	REFERENCES TimeSlot(TimeSlotID) ON DELETE CASCADE,
     FOREIGN KEY(HoldtrænerID) 	REFERENCES Holdtræner(HoldtrænerID) ON DELETE CASCADE
	);
    
    
INSERT TimeSlot VALUES
('A','M','18:00','20:00'),
('A','O','18:00','20:00'),
('A','F','18:00','20:00'),
('B','M','19:00','21:00'),
('B','O','19:00','21:00'),
('F','Ti','19:00','21:00'),
('C','M','20:00','21:00'),
('G','O','20:00','21:00'),
('H','M','20:00','21:00'),
('D','M','18:00','20:00'),
('D','O','19:00','20:00'),
('H','Ti','18:00','20:00'),
('E','L','10:00','14:00'),
('G','S','08:00','12:00'),
('J','L','18:00','23:59'),
('K', 'S', '18:00','23:59'),
('L', 'M', '09:00','12:59'),
('M', 'O', '09:00','12:59');



INSERT Bygning VALUES
('Fodbold','100', 'Ja', 'Nej','10000'),
('Håndbold','150','Nej', 'Ja','8000'),
('Badminton', '50','Ja', 'Ja','5000'),
('Tennis', '50','Nej', 'Ja','5000');

INSERT Baner VALUES
('Bane 1F','Fodbold'),
('Bane 1H','Håndbold'),
('Bane 1B','Badminton'),
('Bane 2B','Badminton'),
('Bane 3B','Badminton'),
('Bane 4B','Badminton'),
('Bane 1T','Tennis');

INSERT Hold VALUES 
('Fodbold A','Niveau A', '20'),
('Fodbold B','Niveau B', '20'),
('Håndbold A','Niveau A', '15'),
('Håndbold B','Niveau B', '15'),
('Badminton A', 'Niveau A', '12'),
('Badminton B', 'Niveau B', '12');

INSERT Træner VALUES
('AA', 'Jens', 'Træner','21436587','100'),
('AB', 'Iben', 'Træner','21928584','100'),
('AC', 'Mikkel','Assistent','86895476','50'),
('AD', 'Børge' , 'Assistent','45678912','50'),
('AE', 'Hans', 'Træner', '43547674','100'),
('AF','Marie','Træner','45867930','100');

INSERT HoldTræner VALUES
('BA', 'Fodbold A', 'AA'),
('BB', 'Fodbold B', 'AA'),
('BC', 'Badminton B', 'AC'),
('BC', 'Badminton B', 'AF'),
('BD', 'Håndbold B', 'AD'),
('BD', 'Håndbold B', 'AE');

INSERT Eventss VALUES
('DA', 'Elevfest - Holmebæk skolen','K', '2', 'Fodbold'),
('DB', 'Fodbold fest','K', '5','Fodbold'),
('DC', 'Kvinde yoga - Pensionister','L', '10','Badminton'),
('DD', '4C - Herfølgeskole','L', '20','Håndbold'),
('DE', '9A - Hastrupskolen','M', '28','Håndbold');

INSERT TræningsSession VALUES
('CA','Bane 1F','A','BA'),
('CB','Bane 1F','B','BB'),
('CC','Bane 1B','C','BC'),
('CD','Bane 2B','C','BC'),
('CE','Bane 1H','D','BD'),
('CF','Bane 1H','H','BD');


CREATE VIEW Holdtræner_view AS
SELECT TrænerNavn, Stilling, HoldNavn 
FROM Holdtræner natural join Træner;

# Does it work





    
