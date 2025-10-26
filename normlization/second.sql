--CREATE TABLE order_items (
--    order_id INT,
--    product_id INT,
--    quantity INT,
--    product_name TEXT,
--    PRIMARY KEY (order_id, product_id)
--);
-- будут дубликаты наименования товара, когда их заказывают несколько раз или несколько человек

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE order_items (
    order_id INT,
    product_name TEXT,
    product_id INT REFERENCES products(id),
    quantity INT,
    PRIMARY KEY (order_id, product_id)
);
