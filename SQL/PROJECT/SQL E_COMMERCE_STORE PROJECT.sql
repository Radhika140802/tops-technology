-- create DATABASE 

create database e_commerce_store ;
use e_commerce_store;
drop database e_commerce_store;
-- create tables

create table customers (
customer_id int primary key auto_increment ,
name varchar(100) not null,
state varchar(50) not null
);

create table products(
product_id int primary key auto_increment,
name varchar(100) not null,
category varchar(50) not null ,
price decimal(10,2) not null,
stock int 
);

create table orders(
order_id int primary key auto_increment,
customer_id int not null ,
order_date date not null,
foreign key (customer_id) references customers(customer_id)
);

create table order_item (
order_item_id int primary key auto_increment,
order_id int  not null ,
product_id int not null ,
quantity int ,
foreign key (order_id) references orders(order_id),
foreign key (product_id) references products(product_id)
);

create table payments(
payment_id int primary key auto_increment,
order_id int not null ,
amount decimal(10,2) not null,
payment_date date not null,
method varchar(50) not null,
foreign key (order_id) references orders(order_id)
);

insert into customers(customer_id,name,state) VALUES
(1, 'Ankit Jha',  'Sitamarhi, Bihar'),
(2, 'Amit Shah',  'Ahmedabad, Gujarat'),
(3, 'Sneha Patel',  'Rajkot, Gujarat'),
(4, 'Rahul Kumar',  'Delhi'),
(5, 'Priya Mehta', 'Mumbai, Maharashtra'),
(6, 'Aditya Rana',  'Indore, MP'),
(7, 'Pooja Singh',  'Lucknow, UP'),
(8, 'Karan Joshi',  'Jaipur, Rajasthan'),
(9, 'Neha Desai',  'Vadodara, Gujarat'),
(10,'Rohit Saini', 'Kotdawar,Uttarakhand');

insert into products (product_id,name,category,price,stock)values
(101, 'Wireless Mouse', 'Electronics', 599.00, 30),
(102, 'T-shirt',        'Clothing', 499.00, 50),
(103, 'Bluetooth Speaker', 'Electronics', 1299.00, 15),
(104, 'Notebook',        'Stationery', 59.00, 200),
(105, 'Wired Keyboard', 'Electronics', 799.00, 25),
(106, 'Denim Jeans',    'Clothing', 999.00, 40),
(107, 'LED Desk Lamp',   'Home Decor', 699.00, 18),
(108, 'Backpack',      'Accessories', 1199.00, 12),
(109, 'Pen Set',       'Stationery', 149.00, 300),
(110, 'Smart Watch',   'Electronics', 1999.00, 10),
(111, ' shirt',         'clothing', 699.00,20),
(112, 'Headphones' ,        'Electronics',1799.00,150);

insert into orders (order_id,customer_id,order_date)values
(1001, 1, '2025-07-01'),
(1002, 2, '2025-07-02'),
(1003, 3, '2025-07-02'),
(1004, 1, '2025-07-05'),
(1005, 5, '2025-07-07'),
(1006, 6, '2025-07-08'),
(1007, 7, '2025-07-10'),
(1008, 8, '2025-07-11'),
(1009, 9, '2025-07-14'),
(1010, 10, '2025-07-15'),
(1011, 1,  '2025-07-20'),
(1012, 5,  '2025-06-06'),
(1013, 6 , '2025-06-14');

insert into order_item ( order_item_id,order_id,product_id,quantity) values
(1, 1001, 101, 1),
(2, 1001, 102, 2),
(3, 1002, 104, 5),
(4, 1003, 103, 1),
(5, 1004, 105, 1),
(6, 1004, 102, 1),
(7, 1005, 106, 2),
(8, 1006, 107, 1),
(9, 1007, 108, 1),
(10, 1011, 109, 3),
(11, 1008, 110, 1),
(12, 1009, 101, 1),
(13, 1010, 106, 1),
(14, 1012, 104, 4),
(15, 1006, 109, 2),
(16, 1013,  111 ,2),
(17, 1012, 112, 4),
(18, 1001, 110,  5);

insert into payments (payment_id,order_id,amount,payment_date,method ) values
(5001 , 1001 , 599.00 ,'2025-07-01','credit card'),
(5002 , 1002 , 998.00 , '2025-07-02','UPI'),
(5003 , 1003 , 236.00, '2025-07-02','CASH'),
(5004 , 1004 , 499.00 , '2025-07-05' , 'DEBIT CARD'),
(5005 , 1005 , 2998.00, '2025-07-07' , 'UPI'),
(5006 , 1006 , 699.00 ,  '2025-07-08' , ' CREDIT CARD'),
(5007 ,1007 , 1199.00 , '2025-07-10' , 'CASH'),
(5008 , 1008 , 1999.00 , '2025-07-11' , ' CREDIT CARD'),
(5009, 1009 , 599.00,   '2025-07-14' , ' UPI'),
(5010 , 1010 , 999.00 ,  '2025-07-15' , 'DEBIT CARD'),
(5011 , 1011 , 447.00 , '2025-07-20' , 'CASH'),
(5012 , 1012 , 7196.00 , '2025-06-06' , 'CEDIT CARD'),
(5013 , 1013 , 236.00 , '2025-06-14' , ' CASH');
 
 -----------------------------------------------------------------
 
