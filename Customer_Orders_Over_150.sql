Select
cs.CustomerID,
cs.FirstName,
cs.LastName,
od.OrderID,
od.TotalCost,
mn.Name as MenuName,
mi.Course
From customers cs
Join orders od
  on od.CustomerID = cs.CustomerID
Join menu mn
  on mn.MenuID = od.MenuID
Join menucontent mc
  on mc.MenuID = mn.MenuID
Join menuitems mi
  on mi.MenuItemID = mc.MenuItemID
Where TotalCost > 150.00
Order by TotalCost
