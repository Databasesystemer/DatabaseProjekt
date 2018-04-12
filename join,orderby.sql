# eksempel på Join og Order by
SELECT Baner.BygningsNavn,TræningsSession.BaneNavn,  TræningsSession.HoldNavn, TrænerNavn, Stilling, DayCode, StartTime, EndTime
FROM TræningsSession 
join  Holdtræner on  TræningsSession.HoldNavn = Holdtræner.HoldNavn
join  Baner on  TræningsSession.BaneNavn = Baner.BaneNavn
join  TimeSlot on  TræningsSession.TimeSlotID = TimeSlot.TimeSlotID
join Træner on Holdtræner.TrænerID = Træner.TrænerID

order by  BygningsNavn,BaneNavn, HoldNavn,  DayCode, StartTime, EndTime;

# order by har ikke TrænerNavn -> så du ser i forhold til baner 

#  Group by til at finde hvor mange hold en træner har 
select TrænerNavn, TrænerID, count(Holdtræner.TrænerID) as antalHold
from Træner NATURAL left outer JOIN  HoldTræner
group by TrænerNavn, TrænerID;

# Hvilke Events bliver alfholdt i uge 28 og hvor bliver de afholdet henne 
select EventNavn, DayCode, StartTime, EndTime, BygningsNavn
From Eventss 
natural  left outer join TimeSlot
where Uge = 28
order by EventNavn;