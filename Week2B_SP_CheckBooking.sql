Drop Procedure If Exists CheckBooking;
Create Procedure CheckBooking(BookingDate Date, TableNo Int)
Select Concat("Table ", TableNo, " is already booked for", BookingDate, ".") as BOOKING_STATUS
Where Exists (Select * From bookings 
			  Where Date = BookingDate 
				and TableNumber = TableNo );
                
Call CheckBooking('2022-11-12', 3)