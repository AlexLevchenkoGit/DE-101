--GEOGRAPHY

drop table if exists dw.geo_dim ;
CREATE TABLE dw.geo_dim
(
 geo_id      serial NOT NULL,
 country     varchar(13) NOT NULL,
 city        varchar(17) NOT NULL,
 state       varchar(20) NOT NULL,
 postal_code varchar(20) NULL,       --can't be integer, we lost first 0
 CONSTRAINT PK_geo_dim PRIMARY KEY ( geo_id )
);

--deleting rows
truncate table dw.geo_dim;
--generating geo_id and inserting rows from orders
insert into dw.geo_dim 
select 100+row_number() over(), country, city, state, postal_code from (select distinct country, city, state, postal_code from orders) a;

--data quality check
select distinct country, city, state, postal_code from dw.geo_dim
where country is null or city is null or postal_code is null;

-- City Burlington, Vermont doesn't have postal code
update dw.geo_dim
set postal_code = '05401'
where city = 'Burlington'  and postal_code is null;

--also update source file
update orders
set postal_code = '05401'
where city = 'Burlington'  and postal_code is null;


select * from dw.geo_dim
where city = 'Burlington'