--PRODUCT

--creating a table
drop table if exists dw.product_dim ;
CREATE TABLE dw.product_dim
(
 prod_id        int NOT NULL,
 product_id     varchar(50) NOT NULL,
 product_name   varchar(127) NOT NULL,
 category       varchar(15) NOT NULL,
 sub_category   varchar(11) NOT NULL,
 segment        varchar(11) NOT NULL,
 CONSTRAINT PK_product_dim PRIMARY KEY ( prod_id )
);

--deleting rows
truncate table dw.product_dim ;
--generating geo_id and inserting rows from orders
insert into dw.product_dim 
select 100+row_number() over () as prod_id, product_id, product_name, category, subcategory, segment from (select distinct product_id, product_name, category, subcategory, segment from orders) a;  
--checking
select * from dw.product_dim cd; 