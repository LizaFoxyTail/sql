CREATE TABLE sales (
   id autoincrement PRIMARY KEY,
   region VARCHAR(20),
   amount BIGINT,
   sale_date DATE
);

INSERT INTO sales (region, amount, sale_date) VALUES
('North', 1000, '2024-01-01'),
('South', 700, '2024-01-02'),
('North', 500, '2024-01-03'),
('West', NULL, '2024-01-04'),
('South', 900, '2024-01-05'),
('North', 1500, '2024-01-06');

--Найди сумму продаж по каждому региону.
select region, SUM(amount) as total_sales
from sales
group by region;

--Покажи среднюю сумму продаж по регионам, где больше одной продажи.
select region, AVG(amount) as average_sales
from sales
group by region
having count(*) >1;

--Найди регион с максимальной суммой продаж.
SELECT region, SUM(amount) as total_sales
from sales
where amount is not null
group by region
order by total_sales desc 
limit 1;

--Выведи общее количество продаж и сколько из них имеют ненулевую сумму.
select COUNT (*) as total_amount, 
COUNT (amount) as sales_num --без null 
from sales;

--Покажи регионы, где продажи превышают среднюю по всем регионам. 
select region, SUM(amount) AS total_sales
from sales
where amount IS NOT NULL
group by region
having SUM(amount) > (
        SELECT AVG(average_sales)
        FROM (
            SELECT SUM(amount) AS average_sales
            FROM sales
            WHERE amount IS NOT NULL
            GROUP BY region
        ) AS sub
    );
