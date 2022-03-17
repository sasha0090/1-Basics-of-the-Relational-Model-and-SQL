/**/
SELECT
    name, city, per_diem, date_first, date_last
FROM
    trip
WHERE
    name LIKE '%а %'
ORDER BY
    date_last DESC;

/**/
SELECT
    name
FROM
    trip
WHERE
    city = 'Москва'
GROUP BY
    name
ORDER BY
    name;

/**/
SELECT
    city,
    COUNT(city) AS Количество
FROM
    trip
GROUP BY
    city
ORDER BY
    city;

/**/
SELECT
    city,
    COUNT(city) AS Количество
FROM
    trip
GROUP BY
    city
ORDER BY
    Количество DESC
LIMIT 2;

/*
Задание

Вывести информацию о командировках во все города кроме Москвы и Санкт-Петербурга
(фамилии и инициалы сотрудников, город ,  длительность командировки в днях,
при этом первый и последний день относится к периоду командировки).
Последний столбец назвать Длительность.
Информацию вывести в упорядоченном по убыванию длительности поездки,
а потом по убыванию названий городов (в обратном алфавитном порядке).
*/
SELECT
    name,
    city,
    DATEDIFF(date_last, date_first)+1 AS Длительность
FROM
    trip
WHERE
    city NOT IN ('Москва', 'Санкт-Петербург')
ORDER BY
    Длительность DESC,
    city DESC;

/*
Задание

Вывести информацию о командировках сотрудника(ов),
которые были самыми короткими по времени.
В результат включить столбцы name, city, date_first, date_last.
*/
SELECT
    name, city, date_first, date_last
FROM
    trip
WHERE
    DATEDIFF(date_last, date_first) = (
        SELECT
            MIN(DATEDIFF(date_last, date_first))
        FROM
            trip
        );

/*
Задание

Вывести информацию о командировках, начало и конец которых относятся
к одному месяцу (год может быть любой).
В результат включить столбцы name, city, date_first, date_last.
Строки отсортировать сначала  в алфавитном порядке по названию города,
а затем по фамилии сотрудника .
*/
SELECT
    name, city, date_first, date_last
FROM
    trip
WHERE
    MONTH(date_first) = MONTH(date_last)
ORDER BY
    city,
    name;

