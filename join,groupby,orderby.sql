SELECT BaneNavn, BygningsNavn,HoldNavn, TrænerNavn, DayCode, StartTime, EndTime
FROM TræningsSession 
join  Holdtræner on  TræningsSession.HoldtrænerID = Holdtræner.HoldtrænerID
join  Baner on  TræningsSession.BaneID = Baner.BaneID
join  TimeSlot on  TræningsSession.TimeSlotID = TimeSlot.TimeSlotID
join Træner on Holdtræner.TrænerID = Træner.TrænerID

Group by BaneNavn, BygningsNavn,HoldNavn, TrænerNavn, DayCode, StartTime, EndTime
order by BaneNavn, BygningsNavn,HoldNavn, TrænerNavn, DayCode, StartTime, EndTime