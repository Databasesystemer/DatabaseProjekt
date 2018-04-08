# eksempel på Join og Order by
SELECT TræningsSession.BaneNavn, BygningsNavn,HoldNavn, TrænerNavn, Stilling, DayCode, StartTime, EndTime
FROM TræningsSession 
join  Holdtræner on  TræningsSession.HoldtrænerID = Holdtræner.HoldtrænerID
join  Baner on  TræningsSession.BaneNavn = Baner.BaneNavn
join  TimeSlot on  TræningsSession.TimeSlotID = TimeSlot.TimeSlotID
join Træner on Holdtræner.TrænerID = Træner.TrænerID

order by BaneNavn, BygningsNavn, DayCode, StartTime, EndTime

# order by har ikke TrænerNavn -> så du ser i forhold til baner 