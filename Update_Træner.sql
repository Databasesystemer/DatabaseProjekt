                                  
                                     
UPDATE Træner, Bygning SET Træner.stilling = 'Træner' , Træner.løn = 150, Bygning.Midler = CASE
    WHEN Træner.TilhørerBygning = BygningsNavn THEN Bygning.Midler - 50
    ELSE Bygning.Midler
    END
WHERE Træner.TrænerID in (select Holdtræner.TrænerID 
									from Holdtræner
									group by Holdtræner.TrænerID
									Having count(Holdtræner.TrænerID) >1);
                                    
                                    