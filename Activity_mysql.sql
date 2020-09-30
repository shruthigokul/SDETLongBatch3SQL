#creating a database
Create database Shruthi_Activities;

#creating a table
Create table Shruthi_table1
(column1 int PRIMARY KEY,column2 varchar(255) NOT null,
start_date date, due_date date)
;

drop table salesman;

#activity 2:creating a salesman table and inserting values into it
Create table salesman 
(salesman_id int auto_increment primary key,
salesman_name varchar(200) not null,
salesman_city varchar(200),
commision int 
)auto_increment=5001;

insert into salesman
values(null,'James Hoog','NewYork',15);
insert into salesman
values(null,'Nail Knite','Paris',13);
insert into salesman
values(null,'Pit ALex','London',11);
insert into salesman
values(null,'Mc Lyon','Paris',14);
insert into salesman
values(null,'Paul Adam','Rome',13);
insert into salesman
values(null,'Lauson Hen','San Jose',12)
;



#activity 3
#show data from sales_id and city columns
select salesman_id,salesman_city from salesman;

#show data of salesman from Paris
select * from salesman where salesman_city='Paris';

#show salesman commision and sales_idof paul adam
select salesman_id,commision from salesman where salesman_name='Paul Adam';

#Activity4
#add a new column grade to salesman table . The grade will be integer values
#set the value in the grade column for everyone to 100
#use select command to displAY THE results

alter table salesman 
add column grade int;

update salesman
set grade=100;

select * from salesman;

#Update the grade score of salesmen from Rome to 200.
#Update the grade score of James Hoog to 300.
#Update the name McLyon to Pierre.

update salesman
set grade=200
where salesman_city='Rome';

update salesman
set grade=300
where salesman_name='James Hoog';

update salesman
set salesman_name='Pierre'
where salesman_name='Mc Lyon';

-- Create a table named orders
create table orders(
    order_no int primary key, purchase_amount float, order_date date,
    customer_id int, salesman_id int);

-- Add values to the table
insert into orders values
(70001, 150.5, '2012-10-05', 3005, 5002), (70009, 270.65, '2012-09-10', 3001, 5005),
(70002, 65.26, '2012-10-05', 3002, 5001), (70004, 110.5, '2012-08-17', 3009, 5003),
(70007, 948.5, '2012-09-10', 3005, 5002), (70005, 2400.6, '2012-07-27', 3007, 5001),
(70008, 5760, '2012-08-15', 3002, 5001), (70010, 1983.43, '2012-10-10', 3004, 5006),
(70003, 2480.4, '2012-10-10', 3009, 5003), (70012, 250.45, '2012-06-27', 3008, 5002),
(70011, 75.29, '2012-08-17', 3003, 5007), (70013, 3045.6, '2012-04-25', 3002, 5001);

select * from orders;

#Write an SQL statement to find the total purchase amount of all orders.
select sum(purchase_amount)
from orders ;

#Write an SQL statement to find the average purchase amount of all orders.
select avg(purchase_amount)
from orders ;

#Write an SQL statement to get the maximum purchase amount of all the orders.
select max(purchase_amount)
from orders ;

#Write an SQL statement to get the minimum purchase amount of all the orders.
select min(purchase_amount)
from orders ;


#Write an SQL statement to find the number of salesmen listed in the table.
select count(distinct salesman_id)
from orders;

#Write an SQL statement to find the highest purchase amount ordered by the each customer with their ID and highest purchase amount.

select customer_id,max(purchase_amount) from orders group by customer_id order by customer_id;

#Write an SQL statement to find the highest purchase amount on '2012-08-17' for each salesman with their ID.
select salesman_id,max(purchase_amount) from orders group by salesman_id order by salesman_id;

#Write an SQL statement to find the highest purchase amount with their ID and order date, for only those customers who have a higher purchase amount within the list [2030, 3450, 5760, 6000].


select o.customer_id,order_date from orders o,
(select customer_id,max(purchase_amount) purchase_amount
from orders
group by customer_id
having max(purchase_amount) in (2030, 3450, 5760, 6000)) g
where o.customer_id=g.customer_id and o.purchase_amount=g.purchase_amount;

create table customers (
    customer_id int primary key, customer_name varchar(32),
    city varchar(20), grade int, salesman_id int);

