# eksempel på Join og Order by
SELECT Baner.BygningsNavn,TræningsSession.BaneNavn,  TræningsSession.HoldNavn, TrænerNavn, Stilling, DayCode, StartTime, EndTime
FROM TræningsSession 
join  Holdtræner on  TræningsSession.HoldNavn = Holdtræner.HoldNavn
join  Baner on  TræningsSession.BaneNavn = Baner.BaneNavn
join  TimeSlot on  TræningsSession.TimeSlotID = TimeSlot.TimeSlotID
join Træner on Holdtræner.TrænerID = Træner.TrænerID

order by  BygningsNavn,BaneNavn, HoldNavn,  DayCode, StartTime, EndTime

# order by har ikke TrænerNavn -> så du ser i forhold til baner 