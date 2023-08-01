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
        
        s := ROUND(dbms_random.value(0,100000), -1);
        
        insert into p5n2 values(EID.NextVal , f , l , e , p , s);

    
    end loop;
    
end;
/


select * from p5n2;

-----------------------------------------------------------------------------------

drop table p6n1;

create table p6n1(
id                   number,
PerformanceReview    number )



DECLARE
    ran NUMBER;
    
    cursor employee_cursor is
		select id from p5n2;
	employee_val employee_cursor%ROWTYPE;
    
BEGIN
    open employee_cursor;

    loop
        fetch employee_cursor into employee_val;
        
        exit when employee_cursor%NOTFOUND;
        
        ran := ROUND(dbms_random.value(1,5), 0);
        
        insert into p6n1 values(employee_val.id , ran);
        
    end loop;

END;
/

delete p6n1;

select * from p6n1;



--------------------------------------------------------------------------------



drop table p6n2;

create table p6n2(
id       number,
first    VARCHAR2(20),
last     VARCHAR2(20),
Salary   number(6),
Bonus    number(8,2) )



DECLARE
    bon NUMBER(8,2);
    
    cursor bonus_cursor is
		select C.id , first , last , salary , PerformanceReview
        from p5n2 C full outer join p6n1 E on C.id = E.id  
        where  C.id = E.id;
	bonus_val bonus_cursor%ROWTYPE;
    
BEGIN
    open bonus_cursor;

    loop
        fetch bonus_cursor into bonus_val;
        
        exit when bonus_cursor%NOTFOUND;
        
        if (bonus_val.PerformanceReview = 5) then
            bon := ((bonus_val.Salary) * .1) + .00;
        elsif (bonus_val.PerformanceReview = 4) then
            bon := ((bonus_val.Salary) * .08) + .00;
        elsif (bonus_val.PerformanceReview = 3) then
            bon := ((bonus_val.Salary) * .05) + .00;
        else 
            bon := 0.00;
        end if;
        
        insert into p6n2 values(bonus_val.id , bonus_val.first , bonus_val.last , bonus_val.Salary , bon);
        
    end loop;

END;
/

delete p6n2;

select * from p6n2













