--CREATE TABLE orders (
--    id SERIAL PRIMARY KEY,
--    customer_name TEXT,
--    customer_email TEXT,
--    product_name TEXT,
--    product_price NUMERIC(10,2)
--);

-- могут дублироваться имена клиентов и названия товаров, если заказ будет состоять из нескольких товаров, разная информация хранится в одной таблице
-- убрала возможное дублирование строк, добавила ко всем сущностям первичные ключи

CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL
);

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    price NUMERIC(10,2) NOT NULL CHECK (price >= 0)
);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(id) ON DELETE CASCADE,
    product_id INT REFERENCES products(id) ON DELETE CASCADE,
    order_date TIMESTAMP DEFAULT NOW()
);
