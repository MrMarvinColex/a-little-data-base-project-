DROP TABLE IF EXISTS book;
CREATE TABLE book (
	_id INTEGER,
	title TEXT,
	author TEXT,
	publisher TEXT,
	year_of_publishing INTERVAL YEAR,
	price FLOAT
);
