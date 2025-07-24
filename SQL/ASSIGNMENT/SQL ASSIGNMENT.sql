--  ASSIGNMENT 

-- CREATE DATABASE
create  database management;

use management;

CREATE TABLE Company (
    company_id INT PRIMARY KEY,
    company_name VARCHAR(100) NOT NULL,
    street VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(2),
    zip VARCHAR(10)
);

-- 1) Statement to create the Contact table

CREATE TABLE Contact (
    ContactID INT,
    CompanyID INT,
    FirstName VARCHAR(45),
    LastName VARCHAR(45),
    Street VARCHAR(45),
    City VARCHAR(45),
    State VARCHAR(2),
    Zip VARCHAR(10),
    IsMain BOOLEAN,
    Email VARCHAR(45),
    Phone VARCHAR(12)
);

--  2) Statement to create the Employee table

CREATE TABLE Employee (
    EmployeeID INT,
    FirstName VARCHAR(45),
    LastName VARCHAR(45),
    Salary DECIMAL(10,2),
    HireDate DATE,
    JobTitle VARCHAR(25),
    Email VARCHAR(45),
    Phone VARCHAR(12)
);

insert  Company (company_id, company_name, street, city, state, zip)
VALUES
(1, 'Tata Consultancy Services', '100 Industrial Rd', 'Mumbai',    'MH', '400001'),
(2, 'Infosys Ltd',                '200 Tech Park',    'Bengaluru', 'KA', '560001'),
(3, 'Toll Brothers',          '50 IT Hub',       'Hyderabad', 'TS', '500001'),
(4, 'Urban Outfitters, Inc.',    '213 pine st',      'chennai',   'TN','606160');

insert INTO Contact (ContactID, CompanyID, FirstName, LastName, Street, City, State, Zip, IsMain, Email, Phone)
VALUES
(1, 1, 'Dianne', 'Connor', '789 Elm St', 'New York', 'NY', '10001', TRUE, 'dianne.connor@example.com', '212-555-1234'),
(2, 2, 'Robert', 'Smith', '101 Pine St', 'Philadelphia', 'PA', '19107', FALSE, 'robert.smith@example.com', '215-555-5678');

INSERT INTO Employee (EmployeeID, FirstName, LastName, Salary, HireDate, JobTitle, Email, Phone)
VALUES
(1, 'Jack', 'Lee', 60000.00, '2021-06-15', 'Sales Manager', 'jack.lee@example.com', '212-555-3456'),
(2, 'Lesley', 'Bland', 55000.00, '2022-01-10', 'Account Executive', 'lesley.bland@example.com', '215-555-1111');

INSERT INTO ContactEmployee (ContactEmployeeID, ContactID, EmployeeID, ContactDate, Description)
VALUES
(1, 11, 101, '2024-05-10', 'Discussed new project deal'),
(2, 12, 102, '2024-06-01', 'Follow-up on delivery status');

--  3) Statement to create the ContactEmployee table

CREATE TABLE ContactEmployee (
    ContactEmployeeID INT,
    ContactID INT,
    EmployeeID INT,
    ContactDate DATE,
    Description VARCHAR(100)
);

-- 4) Update Lesley Bland’s phone number

UPDATE Employee
SET Phone = '215-555-8800'
WHERE FirstName = 'lesley' AND LastName = 'bland'; 

-- 5) Update Urban Outfitters, Inc. to Urban Outfitters

UPDATE Company
SET Company_Name = 'Urban Outfitters'
WHERE Company_Name = 'Urban Outfitters, Inc.';

--  6) Remove Dianne Connor’s contact event with Jack Lee

DELETE FROM ContactEmployee
WHERE ContactEmployeeID = 1;

-- If not, get it with:

SELECT ce.ContactEmployeeID
FROM ContactEmployee ce
JOIN Contact c ON ce.ContactID = c.ContactID
JOIN Employee e ON ce.EmployeeID = e.EmployeeID
WHERE c.FirstName = 'Dianne' AND c.LastName = 'Connor'
  AND e.FirstName = 'Jack' AND e.LastName = 'Lee';


-- 7) SQL SELECT: Employees who contacted Toll Brothers

SELECT e.FirstName, e.LastName
FROM Contact c
JOIN ContactEmployee ce ON c.ContactID = ce.ContactID
JOIN Employee e ON ce.EmployeeID = e.EmployeeID
WHERE c.CompanyID IN (
    SELECT CompanyID FROM Company WHERE Company_Name = 'Toll Brothers'
);

--  8) Significance of % and _ in LIKE

-- %: Represents zero or more characters.

-- _: Represents exactly one character.


-- Example:

-- WHERE name LIKE 'A%'     -- names starting with A
-- WHERE name LIKE '_a%'    -- second letter is 'a'

-- 9) Explain normalization

-- Normalization is the process of organizing data in a database to:
-- Remove redundancy,
-- Improve data integrity,
-- Break data into smaller, related tables.
-- Forms: 1NF, 2NF, 3NF, etc.

--  10) What does a JOIN in MySQL mean?
-- A JOIN is used to combine rows from two or more tables based on a related column (like a foreign key).

--  11) DDL, DCL, DML in MySQL

-- data definition language- defines db.
-- CREATE - create new tables or database.
-- ALTER- modifies the  structure of a table.
-- DROP- permanently deletes a tables or database.
-- TRUNCAT- deletes all data in a table but keep the structure.

-- dml allows you to manipulate data inside tables.
-- ( data manipulation language)
-- INSERT- adds new data/records into a table.
-- UPDATE- modifies exiting data ina table.
-- DELETE- removes data from a table.

--  dcl controls access and permission to the database.
-- (data control lanuguage)
--  GRANT - gives users access privileges to the database.
--  REVOKE- removes users access or permission from the database.

-- 12) Role of MySQL JOIN clause and types
-- A JOIN clause is used to combine rows from two or more tables, based on a related column between them.

-- INNER JOIN: The INNER JOIN keyword selects records that have matching values in both tables.

-- LEFT JOIN: The LEFT JOIN keyword returns all records from the left table (table1),
--  and the matching records (if any) from the right table (table2)

-- RIGHT JOIN: The RIGHT JOIN keyword returns all records from the right table (table2), 
-- and the matching records (if any) from the left table (table1).

-- FULL OUTER JOIN: The FULL OUTER JOIN keyword returns all records when there is a match in left (table1) or right (table2) table records.