create database onlineBookStore;
use onlinebookstore;
-- create table for books,customers,orders
create table books(
Book_ID serial primary key,
Title varchar(100),
author varchar(100),
Genre varchar(50),
Published_Year int,
price numeric (10,2),
stock int );
create table customers(
Customer_ID serial primary key,
Name varchar(100),
Email varchar(100),
Phone varchar(50),
city varchar(50),
country varchar(150)
);
create table orders(
Order_ID serial primary key,
Customer_ID int references Customers(Customer_ID),
Book_ID int references books(Book_ID),
Order_date date,
quantity int,
Total_Amount numeric (10,2)
);
-- imported data from table data import wizard
select* from customers;
select* from books;
select* from orders;
-- 1) total numbers of books,orders,customers
select count(order_id) from orders;
select distinct count(title) from books;
select distinct count(name) from customers;
-- 2)total revenue and total quantity sold
select sum(total_amount) as total from orders;
select sum(quantity) as total_quantity from orders;
-- 3)distinct countries and cities served
select distinct country,city from customers;
SELECT COUNT(DISTINCT Country) AS countries, COUNT(DISTINCT City) AS cities
FROM customers;
-- 4)Top 10 most recent orders
select * from orders order by order_date desc limit 10;
-- 5)Basic join: list orders with customer name and book title
SELECT
  o.Order_ID, o.Order_Date, o.Quantity, o.Total_Amount,
  c.Name AS customer_name, c.City, c.Country,
  b.Title AS book_title, b.Author, b.Genre, b.Price
FROM orders as o
JOIN customers as c ON c.Customer_ID = o.Customer_ID
JOIN books as b ON b.Book_ID = o.Book_ID
ORDER BY o.Order_Date DESC;
-- 6)Revenue by genre
select genre,sum(total_amount) from orders inner join books on orders.book_id=books.book_id group by genre;
-- 7)Top 10 best-selling books (by units)
select * from orders;
select * from books;
select * from customers;
select o.quantity,b.title from orders as o join books as b on o.book_id=b.book_id order by quantity desc limit 10 ;
SELECT
  b.Book_ID,
  b.Title,
  SUM(o.Quantity) AS units_sold
FROM orders AS o
JOIN books  AS b ON o.Book_ID = b.Book_ID
GROUP BY b.Book_ID, b.Title
ORDER BY units_sold DESC, b.Title ASC
LIMIT 10;
-- 8)retreive all books in the "fiction" genre
select * from books where genre ="fiction";
-- 9)find book published after 1950
select * from books where published_year  > 1950 ;
-- 10)list all the customers from canada
select * from customers where country = "canada";
-- 11)show orders placed in november 2023
select * from orders where order_date between "2023-11-01" and "2023-11-30";
-- 12) retrive the total stocks of books available
select sum(stock) from books as total_stock_of_books;
-- 13) find the details of the most expensive books
select * from books order by price desc limit 10;
-- 14)show the list of customers who orderd more than one book
select * from orders where quantity > 1;
-- 15)retrive all orders where where total amount exceeds $20
select * from orders where total_amount >20;
-- 16) retrive all genre available in the book table
select distinct genre from books;
-- 17)find the books with the lowest stock
select * from books order by stock limit 10;
-- 18) calculate the total revenue generated
select sum(total_amount) from orders as total_revenue_generated;
-- 19) total number of books sold for each genre
select b.genre,sum(o.quantity) as total_book_sold from books as b join orders as o on b.book_id = o.book_id group by genre;
-- 20) find the average price of books in fantasy genre
select genre,avg(price) as average_price from books where genre ="fantasy";

-- 21)list customers who have placed atlest 2 orders
select o.customer_id,count(o.order_id),c.name
from orders as o
join customers as c on o.customer_id=c.customer_id
group by o.customer_id having count(order_id) >=2;

-- 22)find the most frequently orderd book

select book_id,count(order_id) as order_count from orders group by book_id order by order_count desc limit 1;
-- 23)show the top 3 most expensive books of 'fantasy' genre
select* from customers;
select* from books;
select* from orders;
select * from books where genre ="fantasy" order by price desc limit 3;
-- 24) retrive the total qunatity of books sold by each author
select b.author,sum(o.quantity) as totalBooksSold
from orders as o join books as b on o.book_id=b.book_id  group by b.author;
-- 25)list the cities where customers spent more than $30 are located
select distinct c.city from orders as o join customers as c on o.customer_id=c.customer_id where o.total_amount >30;


