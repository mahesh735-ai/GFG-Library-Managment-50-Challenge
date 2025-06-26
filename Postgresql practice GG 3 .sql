--Advanced PostgreSQL Questions--

SELECT * FROM BOOKS
SELECT * FROM borrowings
SELECT * FROM authors
SELECT * FROM members

--Q1. Find the member who has borrowed the most unique books.

SELECT member_id, COUNT(DISTINCT book_id) AS unique_books 
FROM Borrowings 
GROUP BY member_id 
ORDER BY unique_books DESC 
LIMIT 1;

--Q2. Display the name of the member who borrowed a book for the longest time.

select  m.name,b.return_Date - b.borrowed_date as days_borrowed
from members m
INNER JOIN borrowings b
ON m.member_id = b.member_id
ORDER BY days_borrowed DESC
LIMIT 1; ---Yeah got output

SELECT return_Date - borrowed_date from Borrowings

--Q3. Calculate the total number of copies of books borrowed per author.

SELECT a.name , sum(b.copies_available) as total_copies
FROM BOOKS B
inner join authors a
on b.author_id = a.author_id
GROUP BY A.name;

---2nd approach and perfect 

SELECT Authors.name, SUM(Books.copies_available) AS total_copies 
FROM Authors
INNER JOIN Books ON Authors.author_id = Books.author_id
INNER JOIN Borrowings ON Books.book_id = Borrowings.book_id
GROUP BY Authors.name;

--Q4. Find the author with the fewest books in the library.

SELECT Authors.name, COUNT(Books.book_id) AS book_count 
FROM Authors 
INNER JOIN Books ON Authors.author_id = Books.author_id 
GROUP BY Authors.name 
ORDER BY book_count ASC 
LIMIT 1;

--Q5. Write a query to find the members who never borrowed a book.

Select m.name from members m
INNER JOIN borrowings b
ON M.member_id = B.Member_id 
where borrowed_Date is null;

-- OR

SELECT name FROM Members 
WHERE member_id NOT IN (SELECT member_id FROM Borrowings);

--Q6. Display the average number of days books were borrowed before being returned in 2022.

SELECT AVG(Return_date - borrowed_date ) as 
avg_days_borrowed FROM borrowings
WHERE EXTRACT(year FROM Borrowed_Date ) = 2022;

--Q7. Find the total number of books borrowed per month in 2023.

SELECT EXTRACT(MONTH FROM borrowed_date) AS month,
COUNT(book_id) AS Total_books_borrowed 
FROM Borrowings 
WHERE EXTRACT(YEAR FROM borrowed_date) = 2023 
GROUP BY month
ORDER BY month;

--Q8. List all members who borrowed more than 2 books in January 2023 but haven't borrowed any since.

SELECT member_id, COUNT(book_id) AS total_borrowed 
FROM Borrowings 
WHERE EXTRACT(MONTH FROM borrowed_date) = 1 
  AND EXTRACT(YEAR FROM borrowed_date) = 2023
GROUP BY member_id 
HAVING COUNT(book_id) > 2 
  AND member_id NOT IN 
    (SELECT member_id 
     FROM Borrowings 
     WHERE EXTRACT(MONTH FROM borrowed_date) > 1 
       AND EXTRACT(YEAR FROM borrowed_date) = 2023);
 
 
 --Q9. Write a query to find the total number of authors who have at least one book borrowed in 2023
SELECT * FROM Authors 
--I use Distinct to avoid repeatation of Names

 select count (Distinct a.name) as Total_author
 From authors a
 inner join books  b
 On a.author_id = b.author_id
 INNER JOIN borrowings s 
 ON b.book_id = s.book_id 
 where extract(year From borrowed_date) = 2023

 --Q10 .Create a trigger that updates the copies_available field in the Books table whenever a book is borrowed or returned.

 CREATE OR REPLACE FUNCTION update_copies_available() RETURNS TRIGGER AS $$
BEGIN
   IF (TG_OP = 'INSERT') THEN
      UPDATE Books SET copies_available = copies_available - 1 WHERE book_id = NEW.book_id;
   ELSIF (TG_OP = 'UPDATE') AND NEW.return_date IS NOT NULL THEN
      UPDATE Books SET copies_available = copies_available + 1 WHERE book_id = NEW.book_id;
   END IF;
   RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_copies_available_trigger
AFTER INSERT OR UPDATE ON Borrowings
FOR EACH ROW EXECUTE FUNCTION update_copies_available();



/*Conclusion
In this article, we have perform 50 PostgreSQL exercises across basic,
medium, and advanced levels, designed to strengthen our PostgreSQL skills and database management abilities.
From fundamental operations like SELECT and INSERT to more complex queries involving unique borrowings and automated triggers.

These exercises provide a comprehensive approach to mastering PostgreSQL.*/