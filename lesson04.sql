CREATE TABLE departments (
 id     SERIAL PRIMARY KEY, --помню про SERIAL, скопировала задание
 name   VARCHAR(50) NOT NULL,
 location VARCHAR(50)
);

CREATE TABLE employees (
 id           SERIAL PRIMARY KEY,
 name         VARCHAR(50) NOT NULL,
 position     VARCHAR(50),
 salary       NUMERIC(10,2),
 department_id INTEGER REFERENCES departments(id) ON DELETE SET NULL,
 manager_id   INTEGER REFERENCES employees(id) ON DELETE SET NULL
);

CREATE TABLE customers (
 id   SERIAL PRIMARY KEY,
 name VARCHAR(100) NOT NULL,
 city VARCHAR(50)
);

CREATE TABLE orders (
 id          SERIAL PRIMARY KEY,
 order_date  DATE NOT NULL,
 amount      NUMERIC(10,2),
 employee_id INTEGER REFERENCES employees(id) ON DELETE SET NULL,
 customer_id INTEGER REFERENCES customers(id) ON DELETE SET NULL
);

CREATE TABLE products (
 id    SERIAL PRIMARY KEY,
 name  VARCHAR(100) NOT NULL,
 price NUMERIC(10,2)
);

CREATE TABLE order_items (
 id         SERIAL PRIMARY KEY,
 order_id   INTEGER REFERENCES orders(id) ON DELETE CASCADE,
 product_id INTEGER REFERENCES products(id) ON DELETE SET NULL,
 quantity   INTEGER NOT NULL
);

INSERT INTO departments (id, name, location) VALUES
(1, 'Sales', 'Moscow'),
(2, 'HR', 'Saint Petersburg'),
(3, 'IT', 'Tashkent'),
(4, 'Marketing', 'Riga'); 

INSERT INTO employees (id, name, position, salary, department_id, manager_id) VALUES
(1, 'Ivan Petrov', 'CEO', 200000.00, NULL, NULL),
(2, 'Maria Smirnova', 'Head of Sales', 90000.00, 1, 1),
(3, 'Alexey Kuznetsov', 'Sales Rep', NULL, 1, 2),
(4, 'Svetlana Ivanova', 'Accountant', 70000.00, 2, 1),
(5, 'Dmitry Orlov', 'IT Engineer', 90000.00, 3, 1),
(6, 'Olga Petrova', 'Sales Rep', 50000.00, NULL, 2),
(7, 'Nikolai Sidorov', 'Support', 45000.00, 3, 5);

INSERT INTO customers (id, name, city) VALUES
(1, 'ACME Ltd', 'Moscow'),
(2, 'Beta LLC', 'Riga'),
(3, 'Gamma Corp', 'Tashkent'),
(4, 'NoOrders Inc', 'Vilnius');

INSERT INTO products (id, name, price) VALUES
(1, 'Widget', 10.00),
(2, 'Gadget', 25.00),
(3, 'Thingamajig', 100.00),
(4, 'UnusedProduct', 999.00);

INSERT INTO orders (id, order_date, amount, employee_id, customer_id) VALUES
(1, '2025-10-01', 300.00, 2, 1),
(2, '2025-09-01', 150.00, 3, 2),
(3, '2025-07-01', 0.00,   NULL, 3),   
(4, '2025-10-15', 200.00, 5, NULL),   
(5, '2025-08-01', 500.00, 6, 1),
(6, '2025-10-25', 0.00,  2, 2); 

INSERT INTO order_items (id, order_id, product_id, quantity) VALUES
(1, 1, 1, 10),
(2, 1, 2, 8),    
(3, 2, 2, 2),    
(4, 5, 3, 1),    
(5, 4, 1, 5);

--Вывести employee.id, employee.name, department.name — сотрудники без отдела должны показать No Department.
select 
    employees.id AS employee_id,
    employees.name AS employee_name,
    COALESCE(departments.name, 'No Department') AS department_name
from employees 
left join departments ON employees.department_id = departments.id;

