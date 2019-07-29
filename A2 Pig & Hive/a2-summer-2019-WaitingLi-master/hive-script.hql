CREATE EXTERNAL TABLE my_table (
words string,
year int,
number double,
books double)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
LOCATION '/user/hadoop/r-bigrams/';

INSERT OVERWRITE DIRECTORY '/user/hadoop/assign2_hive' ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
STORED AS TEXTFILE
SELECT words, SUM (number) as total_number ,SUM (books) as total_books ,SUM (number)/SUM(books) as average, MIN (year) as first_year, MAX (year) as last_year, COUNT (year) as total
FROM my_table
GROUP BY words 
HAVING first_year = 1950 AND last_year = 2009 AND total = 60
ORDER BY average ASC
LIMIT 50;

