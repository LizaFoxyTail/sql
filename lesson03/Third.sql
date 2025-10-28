CREATE TABLE students (
   student_id INT PRIMARY KEY,
   full_name VARCHAR(100),
   age INT,
   group_id INT
);

CREATE TABLE groups (
   group_id INT PRIMARY KEY,
   group_name VARCHAR(50)
);

CREATE TABLE subjects (
   subject_id INT PRIMARY KEY,
   subject_name VARCHAR(50)
);

CREATE TABLE grades (
   grade_id INT PRIMARY KEY,
   student_id INT,
   subject_id INT,
   grade INT,
   FOREIGN KEY (student_id) REFERENCES students(student_id),
   FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)
);

--Напишите INSERT для заполнения таблиц
INSERT INTO groups (group_id, group_name) VALUES
(1, 'Computer Science'),
(2, 'Economics'),
(3, 'Design');

INSERT INTO students (student_id, full_name, age, group_id) VALUES
(1, 'Emma Johnson', 19, 1),
(2, 'Liam Carter', 20, 1),
(3, 'Olivia Smith', 18, 2),
(4, 'Noah Williams', 21, 2),
(5, 'Ava Brown', 19, 3),
(6, 'Ethan Davis', 22, 3);
(7, 'Sophia Miller', 20, 1),
(8, 'James Wilson', 21, 1),
(9, 'Isabella Taylor', 19, 2),
(10, 'Mason Anderson', 22, 2),
(11, 'Mia Thomas', 20, 3),
(12, 'Lucas Martin', 23, 3);

INSERT INTO subjects (subject_id, subject_name) VALUES
(1, 'Mathematics'),
(2, 'Programming'),
(3, 'Economics'),
(4, 'Art History');

INSERT INTO grades (grade_id, student_id, subject_id, grade) VALUES
(1, 1, 1, 10),
(2, 1, 2, 8),
(3, 2, 1, 9),
(4, 2, 2, 6),
(5, 3, 3, 7),
(6, 3, 1, 10),
(7, 4, 3, 10),
(8, 4, 1, 6),
(9, 5, 4, 5),
(10, 5, 3, 8),
(11, 6, 4, 9),
(12, 6, 3, 7);

--Подсчитайте количество студентов в университете.
select COUNT (*) as total_students
from students;

--Найдите средний возраст студентов.
select AVG(age) as average_age
from students;

--Определите минимальный и максимальный возраст студентов.
select MIN(age) as min_age, MAX(age) as max_age
from students;

--Подсчитайте, сколько всего оценок выставлено.
select COUNT (*) as total_grades
from grades;

--Подсчитайте, сколько студентов учится в каждой группе.
select group_id, COUNT (*) as total_students
from students
group by group_id
order by group_id asc;

--Найдите средний возраст студентов по каждой группе.
select group_id, AVG(age) as average_age
from students
group by group_id
order by group_id asc;

--Определите средний балл по каждому предмету.
select subject_id, AVG(grade) as average_grade
from grades
group by subject_id
order by subject_id asc;

--Найдите количество студентов, у которых есть оценки по каждому предмету.
select COUNT(*) AS total_students
from (
    select student_id
    from grades
    group by student_id
    having COUNT(DISTINCT subject_id) = (select COUNT(*) FROM subjects)
) AS sub;

--Выведите только те группы, где учится больше 1 студента.
select group_id, count(student_id) as total_students
from students
group by group_id
having count(*) >1;

--Покажите предметы, где средний балл выше 8
select subject_id, AVG(grade) AS average_grade
from grades
group by subject_id
having AVG(grade) > 8;

--Найдите студентов, у которых средний балл по всем предметам выше 8.5.
select subject_id, AVG(grade) AS average_grade
from grades
group by subject_id
having AVG(grade) > 8;
