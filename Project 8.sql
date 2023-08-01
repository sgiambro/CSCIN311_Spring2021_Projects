--employee table
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

drop table BBT_USERS_TEMP;

create table BBT_USERS_TEMP as
    select * from p5n2;

select * from BBT_USERS_TEMP;


create table PHONE_USERS(
TELEPHONE_NUMBER               VARCHAR2(80)  Primary Key,
FIRST_NAME                     VARCHAR2(80),
LAST_NAME                      VARCHAR2(80),
KEYMAP_LASTNAME                CHAR(4),
PASSWORD                       VARCHAR2(80),
constraint PU_UQ UNIQUE (LAST_NAME)
);

delete from PHONE_USERS;
select * from PHONE_USERS;


create or replace function KEYMAP(lname IN VARCHAR2)
return VARCHAR2
is
extention VARCHAR2(80);
begin
    extention := SUBSTR(TRANSLATE(lname || '444' , 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz4' , '22233344455566677778889999222333444555666777788899990'), 0, 4);
return (extention);
end;
/


create or replace
procedure sp_p(num IN NUMBER) 
as
    tNum   VARCHAR2(80);
    fn     VARCHAR2(80);
    ln     VARCHAR2(80);
    kmln   char(4);
    pw     VARCHAR2(80);
    
    cursor BBT_cursor is
		select * from BBT_USERS_TEMP;
	BBT_val BBT_cursor%ROWTYPE;
begin
    open BBT_cursor;
	for x in 1 .. (num*10) loop
    	fetch BBT_cursor into BBT_val;
        
        tNum := RPAD('(' || ROUND(dbms_random.value(1,9), 0) || ROUND(dbms_random.value(1,9), 0) || ROUND(dbms_random.value(1,9), 0) || ')' || ROUND(dbms_random.value(1,9), 0) || ROUND(dbms_random.value(1,9), 0) || ROUND(dbms_random.value(1,9), 0) || '-' || ROUND(dbms_random.value(1,9), 0) || ROUND(dbms_random.value(1,9), 0) || ROUND(dbms_random.value(1,9), 0) || ROUND(dbms_random.value(1,9), 0) , 20 , ' ');
        
        if x < 10 then
            ln := BBT_val.last;
            ln := ln || '000' || x;
            
        elsif x < 100 then
            ln := BBT_val.last;
            ln := ln || '00' || x;
        
        elsif x < 1000 then
            ln := BBT_val.last;
            ln := ln || '0' || x;
        
        elsif x < 10000 then
            ln := BBT_val.last;
            ln := ln || x;
        end if;
        
        select KEYMAP(last) into kmln from BBT_USERS_TEMP where BBT_val.id = ID;        
        
        fn := BBT_val.first;
        pw := BBT_val.password;
        
        insert into PHONE_USERS values (tNum , fn , ln , kmln , pw);
    end loop;
    close BBT_cursor;
end;
/


create or replace package PHONE_PACKAGE
as
	function KEYMAP(lname IN VARCHAR2) return VARCHAR2;
    procedure sp_p(num IN NUMBER);
end PHONE_PACKAGE;
/


create or replace package body PHONE_PACKAGE
as

function KEYMAP(lname IN VARCHAR2)
return VARCHAR2
is
extention VARCHAR2(80);
begin
    extention := SUBSTR(TRANSLATE(lname || '444' , 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz4' , '22233344455566677778889999222333444555666777788899990'), 0, 4);
return (extention);
end;


procedure sp_p(num IN NUMBER) 
as
    tNum   VARCHAR2(80);
    fn     VARCHAR2(80);
    ln     VARCHAR2(80);
    kmln   char(4);
    pw     VARCHAR2(80);
    
    cursor BBT_cursor is
		select * from BBT_USERS_TEMP;
	BBT_val BBT_cursor%ROWTYPE;
begin
    open BBT_cursor;
	for x in 1 .. (num*10) loop
    	fetch BBT_cursor into BBT_val;
        
        tNum := RPAD('(' || ROUND(dbms_random.value(1,9), 0) || ROUND(dbms_random.value(1,9), 0) || ROUND(dbms_random.value(1,9), 0) || ')' || ROUND(dbms_random.value(1,9), 0) || ROUND(dbms_random.value(1,9), 0) || ROUND(dbms_random.value(1,9), 0) || '-' || ROUND(dbms_random.value(1,9), 0) || ROUND(dbms_random.value(1,9), 0) || ROUND(dbms_random.value(1,9), 0) || ROUND(dbms_random.value(1,9), 0) , 20 , ' ');
        
        if x < 10 then
            ln := BBT_val.last;
            ln := ln || '000' || x;
            
        elsif x < 100 then
            ln := BBT_val.last;
            ln := ln || '00' || x;
        
        elsif x < 1000 then
            ln := BBT_val.last;
            ln := ln || '0' || x;
        
        elsif x < 10000 then
            ln := BBT_val.last;
            ln := ln || x;
        end if;
        
        select KEYMAP(last) into kmln from BBT_USERS_TEMP where BBT_val.id = ID;        
        
        fn := BBT_val.first;
        pw := BBT_val.password;
        
        insert into PHONE_USERS values (tNum , fn , ln , kmln , pw);
    end loop;
    close BBT_cursor;
end;

end PHONE_PACKAGE;
/



execute PHONE_PACKAGE.sp_p(50);


select * from phone_users;
delete from phone_users;
