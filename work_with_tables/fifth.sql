CREATE TABLE faculties (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE groups (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    fculty_id INT NOT null references faculties(id)
);

CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    group_id INT NOT null references groups(id)
);

CREATE TABLE teachers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE courses (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    teacher_id INT NOT null references teachers(id)
);

CREATE TABLE student_courses (
    student_id INT references students(id) on delete cascade,
    course_id INT references courses(id) on delete cascade, 
    grade INT check (grade between 1 and 5),
    primary key(student_id, course_id)
);
