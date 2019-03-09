use sakila;

select first_name, last_name 
	from actor;
    
select CONCAT(Upper(first_name) , " ",  upper(last_name)) as "Actor Name" 
	from actor;
    
select actor_id, first_name, last_name 
	from actor 
    where first_name = "Joe";
    
select * 
	from actor 
    where last_name LIKE '%GEN%';
    
select * 
	from actor 
    where last_name LIKE '%LI%' 
    order by last_name, first_name asc;
    
select country_id, country 
	from country 
    where country in ("Afghanistan", "Bangladesh", "China");
    
ALTER TABLE actor 
	ADD COLUMN description blob 
    AFTER last_name;
    
ALTER TABLE actor 
	DROP COLUMN description;
    
select last_name, count(last_name) as "Name Count" 
	from actor 
    group by last_name;
    
select last_name, count(last_name) as "Name Count" 
	from actor  
    group by last_name 
    having count(last_name) > 1;
    
update actor 
	set first_name = "HARPO" 
    where first_name = "GROUCHO" 
		and last_name = "WILLIAMS";
        
update actor 
	set first_name = "GROUCHO" 
    where first_name = "HARPO";
    
SHOW CREATE TABLE address;

select s.first_name, s.last_name, a.address 
	from staff s 
    join address a 
		on s.address_id = a.address_id;
        
select s.first_name, s.last_name, sum(p.amount) 
	from staff s 
    join payment p 
		on s.staff_id = p.staff_id 
	where YEAR(p.payment_date) = 2005 
		AND MONTH(p.payment_date) = 8 
	group by s.first_name, s.last_name;
    
select f.title, count(a.actor_id) 
	from film f 
    inner join film_actor a 
		on f.film_id = a.film_id 
	group by f.title;
    
select count(inventory_id) 
	from inventory 
    where film_id = (select film_id from film where title = "Hunchback Impossible");
    
select c.first_name, c.last_name, sum(amount) 
	from customer c 
    join payment p 
		on c.customer_id = p.customer_id 
	group by c.first_name, c.last_name 
    order by c.last_name asc;
    
select title 
	from film 
    where (title like 'K%' or title like 'Q%') 
		and language_id = (select language_id from language where name = "English");

select first_name, last_name 
	from actor 
	where actor_id in (select actor_id from film_actor where film_id = (select film_id from film where title = "Alone Trip"));
    
select first_name, last_name, email 
	from customer 
    where address_id in (select address_id from address where city_id in (select city_id from city where country_id = (select country_id from country where country = "Canada")));

select title 
	from film 
    where film_id in (select film_id from film_category where category_id = (select category_id from category where name = "Family"));

select f.title 
	from film f 
    join inventory i 
		on f.film_id = i.film_id 
	join rental r 
		on i.inventory_id = r.inventory_id 
	group by f.title 
    order by count(r.rental_id) desc; 

select s.store_id, sum(p.amount) 
	from store s 
    join customer c 
		on s.store_id = c.store_id 
	join rental r 
		on c.customer_id = r.rental_id 
	join payment p 
		on r.rental_id = p.payment_id 
	group by store_id;

select s.store_id, c.city, c2.country
	from store s
    join address a
		on s.address_id = a.address_id
	join city c
		on a.city_id = c.city_id
	join country c2
		on c.country_id = c2.country_id;

select c.name
	from category c
    join film_category f
		on c.category_id = f.category_id
	join inventory i
		on f.film_id = i.film_id
	join rental r
		on i.inventory_id = r.inventory_id
	join payment p
		on r.rental_id = p.rental_id
	group by c.name
    order by sum(p.amount) desc
    Limit 5;

CREATE VIEW Top_5_Gross_Categories_V AS
	select c.name
		from category c
		join film_category f
			on c.category_id = f.category_id
		join inventory i
			on f.film_id = i.film_id
		join rental r
			on i.inventory_id = r.inventory_id
		join payment p
			on r.rental_id = p.rental_id
		group by c.name
		order by sum(p.amount) desc
        Limit 5;

select * from top_5_gross_categories_v;     

drop view top_5_gross_categories_v;