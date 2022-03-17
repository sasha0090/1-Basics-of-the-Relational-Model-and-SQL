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

/*
Задание

Вывести название месяца и количество командировок для каждого месяца.
Считаем, что командировка относится к некоторому месяцу,
если она началась в этом месяце.
Информацию вывести сначала в отсортированном по убыванию количества,
а потом в алфавитном порядке по названию месяца виде.
Название столбцов – Месяц и Количество.
*/
SELECT
    MONTHNAME(date_first) AS Месяц,
    COUNT(MONTHNAME(date_first)) AS Количество
FROM
    trip
GROUP BY
    MONTHNAME(date_first)
ORDER BY
    Количество DESC,
    Месяц;

/*
Задание

Вывести сумму суточных для командировок, первый день которых пришелся
на февраль или март 2020 года.
Значение суточных для каждой командировки занесено в столбец per_diem.
Вывести фамилию и инициалы сотрудника, город, первый день командировки и
сумму суточных. Последний столбец назвать Сумма.
Информацию отсортировать сначала  в алфавитном порядке по фамилиям сотрудников,
а затем по убыванию суммы суточных.
*/
SELECT
    name,
    city,
    date_first,
    (DATEDIFF(date_last, date_first) + 1) * per_diem AS Сумма
FROM
    trip
WHERE
    MONTH(date_first) IN (2, 3)
    AND
    YEAR(date_first) = 2020
ORDER BY
    name,
    Сумма DESC;

/*
Задание

Вывести фамилию с инициалами и общую сумму суточных,
полученных за все командировки для тех сотрудников,
которые были в командировках больше чем 3 раза,
в отсортированном по убыванию сумм суточных виде.
Последний столбец назвать Сумма.
*/
SELECT
    name,
    SUM((DATEDIFF(date_last, date_first) + 1) * per_diem) AS Сумма
FROM
    trip
GROUP BY
    name
HAVING
    3 < COUNT(name)
ORDER BY
    Сумма DESC;
