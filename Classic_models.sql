SELECT * FROM OFFICES;
SELECT * FROM EMPLOYEES;
select * from customers;
select * from products;
select * from orders;
select * from orderdetails;

-- Q1A
SELECT employeenumber, firstname, lastname 
from employees 
where jobTitle = 'sales rep' and reportsTo = 1102;

-- Q1B
select distinct productline
from products
where productLine like '%cars';

-- Q2
SELECT customerNumber, customerName, 
CASE
WHEN country IN ('USA', 'Canada') THEN 'North America'
WHEN country IN ('UK', 'France', 'Germany') THEN 'Europe'
ELSE 'Other'
END AS CustomerSegment
FROM customers;

-- Q3A
SELECT productcode , sum(quantityordered) as total_quantity
from orderdetails
group by productcode
order by total_quantity desc
limit 10;

-- Q3B
select * from payments;
SELECT MONTHNAME(paymentDate) AS monthName,
COUNT(*) AS totalPayments
FROM payments
GROUP BY monthName
HAVING totalPayments > 20
ORDER BY totalPayments DESC;

-- 4A
create database customer_orders;
create table customers (customer_id int primary key auto_increment, first_name varchar(50) not null, 
last_name varchar(50) not null, email varchar(255) unique, phone_number varchar(20));
select * from customers;

-- 4B
create table orders
(order_id int primary key , customer_id int, 
order_date date , total_amount decimal (10,2), 
foreign key (customer_id) references customers(customer_id));

INSERT INTO Orders 
VALUES (1,'2024-11-01','2024-10-11','2024-10-11', -100);
select * from orders;

drop table orders;
select * from orderdetails;
select * from orders;
INSERT INTO Orders 
VALUES (1,101,'2024-10-11',100);
select * from customers;

-- Q5
SELECT c.country, COUNT(o.orderNumber) AS order_count
FROM Customers c
JOIN Orders o ON c.customerNumber = o.customerNumber
GROUP BY c.country
ORDER BY order_count DESC
LIMIT 5;

-- Q6
create table project
(employee_id int primary key auto_increment, fullname varchar(50) not null,
gender varchar(6), manager_id int);
insert into project 
values
(1, 'pranaya', 'male', 3);
insert into project 
values
(2, 'priyanka','female', 1);
insert into project 
values
(3, 'pretty','female', null);
insert into project 
values
(4, 'anurag', 'male', 1);
insert into project 
values
(5, 'sambit', 'male', 1);
insert into project 
values
(6, 'rajesh', 'male', 3);
insert into project 
values
(7, 'hina','female',3);
select * from project;
drop table project;

-- Q6
-- self join
select e1.fullname as employee_name,
e2.FULLNAME as manager_name
from project e1
join
project e2
on e1.employee_id = e2.manager_id;

-- Q7
create table facility
(facility_id int, nme varchar(50), state varchar(50), 
country varchar(50));

alter table facility 
modify column facility_id int primary key auto_increment not null;

alter table facility 
add column city varchar(100) not null;

select * from facility;

-- Q8
create view product_category_sales as 
select pl.productline,
sum(od.quantityordered * od.priceeach) as total_sales,
count(distinct o.ordernumber) as number_of_orders
from  
productlines pl
join 
products p on pl.productline = p.productline
join OrderDetails od ON p.productCode = od.productCode
join Orders o ON od.orderNumber = o.orderNumber
group by pl.productline;
  
select * from productlines;
select * from products;

select * from product_category_sales;
select * from customers;
select * from payments;

-- Q9
call get_country_payments (2003, 'france');

-- Q10a
select * from customers;
select * from orders;
SELECT 
c.customerNumber,
COUNT(o.orderNumber) AS order_frequency,
RANK() OVER (ORDER BY COUNT(o.orderNumber) DESC) AS order_rank
FROM 
Customers c
LEFT JOIN 
Orders o ON c.customerNumber = o.customerNumber
GROUP BY 
c.customerNumber, c.contactFirstName, c.contactLastName
ORDER BY 
order_rank;

-- Q10b
select * from orders;
SELECT 
YEAR(orderDate) AS year,
MONTH(orderDate) AS month,
DATE_FORMAT(orderDate, '%M') AS month_name,
COUNT(orderNumber) AS order_count,
IFNULL(ROUND(100 * (COUNT(orderNumber) - 
(SELECT COUNT(orderNumber) 
FROM Orders o2 
WHERE YEAR(o2.orderDate) = YEAR(o1.orderDate) - 1 
AND MONTH(o2.orderDate) = MONTH(o1.orderDate))) / 
(SELECT COUNT(orderNumber) 
FROM Orders o2 
WHERE YEAR(o2.orderDate) = YEAR(o1.orderDate) - 1 
AND MONTH(o2.orderDate) = MONTH(o1.orderDate)), 0), 0) AS yoy_percentage_change
FROM Orders o1
GROUP BY 
YEAR(orderDate), MONTH(orderDate)
ORDER BY 
year DESC, month;

-- Q11
SELECT 
p.productLine,
COUNT(*) AS product_line_count
FROM 
Products p
WHERE 
p.buyPrice > (SELECT AVG(buyPrice) FROM Products)
GROUP BY 
p.productLine;

-- Q12
create table employee_EH
(EMP_Id int primary key, Emp_name varchar(200), 
Emailaddress varchar(200));

INSERT INTO employee_eh
VALUES (102 ,'123', 'EmailAddress');

select * from employee_eh;

-- Q13
create table emp_bit
(emp_name varchar(100), Occupation varchar (100), 
Working_date date, Working_hours int);

insert into emp_bit values 
('Robin', 'Scientist', '2020-10-04', 12),  
('Warner', 'Engineer', '2020-10-04', 10),  
('Peter', 'Actor', '2020-10-04', 13),  
('Marco', 'Doctor', '2020-10-04', 14),  
('Brayden', 'Teacher', '2020-10-04', 12),  
('Antonio', 'Business', '2020-10-04', 11);  


