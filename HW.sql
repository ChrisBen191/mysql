
USE sakila;

-- 1a. Display the first and last names of all actors from the table actor
SELECT first_name, last_name 
FROM actor;

-- 1b. Display the first and last name of each actor in a single column in upper case letters. 
-- Name the column Actor Name.
SELECT CONCAT_WS('', first_name, last_name) AS 'Full Name'
FROM actor;

-- 2a. You need to find the ID number, first name, and last name of an actor, 
-- of whom you know only the first name, "Joe." 
-- What is one query would you use to obtain this information?
SELECT actor_id, first_name, last_name 
FROM actor
WHERE first_name = 'Joe';

-- 2b. Find all actors whose last name contain the letters GEN:
SELECT * 
FROM actor
WHERE last_name
LIKE '%GEN%';

-- 2c. Find all actors whose last names contain the letters LI. 
-- This time, order the rows by last name and first name, in that order:
SELECT * 
FROM actor
WHERE last_name
LIKE '%LI%'
ORDER BY last_name, first_name;

-- 2d. Using IN, display the country_id and country columns of the following countries: 
-- Afghanistan, Bangladesh, and China:
SELECT country_id, country 
FROM country
WHERE country IN ('Afghanistan','Bangladesh', 'China');

-- 3a. You want to keep a description of each actor. You don't think you will be performing 
-- queries on a description, so create a column in the table actor named description and use 
-- the data type BLOB (Make sure to research the type BLOB, as the difference between it and VARCHAR 
-- are significant).

ALTER TABLE actor 
ADD COLUMN description BLOB;

-- 3b. Very quickly you realize that entering descriptions for each actor is too much effort. 
-- Delete the description column.

ALTER TABLE actor
DROP description;

-- 4a. List the last names of actors, as well as how many actors have that last name.
SELECT last_name, COUNT(last_name) AS total
FROM actor
GROUP BY last_name
ORDER BY total DESC;

-- 4b. List last names of actors and the number of actors who have that last name, 
-- but only for names that are shared by at least two actors.
SELECT last_name, COUNT(last_name) AS total
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) > 2
ORDER BY total DESC;
 
 -- 4c. The actor HARPO WILLIAMS was accidentally entered in the actor table as GROUCHO WILLIAMS. 
--  Write a query to fix the record.
UPDATE actor
SET first_name = 'HARPO'
WHERE actor_id = 172;

-- 4d. Perhaps we were too hasty in changing GROUCHO to HARPO. It turns out that GROUCHO was 
-- the correct name after all! In a single query, if the first name of the actor is 
-- currently HARPO, change it to GROUCHO.
UPDATE actor
SET first_name = 'GROUCHO'
WHERE actor_id = 172;

-- 5a. You cannot locate the schema of the address table. Which query would you use to re-create it?
-- CREATE TABLE new_actor_table
-- (
-- 	actor_id SMALLINT UNSIGNED,
--     first_name VARCHAR(30),
--     last_name VARCHAR(30),
--     last_update TIMESTAMP
-- )

-- 6a. Use JOIN to display the first and last names, as well as the address, 
-- of each staff member. Use the tables staff and address:
SELECT first_name, last_name, address 
FROM address
INNER JOIN staff
ON address.address_id = staff.address_id;

-- 6b. Use JOIN to display the total amount rung up by each staff member 
-- in August of 2005. Use tables staff and payment.
SELECT first_name, SUM(amount) as total
FROM payment
INNER JOIN staff
ON payment.staff_id = staff.staff_id
GROUP BY first_name;

-- 6c. List each film and the number of actors who are listed for that film. 
-- Use tables film_actor and film. Use inner join.
SELECT title, COUNT(actor_id) as Actors
FROM film_actor AS fa
INNER JOIN film AS f
ON fa.film_id = f.film_id
GROUP BY title
ORDER BY Actors DESC; 

-- 6d. How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT COUNT(film_id) as 'Amount of Copies'
FROM inventory
WHERE film_id 
IN
(
	SELECT film_id 
	FROM film
	WHERE title = 'Hunchback Impossible'
);

-- 6e. Using the tables payment and customer and the JOIN command, 
-- list the total paid by each customer. List the customers alphabetically 
-- by last name:
SELECT first_name, last_name, SUM(amount) as 'Total Amount Paid'
FROM payment AS p
LEFT JOIN customer AS c
ON p.customer_id = c.customer_id
GROUP BY last_name, first_name;

-- 7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. 
-- As an unintended consequence, films starting with the letters K and Q have also 
-- soared in popularity. Use subqueries to display the titles of movies starting 
-- with the letters K and Q whose language is English.
SELECT title
FROM film 
WHERE language_id IN
(
	SELECT language_id 
	FROM language
	WHERE language_id = 1
);




