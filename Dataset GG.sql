
Create Database PostgreSQLGG;

/*1. Authors Table
The Author's table contains essential information about authors, including their names,
birth years, and countries. This table serves as a reference point for the Books table,
linking each book to its respective author through the author_id foreign key.
*/

CREATE TABLE Authors (
    author_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    birth_year INT,
    country VARCHAR(100)
);

-- Insert values into the Authors table

INSERT INTO Authors (name, birth_year, country)
VALUES
('George Orwell', 1903, 'UK'),
('J.K. Rowling', 1965, 'UK'),
('Isaac Asimov', 1920, 'Russia'),
('Mark Twain', 1835, 'USA'),
('Harper Lee', 1926, 'USA');

SELECT * FROM AUTHORS;

/*2. Books Table
The Books table holds data about various books, including titles, associated authors, categories, publication years, and the number of copies available. 
By referencing the author_id from the Authors table, 
this table establishes a connection that allows users to query book information alongside author details.
*/

CREATE TABLE Books (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    author_id INT REFERENCES Authors(author_id),
    category VARCHAR(50),
    published_year INT,
    copies_available INT
);

-- Insert values into the Books table
INSERT INTO Books (title, author_id, category, published_year, copies_available)
VALUES
('1984', 1, 'Dystopian', 1949, 5),
('Animal Farm', 1, 'Political Satire', 1945, 3),
('Harry Potter and the Philosopher''s Stone', 2, 'Fantasy', 1997, 7),
('Harry Potter and the Chamber of Secrets', 2, 'Fantasy', 1998, 6),
('Foundation', 3, 'Science Fiction', 1951, 4),
('The Adventures of Tom Sawyer', 4, 'Adventure', 1876, 8),
('To Kill a Mockingbird', 5, 'Fiction', 1960, 10);

SELECT * FROM BOOKS;

/*3. Members Table
The Members table tracks information about library members, 
including their names, unique email addresses, and membership dates. 
This structure is fundamental for managing user access to library resources.
The member_id serves as a unique identifier for each member. */

CREATE TABLE Members (
    member_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    membership_date DATE
);

-- Insert values into the Members table
INSERT INTO Members (name, email, membership_date)
VALUES
('Alice Johnson', 'alice.johnson@example.com', '2023-01-15'),
('Bob Smith', 'bob.smith@example.com', '2023-02-10'),
('Charlie Brown', 'charlie.brown@example.com', '2023-03-05'),
('Diana Prince', 'diana.prince@example.com', '2023-04-20'),
('Edward Stark', 'edward.stark@example.com', '2023-05-25');

SELECT * FROM MEMBERS;

/*4. Borrowings Table
The Borrowings table records transactions where members borrow books. 
It includes details such as the book and member IDs, 
borrowing dates, and return dates. 
This table is used for tracking the borrowing activity within the library, allowing for queries that can analyze borrowing patterns, 
overdue items, and member engagement.*/

CREATE TABLE Borrowings (
    borrowing_id SERIAL PRIMARY KEY,
    book_id INT REFERENCES Books(book_id),
    member_id INT REFERENCES Members(member_id),
    borrowed_date DATE,
    return_date DATE
);

-- Insert values into the Borrowings table
INSERT INTO Borrowings (book_id, member_id, borrowed_date, return_date)
VALUES
(1, 1, '2023-07-10', '2023-07-20'),
(3, 2, '2023-06-15', '2023-06-25'),
(5, 3, '2023-08-05', NULL),
(7, 4, '2023-09-01', '2023-09-15'),
(2, 5, '2023-09-10', NULL);

SELECT * FROM BORROWINGS;