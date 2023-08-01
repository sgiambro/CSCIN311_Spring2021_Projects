-- employee table
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


--------------------------------------------------------------------------------


create table EMPLOYEE_LOG as select * from p5n2;
alter table EMPLOYEE_LOG add MOD_USER  VARCHAR2(10);
alter table EMPLOYEE_LOG add MOD_TIMESTAMP  DATE;

select * from EMPLOYEE_LOG;


Create or replace trigger EMPLOYEE_LOG_TRIG1
before insert on p5n2
for each row
begin
Insert into EMPLOYEE_LOG(id , first , last , email , password , salary , mod_user , mod_timestamp) 
values (:new.id, null, null, null , null , null , SYS_CONTEXT('USERENV', 'SESSION_USER') , Sysdate);
end;
/



Create or replace trigger EMPLOYEE_LOG_TRIG2
before update on p5n2
for each row
begin
Insert into EMPLOYEE_LOG(id , first , last , email , password , salary , mod_user , mod_timestamp) 
values (:old.id, :old.first, :old.last, :old.email , :old.password , :old.salary , SYS_CONTEXT('USERENV', 'SESSION_USER') , Sysdate);
end;
/


--------------------------------------------------------------------------------

--create a table that keeps a log of the weather in the tracked cities
create table Weather_log as select * from Weather
alter table Weather_log add "DATE"  DATE;

create table Weather_Change_log(
condition   number,
"DATE"      Date)

select * from weather;
select * from Weather_log;
select * from Weather_Change_log;


--every time the weather condition is updated for a city its new values are logged
--in the Weather_log table along with the date that the weather is happening on.
--this log can be used to keeps track of weather patterns and make predicting
--the forcast in those citys a little easier. Also if any anomalous weather
--behavior is logged it will be simpilar to research because there will be a log
--to the patterns befor and after the event occured.
Create or replace trigger Weather_log_Trig
before update on Weather
for each row
when (new.condition != old.condition)
begin
Insert into Weather_log(city , temperature , humidity , condition , "DATE") 
values (:new.city, :new.temperature, :new.humidity, :new.condition , Sysdate);
end;
/

--after the weather table is updated this trigger will be called and will
--count the total number of times that the weather has changed during the day
--and log it in the Weather_Change_log along with the date. this log can be used
--to identify any abnormal fluctuations of activity in the weather condition during
--a day and can be used for weather related recearch for those cities.
Create or replace trigger Weather_Change_log_Trig
after update on Weather
declare
numCon number;
curCount number;
begin
select count(*) into numCon from Weather_log where TO_CHAR("DATE", 'DD-MON-YY') = TO_CHAR(Sysdate, 'DD-MON-YY');
select count(*) into curCount from Weather_Change_log where TO_CHAR("DATE", 'DD-MON-YY') = TO_CHAR(Sysdate, 'DD-MON-YY');

if (curCount != 0) then
      update Weather_Change_log set condition = numCon where TO_CHAR("DATE", 'DD-MON-YY') = TO_CHAR(Sysdate, 'DD-MON-YY');
else
    Insert into Weather_Change_log(condition , "DATE") values (numCon , Sysdate);
end if;

end;
/

--------------------------------------------------------------------------------


create table object_Log_Daily(
NumObj      number,
"DATE"        date);

select * from object_Log_Daily;


create or replace trigger object_Log_Daily_Trig
after create on schema
declare 
  objs number; 
begin
  
    select count(*) into objs from object_Log_Daily where TO_CHAR("DATE", 'DD-MON-YY') = TO_CHAR(Sysdate, 'DD-MON-YY');
    
    if (objs > 0) then
      objs := (objs + 1);
      update object_Log_Daily set NumObj = objs where TO_CHAR("DATE", 'DD-MON-YY') = TO_CHAR(Sysdate, 'DD-MON-YY');
    else
     insert into object_Log_Daily values(1 , Sysdate);
    end if;
end;
/

