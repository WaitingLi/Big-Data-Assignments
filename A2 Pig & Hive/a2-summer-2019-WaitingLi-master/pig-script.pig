books = LOAD 'i-bigrams/googlebooks-eng-us-all-2gram-20120701-i?' AS (words:chararray,year:int,number:int,num_of_books:int);
books_group = GROUP books BY words;
result = FOREACH books_group GENERATE group, SUM(books.number) AS total_number, SUM(books.num_of_books) AS number_of_books, (float)SUM(books.number)/(float)SUM(books.num_of_books) AS average_occurences_per_book, MIN(books.year) AS first_year , MAX(books.year) AS last_year, COUNT(books.year) AS years_count;
f_last = FILTER result BY last_year == 2009;
f_first = FILTER f_last BY first_year == 1950;
f_appear = FILTER f_first BY (int)years_count == (int)60;
ordered = ORDER f_appear BY average_occurences_per_book DESC;
out = LIMIT ordered 50;
store out INTO 's3://weiteng-li/assign2_pig' USING PigStorage(',','-schema');
