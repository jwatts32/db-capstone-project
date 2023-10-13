Prepare GetOrderDetail 
From 'Select OrderID, Quantity, TotalCost From Orders where OrderID=?';

SET @id = 1;
EXECUTE GetOrderDetail USING @id;