--  1. Find the total number of orders placed by each customer.

select count(distinct(order_id))
from orders;

-- 2. Calculate the total revenue generated from all orders.
select sum(amount)
from payments;

-- 3. Find the average order value per customer.
select avg(amount)
from payments
group by order_id;

-- 4. Get the highest payment amount and the lowest payment amount.
--  max
select max(amount) from payments;
-- min
select min(amount) from payments;

-- 5. List the number of products sold from each category.

SELECT p.category,SUM(oi.quantity) AS total_products_sold
FROM order_item oi
JOIN 
    products p ON oi.product_id = p.product_id
GROUP BY 
    p.category;
    
-- 6. Show each order with customer name, product names, and quantities.

SELECT o.order_id, c.name, p.name, oi.quantity
FROM Orders o
JOIN Customers as c ON o.customer_id = c.customer_id
JOIN Order_item oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
ORDER BY o.order_id;

-- 7. List all customers along with their order count and total amount spent.

SELECT 
    c.customer_id,
    c.name AS customer_name,         -- Adjust this to match your column
    COUNT(DISTINCT o.order_id) AS order_count,
    SUM(oi.quantity * p.price) AS total_spent
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
LEFT JOIN Order_item oi ON o.order_id = oi.order_id
LEFT JOIN Products p ON oi.product_id = p.product_id
GROUP BY c.customer_id, c.name
ORDER BY 
    total_spent DESC;
    
--   8. Display product name, category, and the number of times each product was sold.

SELECT 
    p.name,
    p.category,
    COUNT(oi.product_id) AS times_sold
FROM products p
JOIN 
    order_item oi ON p.product_id = oi.product_id
GROUP BY 
    p.name, p.category
ORDER BY 
    times_sold ;

-- 9. List products that were never ordered.

SELECT 
    product_id,
    name
FROM products
WHERE 
    product_id NOT IN (
        SELECT DISTINCT product_id FROM order_item);

--  10. Get all orders placed in July 2025.

SELECT 
    order_id,
    customer_id,
    order_date
FROM orders
WHERE 
    order_date BETWEEN '2025-07-01' AND '2025-07-31';
    
 
-- 11. List payments made in the last 10 days.
  
  SELECT 
    payment_id,
    c.customer_id,
    amount,
    payment_date
FROM payments, customers c
WHERE  payment_date >= CURRENT_DATE - INTERVAL 10 DAY;

-- 12. Show all products with stock less than 20.

SELECT 
    product_id,
    name,
    stock
FROM products
WHERE stock < 20;


-- 13. List orders with a total payment amount more than ₹1500.

SELECT 
    p.order_id,
    o.customer_id,
    SUM(p.amount) AS total_payment
FROM payments p
JOIN orders o ON p.order_id = o.order_id
GROUP BY p.order_id, o.customer_id
HAVING 
    SUM(p.amount) > 1500;
    
-- 14. List orders with a total payment amount less than ₹500.

SELECT 
    p.order_id,
    o.customer_id,
    SUM(p.amount) AS total_payment
FROM payments p
JOIN orders o ON p.order_id = o.order_id
GROUP BY p.order_id, o.customer_id
HAVING 
    SUM(p.amount) < 500;
    
-- 15. List all customers who have never made a payment.

SELECT 
    customer_id,
    name
FROM customers
WHERE 
    customer_id NOT IN (
        SELECT DISTINCT customer_id FROM payments);
        
 --  19. Show products that have never been ordered.
SELECT 
    product_id,
    name
FROM products
WHERE 
    product_id NOT IN (
        SELECT DISTINCT product_id FROM orders);
        
--  20. Show all products with price and stock.

SELECT name, price, stock FROM products;

-- 21. List all customers from Ahmedabad, Gujarat.
SELECT customer_id, name FROM customers WHERE state = 'Ahmedabad, Gujarat';

-- 22. Display all orders placed on or after '2025-07-10'.

SELECT * FROM orders WHERE order_date >= '2025-07-10';

-- 23. Find all payments made using ‘UPI’.
SELECT * FROM payments WHERE method = 'UPI';

-- 24. List all customers who have placed an order.
SELECT DISTINCT c.customer_id, c.name
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id;

