drop table p5n1;

create table p5n1(
T     Number,
V     Number,
I     Number,
U      Number,
LT   date )


select * from sys.all_objects;

create or replace view Dates as
select distinct trunc(To_date(timestamp, 'YYYY-MM-DD:HH24:MI:SS'))as log 
from sys.all_objects 
order by Log;

create or replace view Objects as
select distinct trunc(To_date(timestamp, 'YYYY-MM-DD:HH24:MI:SS')) as log , object_type as objects , count(*) as totObj
from sys.all_objects
where object_type = 'TABLE'
        or object_type = 'VIEW'
        or object_type = 'INDEX'
group by timestamp , object_type
order by Log;

create or replace view TotUser as
select unique trunc(To_DATE(timestamp, 'YYYY-MM-DD:HH24:MI:SS')) as log , DECODE(GROUPING(owner) , 1 , 'TOTAL' , owner) as USERS , count(*) as totUsers
from sys.all_objects
group by cube(timestamp , owner)
having DECODE(GROUPING(owner) , 1 , 'TOTAL' , owner) = 'TOTAL'
order by Log;

create or replace view TotUserAndObj as
select d.log , objects , totobj ,totusers
from objects d full outer join TotUser tu on d.log = tu.log
where d.log = tu.log;



declare
	
    t number := 0;
    v number := 0;
    i number := 0;
    u number := 0;
  
begin

 FOR oneRow IN (SELECT log FROM dates) LOOP
    
    FOR secondRow IN (SELECT log , objects , totobj ,totusers FROM TotUserAndObj) LOOP
    
        if secondRow.log = oneRow.log then
          
            if secondRow.objects = 'TABLE' then
                t := t + secondRow.totobj;
            elsif secondRow.objects = 'VIEW' then
                v := v + secondRow.totobj;
            elsif secondRow.objects = 'INDEX' then
                i := i + secondRow.totobj;
            end if;

            u := u + secondRow.totusers;
    
        end if;
    end loop;
    
    insert into p5n1 values(t,v,i,u,oneRow.log);
    
    t := 0;
    v := 0;
    i := 0;
    u := 0;
    
 end loop;
end;
/

--------------------------------------------------------------------------------


drop table p5n2;

create table p5n2(
id       number,
first    VARCHAR2(20),
last     VARCHAR2(20),
email    VARCHAR2(20),
password VARCHAR2(30),
salary   number(6) )


drop sequence EID;
create sequence EID increment by 1 start with 1;


declare
	
    x1 NUMBER;
    x2 NUMBER;
    x3 NUMBER;
    
    f VARCHAR2(20);
    l VARCHAR2(20);
    e VARCHAR2(20);
    p VARCHAR2(30);
    s NUMBER;

  
begin
    
    for count in 1..500 loop
    
        f := dbms_random.string( 'L' ,dbms_random.value(1,20));
        l := dbms_random.string( 'L' ,dbms_random.value(1,20));
        
        x1 := dbms_random.value(3,9);
        x2 := dbms_random.value(3,4);
        x3 := dbms_random.value(3,4);
        
        e := RPAD(dbms_random.string('L' , x1) || '@' || dbms_random.string('L' , x2) || '.' || dbms_random.string('L' , x3) , 20 , ' ');
        
        p := dbms_random.string( 'X' , dbms_random.value(9,30));
        
        s := ROUND(dbms_random.value(0,100000), 0);
        
        insert into p5n2 values(EID.NextVal , f , l , e , p , s);

    
    end loop;
    
end;
/

delete p5n2;

select * from p5n2;



