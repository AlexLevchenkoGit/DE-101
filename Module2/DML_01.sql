select 
 city
,count(distinct order_id) as number_orders 
,sum(sales) as revenue
from public.orders
group by city
having sum(sales) > 100000
order by revenue desc;
-----------------------------------------------------------
select 
 count(*)
,count(distinct o.order_id)
from orders o 
left join returns r on o.order_id = r.order_id ;
------------------------------------------------------------
select 
 count(*)
,count(distinct o.order_id)
from orders o 
where order_id in (select order_id from "returns")
and extract ('year' from o.order_date) = 2018;
-----------------------------------------------------------
select now() ;
select date_trunc('day', now())