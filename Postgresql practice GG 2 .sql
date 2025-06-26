--PostgreSQL Questions for Intermediate--

--Q1. Find the total number of books borrowed by each member.

SELECT m.member_id , count(b.*) as total_books
from members m 
JOIN borrowings b
on m.member_id = b.member_id
Group by m.member_id;

--simple

SELECT member_id, COUNT(book_id) AS total_borrowed 
FROM Borrowings 
GROUP BY member_id;

--Q2. Display the title and author of the most borrowed book.
select * from books

SELECT b.title , t.name,count(b2.*) as most_borrowed
FROM BOOKs b
join authors t
on b.author_id = t.author_id
JOIN borrowings b2
On b.book_id = b2.book_id
GROUP BY 1,2
order by most_borrowed DESC 
lIMIT 1;

--OR

SELECT title, name FROM Books 
INNER JOIN Authors ON Books.author_id = Authors.author_id
INNER JOIN Borrowings ON Books.book_id = Borrowings.book_id 
GROUP BY title, name 
ORDER BY COUNT(Borrowings.book_id) DESC LIMIT 1;

--Q3. Show the author who has the most books in the library.
SELECT * FROM AUTHORS

SELECT f.name,COUNT(B.author_id) AS total_books
FROM books b
INNER JOIN authors f
on b.author_id = f.author_id
GROUP BY F.name
order by total_books DESC
LIMIT 1;

--PERFECT ANS ABOVE ALSO CORRECT BUT you choose authorID ,book_id denote the total books

SELECT name, COUNT(book_id) AS total_books 
FROM Authors 
INNER JOIN Books 
ON Authors.author_id = Books.author_id 
GROUP BY name 
ORDER BY total_books DESC
LIMIT 1;

--Q4. Find all members who have borrowed more than 3 books.

select * From borrowings;

SELECT member_id, COUNT(book_id) AS total_borrowed 
FROM Borrowings 
GROUP BY member_id 
HAVING COUNT(book_id) > 3;

--Q5. List all books that have been borrowed but not returned.

SELECT b.title 
From books b
join borrowings  r
ON b.book_id = r.book_id
where return_date is null;

--Q6. Find the average number of copies available per category.

SELECT Category ,AVG(copies_available)  as  avg_copies_available
FROM BOOKS
GROUP BY category

--Q7. Update the return date of a book borrowed by a member.

SELECT * FROM borrowings

UPDATE Borrowings
set return_date = '2023-09-10'
where member_id = 5;

--Q8. Find the titles of books written by authors born in the 20th century.
SELECT * FROM BOOKS
SELECT * FROM authors

SELECT B.title from books b
join authors s
ON b.author_id = s.author_id
where s.birth_year < 2000;

--Rigth aprroch

SELECT title FROM Books 
INNER JOIN Authors 
ON Books.author_id = Authors.author_id 
WHERE Authors.birth_year BETWEEN 1901 AND 2000;

--Q9. Display the total number of borrowings made in 2023.

SELECT COUNT(*) FROM borrowings
where EXTRACT( YEAR FROM borrowed_date ) =2023;

--Q10. Delete all books in the 'Science' category.

DELETE FROM BOOKS
WHERE category = 'science';

--Q11. Display the top 5 most recently published books.

select Title, published_year
from books
ORDER BY Published_year DESC
LIMIT 5;

--Q12. List the names of members who have borrowed all available books.
SELECT M.name,
SELECT * FROM Members

SELECT * FROM Books

--Non sense Q

SELECT name FROM Members 
WHERE member_id IN 
(SELECT member_id FROM Borrowings 
 GROUP BY member_id 
 HAVING COUNT(book_id) = (SELECT COUNT(*) FROM Books));

--Q13. Find the total number of unique books borrowed by members in 2023.

SELECT COUNT(DISTINCT book_id) 
FROM Borrowings 
WHERE EXTRACT(YEAR FROM borrowed_date) = 2023;

--Q14. Display the name and email of members who borrowed books more than twice in 2022.
select * from 

SELECT name,email from members
WHERE member_id IN
(select member_id FROM borrowings 
WHERE EXTRACT (YEAR FROM borrowed_date ) = 2022
group by member_id HAVING COUNT(Borrowing_id ) >2);


--Q15. Find all books that were borrowed but have not been returned for over 30 days.

SELECT title FROM Books 
INNER JOIN Borrowings ON Books.book_id = Borrowings.book_id 
WHERE return_date IS NULL 
AND (CURRENT_DATE - borrowed_date) > 30;

--Q16. Find the youngest author in the library.

SELECT name FROM Authors 
ORDER BY birth_year DESC 
LIMIT 1;

--Q17. Find the title of books that have more than 10 copies available.

SELECT TITLE from books
where copies_available >10;

--Q18. Create a view that shows all books along with the author's name.

CREATE VIEW bookauthors as
(
select b.*, a.name as author_name 
from books b
inner join authors a
on b.author_id = a.author_id 
)

SELECT * FROM bookauthors

--Q19. Find the top 3 categories with the most books.

SELECT category, COUNT(*) AS book_count 
FROM Books 
GROUP BY category 
ORDER BY book_count DESC 
LIMIT 3;

--Q20. Display the names of all members who borrowed books written by 'J.K. Rowling'.

SELECT Members.name FROM Members
INNER JOIN Borrowings ON Members.member_id = Borrowings.member_id
INNER JOIN Books ON Borrowings.book_id = Books.book_id
INNER JOIN Authors ON Books.author_id = Authors.author_id
WHERE Authors.name = 'J.K. Rowling';

---Finish Intermediate Level---