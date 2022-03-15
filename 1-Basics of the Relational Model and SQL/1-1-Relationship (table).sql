/*
Задание
Сформулируйте SQL запрос для создания таблицы book.
*/

CREATE TABLE book(
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(50),
    author VARCHAR(50),
    price DECIMAL(8, 2),
    amount INT
);

/*
Задание
Занесите новую строку в таблицу book (текстовые значения (тип VARCHAR)
*/
INSERT INTO
    book (title, author, price, amount)
VALUES
       ("Мастер и Маргарита", "Булгаков М.А.", 670.99, 3);

/*
Задание
Занесите три последние записи в таблицуbook,
первая запись уже добавлена на предыдущем шаге
*/
INSERT INTO
    book(title, author, price, amount)
VALUES
    ('Белая гвардия', 'Булгаков М.А.', 540.50, 5),
    ('Идиот', 'Достоевский Ф.М.', 460.00, 10),
    ('Братья Карамазовы', 'Достоевский Ф.М.', 799.01, 2);
