
create type ITEM_TY as object
(Type       VARCHAR2(25),
Color       VARCHAR2(25),
Pattern     VARCHAR2(25),
Material    VARCHAR2(25),
Weather     VARCHAR2(25)
);
/

create table CLOTHING
(Item_ID NUMBER,
item ITEM_TY);
/