/* Исходные данные: есть 3 таблицы Deposits, Status и Clients с соответствующим набором полей.
Структура таблиц и значения полей указаны ниже */

CREATE DATABASE bank_manager;
USE bank_manager;

CREATE TABLE Deposits (id SERIAL PRIMARY KEY, ClientID INT NOT NULL, AccountID BIGINT NOT NULL, Currency VARCHAR(5) NOT NULL, Saldo DECIMAL(10,2), StatusID INT NOT NULL);
INSERT INTO Deposits (ClientID, AccountID, Currency, Saldo, StatusID) VALUES
('65743', '1354686498', 'RUB', '0', '11255'),
('63522', '7319797999', 'EUR', '14.5', '11255'),
('43532', '165489952', 'USD', '2164.89', '11255'),
('65674', '4687954697', 'USD', '114.0', '11258'),
('63522', '1133547879', 'RUB', '0', '11255'),
('56889', '265985499', 'EUR', '447.54', '11255'),
('65674', '3565659988', 'RUB', '0', '32565'),
('65743', '7489415891', 'USD', '57.4', '11255'),
('43532', '1564898811', 'RUB', '25574.84', '11255'),
('63522', '2645988554', 'USD', '0', '32565'),
('43532', '2123659887', 'RUB', '125484.89', '11255'),
('43532', '3125477787', 'EUR', '66.95', '11255');

CREATE TABLE Status (StatusID INT NOT NULL, StatusName VARCHAR(15) NOT NULL, StatusCode VARCHAR(15));
INSERT INTO Status (StatusID, StatusName, StatusCode) VALUES
('556', 'В ожидании', 'PENDING'),
('11255', 'Работает', 'WORK'),
('11258', 'Заблокирован', 'BLOCKED'),
('30005', 'Арестован', 'ARREST'),
('32565', 'Закрыт', 'CLOSED');

CREATE TABLE Clients (ClientID INT,	ClientType VARCHAR(5), ClientName VARCHAR(25));
INSERT INTO Clients (ClientID,	ClientType,	ClientName) VALUES
('155', 'PRIV', 'Иванов Иван Иваныч'),
('225', 'PRIV', 'Иванов Петр Сидорович'),
('226', 'ORG', 'ООО "Иванов"'),
('358', 'PRIV', 'Петров Иван Иваныч'),
('598', 'ORG', 'ИП Сидоров И.П.'),
('973', 'PRIV', 'Сидоров Иван Петрович');

/* Написать запрос, выводящий количество работающих счетов (депозитов) с остатком более 0 по каждому клиенту.
Вывести следующие колонки: ФИО клиента, Рубли, Доллары, Евро. */
SELECT ClientName AS 'ФИО клиента',
SUM(CASE WHEN Deposits.Currency = 'RUB' AND Deposits.Saldo > 0 THEN 1 ELSE 0 END) AS 'Рубли',
SUM(CASE WHEN Deposits.Currency = 'USD' AND Deposits.Saldo > 0 THEN 1 ELSE 0 END) AS 'Доллары',
SUM(CASE WHEN Deposits.Currency = 'EUR' AND Deposits.Saldo > 0 THEN 1 ELSE 0 END) AS 'Евро' FROM Deposits
LEFT JOIN Status ON Deposits.StatusID = Status.StatusID
LEFT JOIN Clients ON Deposits.ClientID = Clients.ClientID
WHERE Status.StatusCode = 'WORK' AND Deposits.Saldo > 0
GROUP BY Clients.ClientName;