CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(50) UNIQUE
);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(id) ON DELETE CASCADE, -- связь один ко многим
    order_date TIMESTAMP DEFAULT NOW()
);

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    price NUMERIC(10, 2) NOT NULL CHECK (price >= 0),
    order_id INT REFERENCES orders(id) ON DELETE CASCADE
);

INSERT INTO customers (name, email)
VALUES 
('Alice', 'alice@gmail.com'), 
('Nastya', 'nastya@gmail.com');

INSERT INTO products (name, price, order_id)
VALUES ('Lenovo', 1200.0, 1), ('IPhone', 800.0,2), ('Keyboard', 50.5, 1);

INSERT INTO orders (customer_id, order_date)
VALUES
(1, '2025-10-25 10:30:00'), 
(2, '2025-10-25 12:15:00');

SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM products;
