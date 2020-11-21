create schema dw;

--SHIPPING

--creating a table
drop table if exists dw.shipping_dim ;
CREATE TABLE dw.shipping_dim
(
 ship_id       serial NOT NULL,
 shipping_mode varchar(14) NOT NULL,
 CONSTRAINT PK_shipping_dim PRIMARY KEY ( ship_id )
);

--deleting rows
truncate table dw.shipping_dim;

--generating ship_id and inserting ship_mode from orders
insert into dw.shipping_dim 
select 100+row_number() over(), ship_mode from (select distinct ship_mode from orders ) a;
--checking
select * from dw.shipping_dim sd; 