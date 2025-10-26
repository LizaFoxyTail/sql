CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE 
);
CREATE TABLE orders (
    id SERIAL PRIMARY KEY, 
    amount NUMERIC(10, 2) NOT NULL, 
    order_date TIMESTAMP DEFAULT NOW(),    
    customer_id INT NOT NULL REFERENCES customers(id)  
);
