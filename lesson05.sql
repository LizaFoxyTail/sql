--Вывести сотрудников с зарплатой выше средней по компании
select name, salary
from employees 
where salary > (select avg(salary) from employees)

--Вывести продукты дороже среднего
select name, price
from products
where price > (select avg(price) from products)

--Вывести отделы, где есть хотя бы один сотрудник с зарплатой > 10 000
select d.id, d.name
from departments d
where d.id in (select department_id from employees where salary > 10000)

--Вывести для каждого клиента количество его заказов
select c.name, (select count(*) from orders o where o.customer_id = o.id) as order_num
from customers c 

--Вывести топ 3 отдела по средней зарплате
select d.id, d.name, (select avg(salary) from employees e where e.department_id = d.id) as average_salary
from departments d
order by average_salary DESC
limit 3

--Вывести клиентов без заказов
select c.name
from customers c
where c.id not in (select customer_id from orders where customer_id is not null)

--Вывести сотрудников, зарабатывающих больше, чем любой из менеджеров.
select name, id
from employees
where id NOT IN (select distinct manager_id from employees)
and salary > (select max(salary) from employees where id IN 
(select distinct manager_id from employees))

--Вывести отделы, где все сотрудники зарабатывают выше 5000.
select d.id, d.name
from departments d
where 5000 < all(select salary from employees e where e.department_id = d.id )
