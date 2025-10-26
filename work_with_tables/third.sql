CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
   name VARCHAR(100) NOT NULL
);

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    price numeric(10,2) not null check (price>=0),
    category_id INT REFERENCES categories(id)
);