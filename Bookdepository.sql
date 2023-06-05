--We are working on a dataset from a Bookdepository Database. 
--Retrieving all information from 'dataset' table

SELECT *
FROM dataset;

--Retrieving the title, imprint, rating, number of ratings, and language.

SELECT title, imprint, rating_avg, rating_count, lang
FROM dataset;

--How many distinct languages are there?

SELECT DISTINCT lang
FROM dataset;

--Finding the books published by "MIT Press"

SELECT title, imprint, rating_avg, rating_count, lang
FROM dataset
WHERE imprint = 'MIT Press';

--Finding the books with rating below 2

SELECT title, imprint, rating_avg, rating_count, lang
FROM dataset
WHERE rating_avg < 2;

--Finding the books with rating at least 4 as well as at least 5000 ratings.

SELECT title, imprint, rating_avg, rating_count, lang
FROM dataset
WHERE rating_avg > 4 AND rating_count > 5000;

--Finding the books with rating at most 2 or ratings more than 100000

SELECT title, imprint, rating_avg, rating_count, lang
FROM dataset
WHERE rating_avg < 2 OR rating_count > 100000;

--Finding the books with rating from 4.6 to 4.9

SELECT title, imprint, rating_avg, rating_count, lang
FROM dataset
WHERE rating_avg BETWEEN 4.6 AND 4.9;

--Finding the books that have the word 'history' anywhere in their title

SELECT title
FROM dataset
WHERE title LIKE '%history%';

--Finding the books in Spanish('hi)', Italian('it') and Greek('el').

SELECT title, imprint, rating_avg, rating_count, lang
FROM dataset
WHERE lang IN ('hi','it','el');

--Finding the books printed in formats 15,16,17. We explore the rest of the tables and find which are these formats

SELECT title, format
FROM dataset
WHERE format IN (15,16,17);

SELECT *
FROM formats
WHERE format_id IN (15,16,17);

