--CREATE TABLE customers (
--    id SERIAL PRIMARY KEY,
--    name TEXT,
--    city TEXT,
--    region TEXT
--);

-- регион зависит от города, а не от первичного ключа
-- разделила таблицы, чтобы это исправить и было удобнее

CREATE TABLE regions (
    id SERIAL PRIMARY KEY,
    name TEXT UNIQUE NOT NULL
);

CREATE TABLE cities (
    id SERIAL PRIMARY KEY,
    name TEXT UNIQUE NOT NULL,
    region_id INT REFERENCES regions(id) ON DELETE SET NULL
);

CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    city_id INT REFERENCES cities(id) ON DELETE SET NULL
);
