# Opdater alle assistenter til Træner og giver dem mere i løn 


update Træner set stilling = 
				case when stilling = 'Assistent' 
					then  'Træner'
				else 'Træner'
				end,
                Løn = case when stilling = 'Træner'
					then 100
				else 50 
end; 


#eller 

#opdatere løn og sletter det fra bygning - alle assistemer tjekker ikke om der er midler nok 
UPDATE Bygning SET  Bygning.Midler = Bygning.Midler -100
    where Bygning.BygningsNavn in (select Træner.TilhørerBygning 
									from Træner
                                    inner join Holdtræner on Holdtræner.TrænerID = Træner.TrænerID
									where Træner.stilling = 'Assistent'
                                    group by Træner.TilhørerBygning
									 );
                                     
UPDATE Træner, Bygning SET Træner.stilling = 'Træner' , Træner.løn = 100, Bygning.Midler = CASE
    WHEN Træner.TilhørerBygning = BygningsNavn THEN Bygning.Midler -100
    ELSE Bygning.Midler
    END
WHERE Træner.TrænerID in (select Holdtræner.TrænerID 
									from Holdtræner
									group by Holdtræner.TrænerID
									Having count(Holdtræner.TrænerID) >0);