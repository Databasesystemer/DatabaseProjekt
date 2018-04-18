#Opdater Midler for bygninger hvis de har mere end 2 trænere 

UPDATE Bygning  SET Bygning.Midler = Bygning.Midler * 1.10 
where Bygning.BygningsNavn in (select Træner.TilhørerBygning
									from Træner
									group by Træner.TilhørerBygning
									Having count(Træner.TilhørerBygning) >2);