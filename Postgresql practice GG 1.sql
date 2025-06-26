--PostgreSQL Practice--

/*50 PostgreSQL Exercise Questions
This collection of 50 PostgreSQL exercises offers
a comprehensive set of questions designed to challenge and enhance our SQL skills.
*/

--PostgreSQL Questions for Beginners

--Q1. Select all books from the database

SELECT * FROM BOOKS;

--Q2. Find the title and category of all books published in 2020.

SELECT Title,category 
from books
where published_year = '2020';

--Q3. List all authors from the USA.

SELECT name FROM Authors
WHERE country = 'USA';

--Q4. Insert a new book into the Books table.

INSERT INTO Books 
(book_id, title, author_id, category, published_year, copies_available)
VALUES (101, 'The Pragmatic Programmer', 1, 'Programming', 1999, 5);

--Q5. Find all members who joined in the year 2023.

SELECT * FROM MEMBERS;

SELECT * FROM Members
WHERE EXTRACT(YEAR FROM membership_date) = 2023;

--Q6. Update the number of copies available for a specific book.

UPDATE BOOKS
SET copies_Available = 4
WHERE BOOK_ID = '101';

SELECT * FROM BOOKs

--Q7. Delete a book from the Books table.S;

DELETE FROM books
where book_id = '101';

--Q8. Find all books in the ‘Fiction’ category.

SELECT * FROM BOOKS
WHERE Category = 'Fiction';

--Q9. Display the name and email of all members.

SELECT name,email from members

--Q10. Count how many books are available in the 'History' category.

SELECT COUNT(*) as Total_books
FROM Books
where category = 'History';

SELECT * FROM books;
select * From Authors;
Select * From  members;
SELECT * from borrowings;

--Q11. Find the title of the book borrowed by the member with ID 3.

SELECT t.title from books t
join borrowings b
On t.book_id = b.book_id 
where b.member_id = 3;

--OR

SELECT title FROM Books 
INNER JOIN Borrowings 
ON Books.book_id = Borrowings.book_id 
WHERE member_id = 3;

--Q12. Display the name and borrowed_date of all members who borrowed a book in January 2023.
Select m.name , b.borrowed_date
From members m
Join borrowings b
on m.member_id = b.member_id
where EXTRACT(Month FROM b.borrowed_date ) =1 AND
EXTRACT(YEAR FROM b.borrowed_date) = 2023;
--OR
SELECT name, borrowed_date FROM Members 
INNER JOIN Borrowings ON Members.member_id = Borrowings.member_id 
WHERE EXTRACT(MONTH FROM borrowed_date) = 1 AND EXTRACT(YEAR FROM borrowed_date) = 2023;

--Q13. List all books authored by 'George Orwell'.

SELECT title FROM Books b
Inner Join authors  t
on b.author_id = t.author_id
where t.name = 'George Orwell';

--Q14. Find all authors who were born before 1950.
SELECT * FROM AUTHORS;

SELECT NAME FROM Authors
where birth_year < 1950;

--Q15. Insert a new author into the Authors table.

INSERT INTO Authors 
(author_id, name, birth_year, country)
VALUES (6, 'Isaac Asimov', 1920, 'Russia');

--Q16. Display the total number of members.

SELECT COUNT(*) as total_members FROM Members;

--Q17. Show all borrowings that have not been returned yet.

SELECT * FROM borrowings
where return_date is null;

--Q18. List all unique categories of books in the library.

SELECT DISTINCT Category from books;

--Q19. Find the number of books available for each category

SELECT category, COUNT(*) AS total_books 
FROM Books 
GROUP BY category;

--Q20. Display the name of the member who borrowed the book titled '1984'

SELECT Name from members m
inner join books b 
ON m.member_id = b.book_id
where b.title = '1984';

--Rigth approch

SELECT Members.name 
FROM Members 
INNER JOIN Borrowings ON Members.member_id = Borrowings.member_id 
INNER JOIN Books ON Borrowings.book_id = Books.book_id 
WHERE Books.title = '1984';

