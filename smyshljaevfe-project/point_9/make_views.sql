-- 1. Скрываем электронные адреса клиентов.
DROP VIEW IF EXISTS client_view;
CREATE VIEW client_view AS
SELECT DISTINCT _id,
	_name,
	surname,
	CONCAT(SUBSTRING(email FROM 1 FOR 2), '******', SUBSTRING(email FROM length(email)-6 FOR 7)) AS hidden_email
FROM client,
ORDER BY _id;

/* VIEW:
  1	"Иван"	  "Иванов"	  "iv******mail.ru"
  2	"Петр"	  "Петров"	  "pe******mail.ru"
  3	"Алексей"	"Сидоров"	  "al******mail.ru"
  ...
*/


-- 2. Избегаем длинных названий книг, добавляем доллар в конда для красоты.
DROP VIEW IF EXISTS book_view;
CREATE VIEW book_view AS
SELECT CASE WHEN length(title) > 10 THEN
	   		      CONCAT(SUBSTRING(title FROM 1 FOR 10), '. . .')
			      ELSE title
		   END AS title,
	author,
	CONCAT(price, '$') AS price
FROM book
ORDER BY title;

/* VIEW:
  "1984"	          "George Orwell"	  "10.99$"
  "Beloved"	        "Toni Morrison"	  "11.99$"
  "Fahrenheit. . ."	"Ray Bradbury"	  "8.99$"
  ...
*/


-- 3. Смотрим на современные заказы, которые доставлялись дронами.
DROP VIEW IF EXISTS modern_order_view;
CREATE VIEW modern_order_view AS
WITH drone_locations AS (
	SELECT d.adress
	FROM delivery_method d
	WHERE d.delivery_method = 'drone')
SELECT _id,
	_date,
	customer_id
FROM _order
WHERE adress IN (SELECT adress FROM drone_locations);


-- 4. Соединяем значение discount из схемы publisher с оценкой score из схемы
-- feedback через схему book. Пытаемся понять, есть ли какая-нибудь зависимость
-- между скидкой и отзывом.
DROP VIEW IF EXISTS discount_and_score;
CREATE VIEW discount_and_score AS
SELECT title,
	discount,
	score
FROM publisher pub
RIGHT OUTER JOIN book ON pub.publisher = book.publisher
JOIN feedback fb ON fb.book_id = book._id
ORDER BY title, score;


SELECT discount * score
FROM discount_and_score;
/* OUTPUT:
  24.528
  37.668
  18.695999999999998
  17.6
  4.602
  33.435
  3.4880000000000004
  . . . 

  Вывод: линейной предпологаемой зависимости точно нет.
*/


-- 5.
