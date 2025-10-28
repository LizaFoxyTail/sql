CREATE TABLE students (
student_id bigint PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
birth_date DATE NOT NULL,
email VARCHAR(100) UNIQUE,
group_id INT NOT NULL
);

--Напишите INSERT для заполнения таблицы
INSERT INTO students (student_id, first_name, last_name, birth_date, email, group_id) VALUES
(1, 'Emma', 'Johnson', '2002-03-14', 'emma.johnson@example.com', 1),
(2, 'Liam', 'Carter', '2001-07-22', 'liam.carter@example.com', 1),
(3, 'Emma', 'Johnson', '2003-01-09', 'olivia.smith@example.com', 2),
(4, 'Noah', 'Williams', '2002-10-17', 'noah.williams@example.com', 2),
(5, 'Emma', 'Johnson', '2001-05-05', 'ava.brown@example.com', 3),
(6, 'Ethan', 'Davis', '2003-12-28', 'ethan.davis@example.com', 3);

--Найти дубликаты по имени и фамилии студента
select first_name, last_name, count(*) as name_duplicates
from students
group by first_name, last_name
having count(*) > 1;

--Удалить дубликаты, оставить только первую запись
delete from students first
using students second
where first.student_id > second.student_id
and first.first_name = second.first_name
and first.last_name = second.last_name;
