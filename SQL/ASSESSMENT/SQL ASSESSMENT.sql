-- create databse 
create database company;

use company;

create table worker(
worker_id int primary key auto_increment,
first_name varchar(100) not null,
last_name varchar(100) not null,
salary int not null,
joining_date datetime not null ,
department varchar(50) not null ); 

insert into worker (worker_id,first_name,last_name,salary,joining_date,department) values
(1, 'Monika', 'Arora', 100000, '2014-02-20 09:00:00', 'HR'),
(2, 'Niharika', 'Verma', 80000, '2014-06-11 09:00:00', 'Admin'),
(3, 'Vishal', 'Singhal', 300000, '2014-02-20 09:00:00', 'HR'),
(4, 'Amitabh', 'Singh', 500000, '2014-02-20 09:00:00', 'Admin'),
(5, 'Vivek', 'Bhati', 500000, '2014-06-11 09:00:00', 'Admin'),
(6, 'Vipul', 'Diwan', 200000, '2014-06-11 09:00:00', 'Account'),
(7, 'Satish', 'Kumar', 75000, '2014-01-20 09:00:00', 'Account'),
(8, 'Geetika', 'Chauhan', 90000, '2014-04-11 09:00:00','Admin');
 
 
 --  1. Write an SQL query to print all Worker details from the Worker table order by FIRST_NAME 
-- Ascending and DEPARTMENT Descending. 
SELECT * FROM Worker
ORDER BY FIRST_NAME ASC, DEPARTMENT DESC;

-- 2. Write an SQL query to print details for Workers with the first names “Vipul” and “Satish” 
-- from the Worker table. 
SELECT * FROM Worker
WHERE FIRST_NAME IN ('Vipul', 'Satish');

-- 3. Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘h’ and 
-- contains six alphabets.
SELECT * FROM Worker
WHERE FIRST_NAME LIKE '_____h' ;

-- 4.Write an SQL query to print details of the Workers whose SALARY lies between 1. 
-- Assuming it's between 1 and 1000000:
SELECT * FROM Worker
WHERE SALARY BETWEEN 1 AND 1000000;

-- 5. Write an SQL query to fetch duplicate records having matching data in some fields of a table. 
SELECT FIRST_NAME, LAST_NAME, DEPARTMENT, COUNT(*)
FROM Worker
GROUP BY FIRST_NAME, LAST_NAME, DEPARTMENT
HAVING COUNT(*) > 1;

-- 6. . Write an SQL query to show the top 6 records of a table. 
SELECT * FROM Worker
LIMIT 6;

-- 7.Write an SQL query to fetch the departments that have less than five people in them.
SELECT DEPARTMENT
FROM Worker
GROUP BY DEPARTMENT
HAVING COUNT(*) < 5;

-- 8.Write an SQL query to show all departments along with the number of people in there. 
SELECT DEPARTMENT, COUNT(*) AS Num_Employees
FROM Worker
GROUP BY DEPARTMENT;

-- 9. Write an SQL query to print the name of employees having the highest salary in each 
-- department.

SELECT *
FROM Worker w
WHERE SALARY = (
    SELECT MAX(SALARY)
    FROM Worker
    WHERE DEPARTMENT = w.DEPARTMENT
);


