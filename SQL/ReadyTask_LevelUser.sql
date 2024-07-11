/* Исходные данные: есть 2 таблицы user и level с соответствующим набором полей. Структура таблиц и значения полей указаны ниже */
CREATE database Users;
USE Users;

CREATE table User (id SERIAL PRIMARY KEY, user_name VARCHAR(8), level_id INT, skill INT);
INSERT INTO User (user_name, level_id, skill) VALUES
('Anton', '1', '900000'),
('Denis', '3', '4000'),
('Petr', '2', '50000'),
('Andrey', '4', '20'),
('Olga', '1', '600000'),
('Anna', '1', '1600000');

CREATE table Level (id SERIAL PRIMARY KEY, level_name VARCHAR(10));
INSERT INTO Level (level_name) VALUES
('admin'),
('power_user'),
('user'),
('guest');
Select * from Level;

-- 1.Отобрать из таблицы user всех пользователей, у которых level_id = 1, skill > 799000 и в имени встречается буква 'а'
SELECT user_name FROM User WHERE (level_id = 1 OR skill > 799000) AND user_name LIKE '%a%';

-- 2.Удалить всех пользователей, у которых skill меньше 100000
SET SQL_SAFE_UPDATES = 0;
DELETE FROM User WHERE skill < 100000;
SET SQL_SAFE_UPDATES = 1;

-- 3.Вывести все данные из таблицы user в порядке убывания по полю skill
SELECT * FROM User ORDER BY skill DESC;

-- 4.Добавить в таблицу user нового пользователя по имени Oleg, с уровнем 4 и skill = 10
INSERT INTO User (user_name, level_id, skill) VALUES
('Oleg', '4', '10');

-- 5.Обновить данные в таблице user - для пользователей с level_id меньше 2 проставить skill 2000000
SET SQL_SAFE_UPDATES = 0;
UPDATE User SET User.skill = 2000000 WHERE User.level_id < 2;
SET SQL_SAFE_UPDATES = 1;

-- 6.Выбрать user_name всех пользователей уровня admin используя подзапрос
SELECT user_name FROM User WHERE id = (SELECT id FROM Level WHERE level_name = 'admin');

-- 7.Выбрать user_name всех пользователей уровня admin используя join
SELECT user_name FROM User LEFT JOIN Level ON User.id = Level.id WHERE Level.level_name = 'admin';
