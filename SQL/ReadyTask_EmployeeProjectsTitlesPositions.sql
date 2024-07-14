/* Исходные данные: есть таблицы employee, projects, titles и positions с соответствующим набором полей.
Структура таблиц и значения полей указаны ниже */

CREATE DATABASE team;
USE team;

CREATE table employee (
employee_id INT PRIMARY KEY NOT NULL,
first_name VARCHAR(15) NOT NULL,
last_name VARCHAR(15) NOT NULL);
INSERT INTO employee (employee_id, first_name, last_name) VALUES
(1, 'John', 'Filan'),
(2, 'Adam', 'Scolan'),
(3, 'Lisa', 'McCafety');

CREATE table projects (
project_id INT PRIMARY KEY NOT NULL,
project_name VARCHAR(15) NOT NULL);
INSERT INTO projects (project_id, project_name) VALUES
(1, 'ПУМЧД'),
(2, 'КРАНЧ'),
(3, 'СКРУДЖ');

CREATE table titles (
Id INT PRIMARY KEY NOT NULL,
titel_name VARCHAR(15) NOT NULL);
INSERT INTO titles (Id, titel_name) VALUES
(1, 'admin'),
(2, 'lead'),
(3, 'test');

CREATE table positions (
Id INT PRIMARY KEY NOT NULL,
employee_id INT NOT NULL,
project_id INT NOT NULL,
title_id INT NOT NULL,
salary INT NOT NULL);
INSERT INTO positions (Id, employee_id, project_id, title_id, salary) VALUES
(1, 1, 2, 1, 650),
(2, 3, 3, 2, 800),
(3, 2, 1, 3, 700);

/* Вывести среднюю заработную плату всех тестировщиков на проекте “ПУМЧД”.
Ответ должен содержать столбцы: Название проекта, Название должности, Средняя заработная плата. */
SELECT projects.project_name AS 'Название проекта',
titles.titel_name AS 'Название должности',
AVG(positions.salary) AS 'Средняя заработная плата' FROM positions
JOIN employee ON positions.employee_id = employee.employee_id
JOIN projects ON positions.project_id = projects.project_id
JOIN titles ON positions.title_id = titles.Id
WHERE projects.project_name = 'ПУМЧД' AND titles.titel_name LIKE '%test%'
GROUP BY projects.project_name, titles.titel_name;

/* Вывести всех работников, которые работают сразу на нескольких проектах.
Ответ должен содержать следующие столбцы: Имя и фамилия сотрудника, Название должности. */
SELECT CONCAT(employee.first_name, ' ', employee.last_name) AS 'Имя и фамилия сотрудника',
titles.titel_name AS 'Название должности' FROM positions
JOIN employee ON positions.employee_id = employee.employee_id
JOIN titles ON positions.title_id = titles.Id
GROUP BY employee.first_name, employee.last_name, titles.titel_name
HAVING COUNT(positions.project_id) > 1;

