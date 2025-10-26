create table clients(
id SERIAL primary key,
full_name VARCHAR(100) not null,
created_at TIMESTAMP default CURRENT_TIMESTAMP);

create table accounts(
id SERIAL primary key,
client_id INT references clients(id),
balance NUMERIC(12,2) default 0
);

INSERT INTO clients (full_name) VALUES ('Ivan Petrov'), ('Anna Ivanova');
INSERT INTO accounts (client_id, balance) VALUES (1, 1000.00), (2, 500.00);
CREATE OR REPLACE PROCEDURE add_bonus(
   p_client_id INT,
   p_bonus NUMERIC(12,2) DEFAULT 50.00
)
LANGUAGE plpgsql
AS $$
BEGIN
   UPDATE accounts
   SET balance = balance + p_bonus
   WHERE client_id = p_client_id;
END;
$$;


