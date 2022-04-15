-- select the genres used in the table "songs"
SELECT DISTINCT genres_id
FROM dbo.Songs


-- select  the first 3 lines where sex is men and they from Russia or Ukraine
SELECT TOP 3 *
FROM dbo.Singers
WHERE sex = 'чоловік' and ( country = 'Росія' or country = 'Україна')

SELECT  TOP 3 *
FROM dbo.Singers
WHERE sex = 'чоловік' and country in('Росія','Україна')


-- select rows where country not on "Р"-letter
SELECT *
FROM dbo.Singers
WHERE country NOT LIKE('Р%')


-- select rows where birthday between '1980-10-10' AND '2000-01-01' sort by last name and name
SELECT *
FROM dbo.Singers
WHERE birthday BETWEEN '1980-10-10' AND '2000-01-01'
ORDER BY last_name,first_name


 -- select all info in one table
SELECT *
FROM dbo.Songs a
FULL JOIN dbo.Singers b
	ON a.singers_id = b.id
FULL JOIN dbo.Genres c
	ON a.genres_id = c.name
FULL JOIN dbo.Albums d
	ON a.albums_id = d.id

 -- select all info in one table without genres that are not used
SELECT *
FROM dbo.Songs a
FULL JOIN dbo.Singers b
	ON a.singers_id = b.id
LEFT JOIN dbo.Genres c
	ON a.genres_id = c.name
FULL JOIN dbo.Albums d
	ON a.albums_id = d.id


-- select albums title and count of songs in album if count of songs in album > 1
SELECT  a.title, count(a.title) as count_Songs_title
FROM dbo.Songs s
FULL JOIN dbo.Albums a
	ON s.albums_id = a.id
GROUP BY a.title
HAVING count(a.title) > 1


-- select all dates on Singers and Albums
select birthday
from  dbo.Singers
UNION ALL
select release
from  dbo.Albums

 -- select all district dates on Singers and Albums
select birthday
from  dbo.Singers
UNION 
select release
from  dbo.Albums