--creating a table
drop table if exists dw.calendar_dim ;
CREATE TABLE dw.calendar_dim
(
date_id         serial  NOT NULL,
year            int NOT NULL,
quarter         int NOT NULL,
month           int NOT NULL,
week            int NOT NULL,
date            date NOT NULL,
week_day        varchar(20) NOT NULL,
leap            varchar(20) NOT NULL,
CONSTRAINT PK_calendar_dim PRIMARY KEY ( date_id )
);

--deleting rows
truncate table dw.calendar_dim;
--
insert into dw.calendar_dim 
select 
to_char(date,'yyyymmdd')::int as date_id,  
       extract('year' from date)::int as year,
       extract('quarter' from date)::int as quarter,
       extract('month' from date)::int as month,
       extract('week' from date)::int as week,
       date::date,
       to_char(date, 'dy') as week_day,
       extract('day' from
               (date + interval '2 month - 1 day')
              ) = 29
       as leap
  from generate_series(date '2000-01-01',
                       date '2030-01-01',
                       interval '1 day')
       as t(date);
--checking
select * from dw.calendar_dim; 