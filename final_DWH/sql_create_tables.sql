-- создаем таблицу фактов
CREATE TABLE fact.fact_flights (
	passenger_id integer,
	actual_departure date,
	actual_arrival date,
	departure_delay varchar(30),
	arrival_delay varchar(30),
	aircraft_id integer,
	departure_airport_id integer,
	arrival_airport_id integer,
	fare_conditions varchar(10),
	amount numeric(10, 2)
);	

-- создаЄм таблицы измерений:
--Dim_Calendar - справочник дат
CREATE TABLE dim.dim_calendar (
	dt date
);

--Dim_Passengers - справочник пассажиров
CREATE TABLE dim.dim_passengers (
	passenger_id varchar(30),
	passenger_name text,
	contact_data varchar(300)
);

--Dim_Aircrafts - справочник самолетов
CREATE TABLE dim.dim_aircrafts (
	aircraft_code varchar(30),
	model text,
	"range" varchar(300)
);

--Dim_Airports - справочник аэропортов
CREATE TABLE dim.dim_airports (
	airport_code bpchar(3),
	airport_name text,
	city text,
	timezone text
);

--Dim_Tariff - справочник тарифов (Ёконом/бизнес и тд)
CREATE TABLE dim.dim_tariff (
	ticket_no bpchar(13),
	flight_id int4,
	fare_conditions varchar(10),
	amount numeric(10, 2)
);

-- заполн€ем календарь
insert into dim.calendar 
select
	distinct date
from
	(
	select
		date(coalesce(actual_departure, scheduled_departure))
	from bookings.flights
union
	select
		date(coalesce(actual_arrival, scheduled_arrival))
	from bookings.flights
) t
order by date;