--Сотрудники, у которых есть менеджер (показать имя сотрудника и имя менеджера).
select e.name as employee_name, m.manager_id as manager_name
from employees e
inner join employees m on e.id = m.id
where e.manager_id is not null;

--Отделы без сотрудников.
select d.id as department_id, d.name as department
from departments d
left join employees e on d.id = e.department_id
where e.id is null;

--Все заказы с именем сотрудника и именем клиента — если employee или customer отсутствует, показывать No Employee / No Customer.
select o.id, o.order_date, o.amount,
COALESCE(e.name, 'No Employee') AS employee,
COALESCE(c.name, 'No Customer') AS customer
from orders o 
left join customers c on o.customer_id = c.id
left join employees e on o.employee_id = e.id

--Список заказов с товарами: для каждого заказа вывести order_id, product_name, quantity. Показать также заказы без позиций.
select o.id as order_id, p.name, oi.quantity
from orders o
left join order_items oi on o.id = oi.order_id
left join products p on oi.product_id = p.id
order by order_id;

--Для каждого отдела — все заказы (через сотрудников этого отдела); включать отделы с нулём заказов.
select d.id as department_id, d.name, o.id, o.order_date, o.amount
from departments d
left join employees e on e.department_id = d.id
left join orders o on o.employee_id = e.id
order by department_id;

--Найти пары клиентов и продуктов, которые этот клиент никогда не покупал (т.е. построить Cartesian клиент×продукт и исключить реальные покупки).
select 
    c.name as customer_name,
    p.name as product_name
from customers c
cross join products p
except
select 
    c.name AS customer_name,
    p.name AS product_name
FROM orders o
JOIN customers c ON c.id = o.customer_id
JOIN order_items oi ON oi.order_id = o.id
JOIN products p ON p.id = oi.product_id

--Показать, какие продукты никогда не продавались.
select p.name
from products p
left join order_items oi on oi.product_id = p.id
where oi.id is null;

--Для каждого менеджера — показать суммарную сумму заказов, оформленных его подчинёнными.
select m.id, m.name, sum(o.amount) as total_amount
from employees m
left join employees e on e.manager_id = m.id
left join orders o on o.employee_id = e.id
group by m.id, m.name

--Общее количество заказов и суммарная выручка (amount).
select count(*) as total_orders, sum(o.amount) as total_amount
from orders o

--Средняя и максимальная зарплата по отделам.
select d.id, d.name as department, avg(e.salary) as average_salary, max(e.salary) as max_salary
from departments d
left join employees e on e.department_id = d.id
group by d.name, d.id
order by d.id

--Для каждого заказа — общее количество товаров (sum quantity) и уникальных позиций (count distinct product_id).
select o.id as order_id, sum(oi.quantity) as total_quantity, count (distinct oi.product_id) as product
from orders o
left join order_items oi on oi.order_id = o.id
group by o.id
ORDER BY o.id;

--Топ-3 продукта по суммарной выручке (price*quantity).
select p.id as product_id, p.name as product, sum(p.price*oi.quantity) as total_quantity
from products p
left join order_items oi on oi.product_id = p.id
group by p.id
ORDER BY product_id
limit 3;

--Kоличество клиентов, у которых есть хотя бы один заказ.
select count(distinct o.customer_id)
from orders o
where o.customer_id is not null

--Для каждого отдела — количество сотрудников, средняя зарплата, суммарная сумма заказов (через сотрудников этого отдела).
select d.id, count(e.id) as employees_num, avg(salary) as average_salary, sum(o.amount)
from departments d
left join employees e ON e.department_id = d.id
left join orders o ON o.employee_id = e.id
group by d.id, d.name
order by d.id

--Найти клиентов, чья средняя сумма заказа выше средней по всем заказам.
select c.name as customer
from customers c
inner join orders o on c.id = o.customer_id
group by c.id, c.name
having avg(o.amount) > (select avg(amount) from orders)

--Вывести дату заказа в формате DD.MM.YYYY HH24:MI.
SELECT id, 
TO_CHAR(order_date::timestamp, 'DD/MM/YYYY HH24:MI') as order_date
from orders

