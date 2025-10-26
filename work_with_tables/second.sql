create table departments (
id SERIAL PRIMARY KEY,
name VARCHAR(50) NOT NULL
);

create table employees(
id SERIAL primary key,
name VARCHAR(50) not null,
position VARCHAR(50),
department_id INT not null references departments(id) on delete set null
);