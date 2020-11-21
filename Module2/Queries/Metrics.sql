--METRICS

--creating a table
drop table if exists dw.sales_fact ;
CREATE TABLE dw.sales_fact
(
 sales_id         serial NOT NULL,
 cust_id          integer NOT NULL,
 order_date_id    integer NOT NULL,
 ship_date_id     integer NOT NULL,
 prod_id          integer NOT NULL,
 ship_id          integer NOT NULL,
 geo_id           integer NOT NULL,
 order_id         varchar(25) NOT NULL,
 sales            numeric(9,4) NOT NULL,
 profit           numeric(21,16) NOT NULL,
 quantity         int4 NOT NULL,
 discount         numeric(4,2) NOT NULL,
 CONSTRAINT PK_sales_fact PRIMARY KEY ( sales_id ));


insert into dw.sales_fact 
select
	 100+row_number() over() as sales_id
	 ,cust_id
	 ,to_char(order_date,'yyyymmdd')::int as  order_date_id
	 ,to_char(ship_date,'yyyymmdd')::int as  ship_date_id
	 ,p.prod_id
	 ,s.ship_id
	 ,geo_id
	 ,o.order_id
	 ,sales
	 ,profit
     ,quantity
	 ,discount
from orders o 
inner join dw.shipping_dim s on o.ship_mode = s.shipping_mode
inner join dw.geo_dim g on o.postal_code = cast(g.postal_code as int) and g.country=o.country and g.city = o.city and o.state = g.state --City Burlington doesn't have postal code
inner join dw.product_dim p on o.product_name = p.product_name and o.segment=p.segment and o.subcategory=p.sub_category and o.category=p.category and o.product_id=p.product_id 
inner join dw.customer_dim cd on cd.customer_id=o.customer_id and cd.customer_name=o.customer_name 

--deleting rows
truncate table dw.sales_fact

select distinct postal_code, to_char(postal_code, '00000'), cast(postal_code as varchar) from orders



--do you get 9994rows?
select count(*) from dw.sales_fact sf

inner join dw.shipping_dim s on sf.ship_id=s.ship_id
inner join dw.geo_dim g on sf.geo_id=g.geo_id
inner join dw.product_dim p on sf.prod_id=p.prod_id
inner join dw.customer_dim cd on sf.cust_id=cd.cust_id;