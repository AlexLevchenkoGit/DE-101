--CUSTOMER

drop table if exists dw.customer_dim ;
CREATE TABLE dw.customer_dim
(
cust_id serial NOT NULL,
customer_id   varchar(8) NOT NULL, --id can't be NULL
customer_name varchar(22) NOT NULL,
CONSTRAINT PK_customer_dim PRIMARY KEY ( cust_id )
);

--deleting rows
truncate table dw.customer_dim;
--inserting
insert into dw.customer_dim 
select 100+row_number() over(), customer_id, customer_name from (select distinct customer_id, customer_name from orders ) a;
--checking
select * from dw.customer_dim cd;