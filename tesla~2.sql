drop table practice;

create table Practice(
ACCOUNT_NAME  VARCHAR2(50),
PRICE         Number(8,2),
QUANTITY      Number,
BONUS         Number(8,2) )


--The cursor says "invalid cursor" but the format is correct and the select works 
--I am confused to why there is a problem 


declare
	brazil constant NUMBER(3,2) := 5.73;
	swis constant NUMBER(3,2) := 0.94;
    name  VARCHAR2(50);
    bonus Number(8,2);
    cursor trx_cursor is 
        SELECT st.account , price , quantity , accountlongname , TRX_FLAG 
        FROM STOCK_TRX st full outer join STOCK_ACCOUNT sa on st.account = sa.account;
	trx_val trx_cursor%ROWTYPE;
  
begin 
    LOOP
        fetch trx_cursor into trx_val;
        exit when trx_cursor%NOTFOUND;
        name := trx_val.account || ' - ' || trx_val.accountlongname;
        if  trx_val.quantity < 150 then 
            bonus := Round(trx_val.price * trx_val.quantity * 0.1, 2);
            
            if trx_val.TRX_FLAG = 'B' then
                bonus := Round(bonus * brazil, 2 );
            
            elsif trx_val.TRX_FLAG = 'S' then
                bonus := Round(bonus * swis , 2);
                
            end if;
    
        elsif trx_val.quantity >=150 and trx_val.quantity<500 then
            bonus := Round(trx_val.price * trx_val.quantity * 0.2 , 2 );
            
            if trx_val.TRX_FLAG = 'B' then
                bonus := Round(bonus * brazil , 2);
            
            elsif trx_val.TRX_FLAG = 'S' then
                bonus := Round(bonus * swis , 2);
                
            end if;
            
        elsif trx_val.quantity >=500 then
            bonus := Round(trx_val.price * trx_val.quantity * 0.3 , 2);
            
            if trx_val.TRX_FLAG = 'B' then
                bonus := Round(bonus * brazil , 2);
            
            elsif trx_val.TRX_FLAG = 'S' then
                bonus := Round(bonus * swis , 2);
                
            end if;
        end if;
        
        insert into Practice values (name , trx_val.price , trx_val.quantity , bonus);
        
  END LOOP;
end;
/

SELECT * FROM practice;
