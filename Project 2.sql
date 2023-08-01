select systimestamp from dual;

select Username FROM USER_USERS;

select ROUND(To_Date('12-25-2021', 'MM-DD-YYYY') - sysdate) from dual;

select  TO_CHAR(cycledate, 'MON') as MONTH,
round(last_day(cycledate) - cycledate) as "Days between payday and first of next month" 
from payday;

select concat(concat(substr(person, (instr(person, ' ')), 10 ), ','), substr(person, 1, (instr(person, ' ')) ))
as PERSONS
from ledger
where person not like '%STORE%' 
and person not like '%OFFICE%'
and person not like '%AND%'
and person like '% %'
and person not like '%COMPANY%'
and person not like '%CHURCH%';

select DISTINCT substr(phone, 1, 3) as "AREA CODE" from address;

select RPAD(concat(concat(firstname, ' '), lastname), 50, '.') as NAME,
'(' || substr(phone,1,3) || ')' || substr(phone,5,10) as PHONE
from address;