UPDATE Bygning SET  Bygning.Midler = Bygning.Midler -50
    where Bygning.BygningsNavn in (select Træner.TilhørerBygning 
									from Træner
                                    inner join Holdtræner on Holdtræner.TrænerID = Træner.TrænerID
									where Træner.stilling = 'Assistent'
                                    group by Træner.TilhørerBygning
									 );
update Træner set stilling = 
				case when stilling = 'Assistent' 
					then  'Træner'
				else 'Træner'
				end,
                Løn = case when stilling = 'Træner'
					then 100
				else 50 
end; 						
                                     
    
    