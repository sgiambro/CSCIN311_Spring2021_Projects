select * from worker 
WHERE lodging = 'MATTS';

select name from worker
WHERE age <17 and lodging = 'MATTS';

select name from worker
WHERE age > 50 or age <18;

select lodging from worker
WHERE name like '% AND %';

select lodging from worker
WHERE name in ('JOHN PEARSON','VICTORIA LYNN','DONALD ROLLO');

select name from worker
WHERE lodging = (select lodging from worker WHERE name = 'GEORGE OSCAR');

select name, age from worker
WHERE lodging is NULL;

select name, age from worker
WHERE age is not NULL
order by age desc;

select worker.name, worker.lodging, ability from worker, workerskill
WHERE workerskill.skill = 'SMITHY' and workerskill.name = worker.name;

create view Trip as
select name from worker
WHERE lodging is not NULL and age not in(15,16,17);