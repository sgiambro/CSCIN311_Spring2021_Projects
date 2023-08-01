
select DISTINCT action
from ledger;

create view  LEDGER_SALES as
select person , actiondate , sum(amount) as "TOT_AMT"
from ledger
where action = 'BOUGHT'
group by person , actiondate;

select MIN(amount) , MAX(amount) , ROUND(AVG(amount),2)
from ledger;

select  person , count(*)
from ledger 
group by person
having count(*) > 1
order by count(*) desc;

select person , sum(amount) as "TOT_AMT"
from ledger , worker
where person = name
group by person;

select  person , DECODE(GROUPING(amount), 1, 'NEVER BOUGHT', amount) as "TOT_AMT"
from ledger full outer join worker on ledger.person = worker.name
where person = name
group by person , amount
order by person;

select worker.name , lodging , age 
from worker , workerskill
where worker.name = workerskill.name and
    ability != 'GOOD' and
    ability != 'AVERAGE' and
    ability != 'EXCELLENT';
    
select worker.name , lodging , age 
from workerskill full outer join worker on workerskill.name = worker.name
where worker.name = workerskill.name and
    ability != 'GOOD' and
    ability != 'AVERAGE' and
    ability != 'EXCELLENT';
    
select RPAD((DECODE(GROUPING(person), 1, 'ALL PEOPLE', person)), 30 , ' ') as "PERSON",
    DECODE(GROUPING(actiondate), 1, 'ALL MONTHS', to_char(actiondate , 'MONTH')) as "MONTH" , 
    sum(quantity*rate) as "TOT_AMT"
from ledger
group by rollup(person , actiondate , (quantity*rate));