-- Insert values into it
insert into customers values 
(3002, 'Nick Rimando', 'New York', 100, 5001), (3007, 'Brad Davis', 'New York', 200, 5001),
(3005, 'Graham Zusi', 'California', 200, 5002), (3008, 'Julian Green', 'London', 300, 5002),
(3004, 'Fabian Johnson', 'Paris', 300, 5006), (3009, 'Geoff Cameron', 'Berlin', 100, 5003),
(3003, 'Jozy Altidor', 'Moscow', 200, 5007), (3001, 'Brad Guzan', 'London', 300, 5005);



#Write an SQL statement to know which salesman are working for which customer.
select s.salesman_name,c.customer_name
from customers c,salesman s
where c.salesman_id=s.salesman_id;

#Write an SQL statement to make a list in ascending order for the customer who holds a grade less than 300 and works either through a salesman.
SELECT a.customer_name, a.city, a.grade, b.salesman_name AS "Salesman", b.salesman_city FROM customers a 
LEFT OUTER JOIN salesman b ON a.salesman_id=b.salesman_id WHERE a.grade<300 
ORDER BY a.customer_id;

#Write an SQL statement to find the list of customers who appointed a salesman for their jobs who gets a commission from the company is more than 12%.
select s.salesman_name,c.customer_name,s.commision
from customers c,salesman s
where c.salesman_id=s.salesman_id and s.commision>12;

#Write an SQL statement to find the details of a order i.e. order number, order date, amount of order, which customer gives the order and which salesman works for that customer and commission rate he gets for an order.
select o.order_no 'Order_number',o.order_date 'Order_date',o.purchase_amount 'amount of order', c.customer_name 'CustomerName',s.salesman_name 'salesmanName',s.commision 'Commision'
from customers c,salesman s, orders o
where o.customer_id=c.customer_id and s.salesman_id=o.salesman_id;

#Write a query to find all the orders issued against the salesman who may works for customer whose id is 3007.
SELECT * FROM orders
WHERE salesman_id=(SELECT DISTINCT salesman_id FROM orders WHERE customer_id=3007);

#Write a query to find all orders attributed to a salesman in New York.
select order_no
from orders where salesman_id in 
(select distinct salesman_id from salesman where upper(salesman_city)='NEWYORK');

#Write a query to count the customers with grades above New York's average.

select count(distinct customer_id) from customers a where grade> 
(select avg(grade)
from customers b
where city='New York'
);

#Write a query to extract the data from the orders table for those salesman who earned the maximum commission
select * from orders o,salesman s where o.salesman_id=s.salesman_id and s.commision=
(select max(commision)
from salesman);

#Write a query that produces the name and number of each salesman and each customer with more than one current order. Put the results in alphabetical order.
select * from customers;

select s.salesman_name , c.customer_name
from salesman s, customers c, 
(select customer_id,salesman_id
from orders 
group by customer_id,salesman_id
having count(*)>1) z
where s.salesman_id=z.salesman_id and c.customer_id=z.customer_id;

#Write a query to make a report of which salesman produce the largest and smallest orders on each date. Also add a column that shows "highest on" and "lowest on" values.


select o.order_date,s.salesman_name "lowest salesman",s1.salesman_name "highest salesman" from orders o,orders o1,salesman s,salesman s1,
(select min(purchase_amount) "lowest_on_day",order_date
from orders
group by order_date) low,
(select max(purchase_amount) "highest_on_day",order_date
from orders
group by order_date) high
where o.order_date=low.order_date and o.order_date=high.order_date
and o.order_date=o1.order_date and s.salesman_id=o.salesman_id and s1.salesman_id=o1.salesman_id and 
o.purchase_amount=low.lowest_on_day and o1.purchase_amount=high.highest_on_day
order by order_date;


SELECT a.salesman_id, salesman_name, order_no, 'highest on', order_date FROM salesman a, orders b
WHERE a.salesman_id=b.salesman_id
AND b.purchase_amount=(SELECT MAX(purchase_amount) FROM orders c WHERE c.order_date = b.order_date)
UNION
SELECT a.salesman_id, salesman_name, order_no, 'lowest on', order_date FROM salesman a, orders b
WHERE a.salesman_id=b.salesman_id
AND b.purchase_amount=(SELECT MIN(purchase_amount) FROM orders c WHERE c.order_date = b.order_date);




select min(purchase_amount) "lowest on day", max(purchase_amount) "highest on day"
from orders
group by order_date;

select * from orders order by order_date;



select * from salesman;

select * from customers;

select * from orders;






