/*
Задание

Создать таблицу fine
*/
CREATE TABLE fine(
    fine_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(30),
    number_plate VARCHAR(6),
    violation VARCHAR(50),
    sum_fine DECIMAL,
    date_violation DATE,
    date_payment DATE
    );

/*
Задание

В таблицу fine первые 5 строк уже занесены.
Добавить в таблицу записи с ключевыми значениями 6, 7, 8.
*/
INSERT INTO
    fine(name, number_plate, violation, sum_fine, date_violation, date_payment)
VALUES
    ('Баранов П.Е.', 'Р523ВТ', 'Превышение скорости(от 40 до 60)', NULL, '2020-02-14', NULL),
    ('Абрамова К.А.', 'О111АВ', 'Проезд на запрещающий сигнал', NULL, '2020-02-23', NULL),
    ('Яковлев Г.Р.', 'Т330ТТ', 'Проезд на запрещающий сигнал', NULL, '2020-03-03', NULL);

/*
Задание

В таблице fine увеличить в два раза сумму неоплаченных штрафов для отобранных
на предыдущем шаге записей.

(Мое решение)
*/
UPDATE
    fine,
    (SELECT
         name
     FROM
         fine
     GROUP BY
         name, number_plate, violation
     HAVING
         COUNT(*) >= 2
    ) AS query_in
SET
    fine.sum_fine = IF(fine.date_payment IS NULL, fine.sum_fine * 2, fine.sum_fine)
WHERE
    fine.name = query_in.name;

/*
Задание

- В таблицу fine занести дату оплаты соответствующего штрафа из таблицы payment;
- Уменьшить начисленный штраф в таблице fine в два раза (только для тех штрафов,
информация о которых занесена в таблицу payment),
если оплата произведена не позднее 20 дней со дня нарушения.
*/
UPDATE
    fine AS f,
    payment AS p
SET
    f.date_payment = p.date_payment,
    f.sum_fine = IF(DATEDIFF(p.date_payment, p.date_violation) <= 20,
                    f.sum_fine/2,
                    f.sum_fine)
WHERE
    f.name = p.name
    AND
    f.date_violation = p.date_violation;

/*
Задание

Создать новую таблицу back_payment, куда внести информацию о
неоплаченных штрафах (Фамилию и инициалы водителя, номер машины, нарушение,
сумму штрафа и дату нарушения) из таблицы fine.
*/
CREATE TABLE
    back_payment AS
    SELECT
        name, number_plate, violation, sum_fine, date_violation
    FROM
        fine
    WHERE
        date_payment IS NULL;
/*
Задание

Удалить из таблицы fine информацию о нарушениях,
совершенных раньше 1 февраля 2020 года.
*/
DELETE FROM
    fine
WHERE
    date_violation < '2020-02-01';