-- 25. Show product names and their categories.
SELECT name, category FROM products;

-- 26. Display all unique product categories.
SELECT DISTINCT category FROM products;

-- 27. List all orders with customer name and order date.
SELECT o.order_id, c.name, o.order_date
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;

-- 28. Find all customers who have never ordered anything.
SELECT c.customer_id, c.name
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- 29. List the payment method used most frequently.
SELECT method, COUNT(*) AS method_count
FROM payments
GROUP BY method
ORDER BY method_count DESC
LIMIT 1;

-- 30 . Display number of products sold from each category.

SELECT p.category, SUM(oi.quantity) AS total_sold
FROM order_item oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category;
      
-- 31. List total orders placed by each customer.
SELECT customer_id, COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id;

-- 32. Show product-wise total quantity sold.
SELECT p.name, SUM(oi.quantity) AS total_quantity
FROM order_item oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.name;
        
-- 33. Show top 3 most sold products.
SELECT p.name, SUM(oi.quantity) AS total_sold
FROM order_item oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.name
ORDER BY total_sold DESC
LIMIT 3;

-- 34. Calculate total spending per customer.
SELECT c.customer_id, c.name, SUM(p.amount) AS total_spent
FROM customers c 
JOIN orders o ON c.customer_id = o.customer_id
join payments p on o.order_id = p.order_id
GROUP BY c.customer_id, c.name;

-- 35. Display average quantity ordered per product.
SELECT p.name, AVG(oi.quantity) AS avg_quantity
FROM order_item oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.name;

-- 36. List each order with product names and quantities.
SELECT o.order_id, p.name, oi.quantity
FROM orders o
JOIN order_item oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id;

-- 37. Find which customers bought a 'Smart Watch'.
SELECT DISTINCT c.customer_id, c.name
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_item oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE p.name = 'Smart Watch';

-- 37. Display customers who ordered more than 2 items in a single order.
SELECT o.order_id, c.name, SUM(oi.quantity) AS total_items
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_item oi ON o.order_id = oi.order_id
GROUP BY o.order_id, c.name
HAVING SUM(oi.quantity) > 2;

-- 38. Find the most popular category among buyers.
SELECT p.category, SUM(oi.quantity) AS total_sold
FROM order_item oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY total_sold 
LIMIT 3;

-- 39. List products that were never ordered.
SELECT product_id, name
FROM products
WHERE product_id NOT IN (
    SELECT DISTINCT product_id FROM order_item);
    
-- 40. Show total amount paid per product across all orders.
SELECT p.name, SUM(oi.quantity * p.price) AS total_paid
FROM order_item oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.name;

-- STORED PROCEDURE 

-- Place a New Order

DELIMITER //

CREATE PROCEDURE PlaceNewOrder
(IN cust_id INT)
BEGIN
    INSERT INTO orders (customer_id, order_date)
    VALUES (cust_id, CURDATE());
END //

DELIMITER ;

CALL PlaceNewOrder (5);
select * FROM ORDERS;

-- Get Total Spending by a Customer

DELIMITER //

CREATE PROCEDURE GetCustomerSpending(IN cust_id INT)
BEGIN
    SELECT c.name, SUM(p.amount) AS total_spent
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN payments p ON o.order_id = p.order_id
    WHERE c.customer_id = cust_id
    GROUP BY c.name;
END //

DELIMITER ;

CALL GetCustomerSpending(7);

-- Show Best-Selling Products

DELIMITER //

CREATE PROCEDURE TotalSellingProducts(IN TOPN INT)
BEGIN
    SELECT p.name, SUM(oi.quantity) AS total_sold
    FROM order_item oi
    JOIN products p ON oi.product_id = p.product_id
    GROUP BY p.name
    ORDER BY total_sold DESC;
END //

DELIMITER ;

CALL TotalSellingProducts(8);


-- Delete Customer and All Related Data 

DELIMITER //

CREATE PROCEDURE DeleteCustomerData(IN cust_id INT)
BEGIN
    DELETE p FROM payments p
    JOIN orders o ON p.order_id = o.order_id
    WHERE o.customer_id = cust_id;

    DELETE oi FROM order_item oi
    JOIN orders o ON oi.order_id = o.order_id
    WHERE o.customer_id = cust_id;

    DELETE FROM orders WHERE customer_id = cust_id;
    DELETE FROM customers WHERE customer_id = cust_id;
END //

dELIMITER ;

CALL DeleteCustomerData(3);

-- TRIGGER 

-- payment amount validation
delimiter //
create trigger validate_payment_amount
before insert on payments 
for each row
begin
    if new.amount <=0 then
    signal sqlstate '44000'
    set message_text ='payment amount must be greater than 0';
    end if;
end //
delimiter ;
use e_commerce_store;   


insert into payments (amount)
value(0);