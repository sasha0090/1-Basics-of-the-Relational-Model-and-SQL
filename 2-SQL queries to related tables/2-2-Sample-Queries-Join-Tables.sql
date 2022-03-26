/*
Задание

Вывести название, жанр и цену тех книг, количество которых больше 8,
в отсортированном по убыванию цены виде.
*/
SELECT
    title,
    name_genre,
    price
FROM
    book
    INNER JOIN
        genre
    ON
        book.genre_id = genre.genre_id
WHERE
    amount > 8
ORDER BY
    price DESC;

/*
Задание

Вывести все жанры, которые не представлены в книгах на складе.
*/
SELECT
    name_genre
FROM
    book
    RIGHT JOIN
        genre
    ON
        book.genre_id = genre.genre_id
WHERE
    book.genre_id IS NULL;

/*
Задание

Необходимо в каждом городе провести выставку книг каждого автора
в течение2020 года.
Дату проведения выставки выбрать случайным образом.
Создать запрос, который выведет город, автора и дату проведения выставки.
Последний столбец назвать Дата. Информацию вывести, отсортировав сначала в
алфавитном порядке по названиям городов, а потом по убыванию дат
проведения выставок.
*/
SELECT
    name_city,
    name_author,
    DATE_ADD('2020-01-01', INTERVAL FLOOR(RAND() * 365) DAY) AS 'Дата'
FROM
    author
    CROSS JOIN
        city
ORDER BY
    name_city,
    Дата DESC;

/*
Задание

Вывести информацию о книгах (жанр, книга, автор), относящихся к жанру,
включающему слово «роман» в отсортированном по названиям книг виде.
*/
SELECT
    name_genre,
    title,
    name_author
FROM
    book
    INNER JOIN
        author
    ON
        book.author_id = author.author_id
    INNER JOIN
        genre
    ON
        book.genre_id = genre.genre_id
WHERE
    name_genre LIKE '%роман%'
ORDER BY
    title;

/*
Задание

Посчитать количество экземпляров  книг каждого автора из таблицы author.
Вывести тех авторов,  количество книг которых меньше 10,
в отсортированном по возрастанию количества виде.
Последний столбец назвать Количество.
*/
SELECT
    name_author,
    SUM(amount) AS Количество
FROM
    author
    LEFT JOIN
        book
    ON
        author.author_id = book.author_id
GROUP BY
    name_author
HAVING
    Количество < 10 OR Количество IS NULL
ORDER BY
    Количество;

/*
Задание

Вывести в алфавитном порядке всех авторов, которые пишут только в одном жанре.
Поскольку у нас в таблицах так занесены данные, что у каждого автора книги
только в одном жанре,  для этого запроса внесем изменения в таблицу book.
Пусть у нас  книга Есенина «Черный человек» относится к жанру «Роман»,
а книга Булгакова «Белая гвардия» к «Приключениям»
(эти изменения в таблицы уже внесены).
*/

SELECT
    name_author
FROM
    author
    LEFT JOIN
        book
    ON
        book.author_id = author.author_id
GROUP BY
    name_author
HAVING
    COUNT(DISTINCT genre_id) = 1
ORDER BY
    name_author;

/*
Задание

Вывести информацию о книгах (название книги, фамилию и инициалы автора,
название жанра, цену и количество экземпляров книги), написанных в самых
популярных жанрах, в отсортированном в алфавитном порядке по названию книг виде.
Самым популярным считать жанр, общее количество экземпляров книг которого на
складе максимально.
*/
SELECT
    title, name_author, name_genre, price, amount
FROM
    book
    INNER JOIN
        author
    ON
        author.author_id = book.author_id
    INNER JOIN
        genre
    ON
        genre.genre_id = book.genre_id
WHERE
    book.genre_id IN (
    SELECT
        most_popular_genres.genre_id
    FROM
        (SELECT
            genre_id,
            SUM(amount) AS sum_amount
        FROM
            book
        GROUP BY
            genre_id) most_popular_genres
    INNER JOIN
        (SELECT
            SUM(amount) AS sum_amount
        FROM
            book
        GROUP BY
            genre_id
        ORDER BY
            sum_amount DESC
        LIMIT 1) max_genre_amount
    ON
        most_popular_genres.sum_amount = max_genre_amount.sum_amount)
ORDER BY
    title;
/*
Задание

Если в таблицах supply  и book есть одинаковые книги, которые имеют равную цену,
вывести их название и автора, а также посчитать общее количество
экземпляров книг в таблицах supply и book,
столбцы назвать Название, Автор  и Количество.
*/
SELECT
    book.title AS Название,
    name_author AS Автор,
    book.amount + supply.amount AS Количество
FROM
    book
    INNER JOIN author USING(author_ID)
    INNER JOIN
        supply
    ON
        supply.price = book.price
        AND
        supply.title = book.title;