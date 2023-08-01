--1. Create a function that computes an age. The function will take a date as 
--   the input and return the age. Use a select statement to test the function.


create or replace function age_ICA(bd IN DATE)
return NUMBER
is
age Number;
begin
	age :=  ROUND(((sysdate) - (bd))/365 , 0);
return (age);
end;
/

select * from Birthday;

select firstname , birthdate, age_ICA(birthdate) age FROM Birthday;

