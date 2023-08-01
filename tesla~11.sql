drop table practice;

create table Practice(
ACCOUNT_NAME  VARCHAR2(50),
PRICE         Number(8,2),
QUANTITY      Number,
BONUS         Number(8,2) )



declare
	brazil constant NUMBER(3,2) := 5.73;
	swis constant NUMBER(3,2) := 0.94;
    name  VARCHAR2(50);
    bonus Number(8,2);
  
begin
 FOR oneRow IN (SELECT st.account , price , quantity , accountlongname , TRX_FLAG   FROM STOCK_TRX st full outer join STOCK_ACCOUNT sa on st.account = sa.account)
 LOOP
    name := oneRow.account || ' - ' || oneRow.accountlongname;
    if  oneRow.quantity < 150 then 
        bonus := Round(oneRow.price * oneRow.quantity * 0.1, 2);
        
        if oneRow.TRX_FLAG = 'B' then
            bonus := Round(bonus * brazil, 2 );
        
        elsif oneRow.TRX_FLAG = 'S' then
            bonus := Round(bonus * swis , 2);
            
        end if;

    elsif oneRow.quantity >=150 and oneRow.quantity<500 then
        bonus := Round(oneRow.price * oneRow.quantity * 0.2 , 2 );
        
        if oneRow.TRX_FLAG = 'B' then
            bonus := Round(bonus * brazil , 2);
        
        elsif oneRow.TRX_FLAG = 'S' then
            bonus := Round(bonus * swis , 2);
            
        end if;
        
    elsif oneRow.quantity >=500 then
        bonus := Round(oneRow.price * oneRow.quantity * 0.3 , 2);
        
        if oneRow.TRX_FLAG = 'B' then
            bonus := Round(bonus * brazil , 2);
        
        elsif oneRow.TRX_FLAG = 'S' then
            bonus := Round(bonus * swis , 2);
            
        end if;
    end if;
    
    insert into Practice values (name , oneRow.price , oneRow.quantity , bonus);
    
  END LOOP;
end;
/

SELECT * FROM practice;
