Select 
Name as MENU_NAME
From menu mu
Where (Select Count(*)
       From orders od
       Where od.MenuID = mu.MenuID
       Group By od.CustomerID
       Having Count(*) > 2)
