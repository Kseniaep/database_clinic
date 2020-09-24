/*База данных медицинского центра. Содержит таблицы пациентов, врачей, услуг, расписание, записи, оплаты.*/

DROP DATABASE IF EXISTS clinic;
CREATE DATABASE clinic;
USE clinic;

-- основная таблица пациентов
DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    firstname VARCHAR(50),
    lastname VARCHAR(50) COMMENT 'Фамилия', 
    email VARCHAR(120) UNIQUE,
 	-- password_hash VARCHAR(100), -- для личного кабинета
	phone BIGINT UNSIGNED UNIQUE,
	created_at DATETIME DEFAULT NOW(),
	updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
	
    INDEX users_firstname_lastname_idx(firstname, lastname)
) CHARSET=cp1251 COMMENT 'пациенты';


INSERT INTO users (id, firstname, lastname, email, phone)
VALUES
('1', 'Елена', 'Зайцева', 'user596@example.org', 9152548521),
('2', 'Алексей', 'Волков', 'user597@example.org', 9995241385),
('3', 'Иван', 'Петров', 'user598@example.org', 8521245998),
('4', 'Сергей', 'Смолин', 'user599@example.org', 9265414457),
('5', 'Александр', 'Кротов', 'user600@example.org', 9215428545),
('6', 'Анна', 'Краснова', 'user601@example.org', 9635544121),
('7', 'Иван', 'Краснов', 'user602@example.org', 9165214412),
('8', 'Петр', 'Сухов', 'user603@example.org', 9824127485),
('9', 'Екатерина', 'Лебедева', 'user604@example.org', 9865231220),
('10', 'Геннадий', 'Лебедев', 'user605@example.org', 9254178322),
('11', NULL, NULL, 'romashka@romashka.org', 4951120102)
;

-- таблица профиля пациентов
DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles (
	user_id BIGINT UNSIGNED NOT NULL UNIQUE,
    gender CHAR(1),
    birthday DATE,
    insurance_number BIGINT UNSIGNED UNIQUE, -- номер страховки 7 цифр
    company_name VARCHAR(100), -- компания, где работает пациент, для подготовки больничных
    created_at DATETIME DEFAULT NOW(),
    IS_AGREE BIT NOT NULL, -- согласие на обработку перс.данных
	FOREIGN KEY (user_id) REFERENCES users(id) 
) CHARSET=cp1251;

INSERT INTO profiles (user_id, gender, birthday,  insurance_number, company_name,IS_AGREE)
VALUES
('1', 'f', '1990-08-02', '1521242', 'РОМАШКА ООО', true),
('2', 'm', '1979-08-02', '1521243', 'ОГОНЬ ОАО', true),
('3', 'm', '1984-10-02', '1521244', 'РОМАШКА ООО', true),
('4', 'm', '2008-06-12', '1521245', NULL, true),
('5', 'm', '1988-10-02', '1521246', 'РОМАШКА ООО', true),
('6', 'f', '1991-05-14', '1521247', 'АЛМАЗ ПАО', true),
('7', 'm', '1992-04-22', '1521248', 'РОМАШКА ООО', true),
('8', 'm', '1990-03-12', '1521249', 'РОМАШКА ООО', true),
('9', 'f', '1986-04-03', '1521250', 'БЕРЕГ ООО', true),
('10', 'm', '2005-01-11', '1521251', NULL, true)
;

-- врачи
DROP TABLE IF EXISTS doctors;
CREATE TABLE doctors (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    firstname VARCHAR(50),
    lastname VARCHAR(50) COMMENT 'Фамилия',    -- COMMENT на случай, если имя неочевидное
    speciality VARCHAR(50),
    category TINYINT UNSIGNED -- категория врача, высшая - 100

) CHARSET=cp1251 COMMENT 'врачи';

INSERT INTO doctors
VALUES
('1', 'Ирина', 'Архипова', 'терапевт', 1),
('2', 'Михаил', 'Баранов', 'невролог', 100),
('3', 'Ольга', 'Васина', 'хирург', 1),
('4', 'Анастасия', 'Глебова', 'терапевт', 100),
('5', 'Николай', 'Дядькин', 'эндокринолог', NULL)
;

-- записи на прием
DROP TABLE IF EXISTS registration;
CREATE TABLE registration(
	id SERIAL PRIMARY KEY, 
	prev_id BIGINT UNSIGNED, -- предыдущее посещение
	pacient_id BIGINT UNSIGNED NOT NULL,
    schedule_id BIGINT UNSIGNED NOT NULL,-- промежуток из расписания доктора
    created_at DATETIME DEFAULT NOW(),
    IS_CANCEL BIT DEFAULT FALSE, -- сделать убрать убираем
    IS_SUCEED BIT DEFAULT FALSE, -- прием состоялся  
    FOREIGN KEY (pacient_id) REFERENCES users(id) -- пока рано, т.к. таблицы media еще нет   
);

-- назначения, описание приема
DROP TABLE IF EXISTS appointments;
CREATE TABLE appointment(
	registration_id SERIAL,
    body text,
    -- filename VARCHAR(255),
    -- file blob,    	
    metadata JSON,
    created_at DATETIME DEFAULT NOW(),
    -- updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (registration_id) REFERENCES registration(id)
) CHARSET=cp1251 ;

ALTER TABLE clinic.registration
ADD CONSTRAINT reg_fk
FOREIGN KEY (prev_id) REFERENCES clinic.appointment(registration_id);

-- услуги, которые есть в центре
DROP TABLE IF EXISTS services;
CREATE TABLE services(
	id SERIAL PRIMARY KEY,
	name VARCHAR(150) UNIQUE NOT NULL,
	price DECIMAL(11,2) NOT NULL
	
	-- INDEX communities_name_idx(name), -- индексу можно давать свое имя (communities_name_idx)
)CHARSET=cp1251  ;

INSERT INTO services (name, price)
VALUES
	('Прием терапевта первой категории','2000.00'),
	('Прием терапевта высшей категории','3000.00'),
	('Профилактическая ЭКГ', '500.00'),
	('Прием невролога высшей категории','3500.00'),
	('Лекарственная блокада','2500.00'),
	('Прием хирурга первой категории','2500.00'),
	('Наложение хирургической повязки','2000.00'),
	('Снятие хирургической повязки','1000.00'),
	('Прием эндокринолога','2500.00')
;

-- добавляю услугу в таблицу записей на прием
ALTER TABLE registration ADD COLUMN service_id BIGINT UNSIGNED NOT NULL AFTER pacient_id;

ALTER TABLE registration
ADD CONSTRAINT reg_fk_service
FOREIGN KEY (service_id) REFERENCES services(id);

-- связь врачей с оказываемыми услугами
DROP TABLE IF EXISTS doctors_services;
CREATE TABLE doctors_services(
	doctor_id INT UNSIGNED NOT NULL,
	service_id BIGINT UNSIGNED NOT NULL,
  	PRIMARY KEY (doctor_id, service_id), -- чтобы не было 2 записей о враче и услуге
    FOREIGN KEY (doctor_id) REFERENCES doctors(id), 
    FOREIGN KEY (service_id) REFERENCES services(id)
) CHARSET=cp1251 ;

INSERT INTO doctors_services 
VALUES
	(1, 1),
	(1, 3),
	(2, 2),
	(2, 4),
	(2, 5),
	(3, 6),
	(3, 7),
	(3, 8),
	(4, 2),
	(4, 3),
	(5, 9)
;

-- счета есть в случае работы с клиентом через депозит или в кредит, может быть один для группы клиентов
DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (
  id SERIAL PRIMARY KEY,
  owner_id BIGINT UNSIGNED NOT NULL,
  deposit_sum DECIMAL (11,2) COMMENT 'Сумма на депозите',
  credit_sum DECIMAL (11,2), -- при работе с организацией в кредит
  discount TINYINT, -- unsigned
  --  total DECIMAL (11,2) COMMENT 'Общая сумма', нужна ли
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  , FOREIGN KEY (owner_id) REFERENCES users(id) 
  
) CHARSET=cp1251 COMMENT = 'Счета';


-- в таблице пациентов будет отражен привязанный счет, если есть
ALTER TABLE users ADD COLUMN account_id BIGINT UNSIGNED NOT NULL;
ALTER TABLE payments ALTER account_id SET DEFAULT 0;

SET FOREIGN_KEY_CHECKS=0;

ALTER TABLE users
ADD CONSTRAINT users_fk
FOREIGN KEY (account_id) REFERENCES accounts(id);

SET FOREIGN_KEY_CHECKS=1;

INSERT INTO accounts (owner_id, deposit_sum, credit_sum, discount)
VALUES 
 ('2', '10000.00', NULL, '10'),
 ('11', NULL, '72000.00', '15')
 ;

-- Заполняю колонку счетов в таблце пациентов
UPDATE users
JOIN profiles ON users.id = profiles.user_id
SET 
	users.account_id = 2
WHERE
	profiles.company_name = 'РОМАШКА ООО'
;

UPDATE users
SET 
	account_id = 2
WHERE
	id = 6
;

UPDATE users
SET 
	account_id = 1
WHERE
	id in(9, 10)
;
    
-- чек за посещение
DROP TABLE IF EXISTS payments;
CREATE TABLE payments (
  id SERIAL PRIMARY KEY,
  registration_id BIGINT UNSIGNED NOT NULL,
  account_id BIGINT UNSIGNED,
  pay_method ENUM('cash', 'credit', 'deposit') NOT NULL, -- способ оплаты через кредитный/депозитный счет или наличными
  total DECIMAL (11,2) NOT NULL, -- изменить на int
  IS_PAY BIT DEFAULT FALSE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (account_id) REFERENCES accounts(id),
  FOREIGN KEY (registration_id) REFERENCES registration(id)
) COMMENT = 'Чек';

ALTER TABLE payments ALTER pay_method SET DEFAULT 'cash';


-- таблица для генерации расписания на ближайшие 10 дней
DROP TABLE IF EXISTS days;
CREATE TABLE days(
	adding INT);

INSERT INTO days VALUES (0), (1), (2), (3), (4), (5), (6), (7), (8), (9);

-- таблица для генерации временных промежутков приема
DROP TABLE IF EXISTS times;
CREATE TABLE times(
workhours INT
);


INSERT INTO times VALUES (9), (10), (11), (12), (13), (14), (15), (16), (17), (18), (19);

-- таблица с расписанием центра
DROP TABLE IF EXISTS schedule;
CREATE TABLE schedule(
	id SERIAL PRIMARY KEY,
    date_app DATETIME
);


CALL insert_schedule('2020-09-01');
SET @start = (select max(DATE(date_app)) + INTERVAL 1 DAY from schedule);
select @start; -- для заполнения следующих периодов

-- рабочее расписание врачей
DROP TABLE IF EXISTS doc_schedule;
CREATE TABLE doc_schedule(
	id SERIAL PRIMARY KEY,
    doctor_id INT UNSIGNED NOT NULL,
    date_id BIGINT UNSIGNED NOT NULL,
    IS_FREE BIT DEFAULT TRUE 
    , FOREIGN KEY (doctor_id) REFERENCES doctors(id) 
    , FOREIGN KEY (date_id) REFERENCES schedule(id) 
);



INSERT INTO doc_schedule (doctor_id, date_id)
VALUES (1, 1), (1,2), (1,3), (1,4), (1,5), (1,6), (1,7), (1,8), (1,9), (1, 10), (1,11), 
	   (1, 56), (1,57), (1,58), (1,59), (1,60), (1,61), (1,62), (1,63), (1, 64), (1,65), (1,66), 
	   (2,12), (2,13), (2,14), (2,15), (2,16), (2,17), (2,18), (2,19), (2,20), (2,21), (2,22),
	   (2,67), (2,68), (2,69), (2,70), (2,71), (2,72), (2,73), (2,74), (2,75), (2,76), (2,77),
	   (3,23), (3,24), (3,25), (3,26), (3,27), (3,28), (3,29), (3,30), (3,31), (3,32), (3,33),
	   (3,78), (3,79), (3,80), (3,81), (3,82), (3,83), (3,84), (3,85), (3,86), (3,87), (3,88),  
	   (4,34), (4,35), (4,36), (4,37), (4,38), (4,39), (4,40), (4,41), (4,42), (4,43), (4,44), 	   
	   (4,89), (4,90), (4,91), (4,92), (4,93), (4,94), (4,95), (4,96), (4,97), (4,98), (4,99), 	   
	   (5,45), (5,46), (5,47), (5,48), (5,49), (5,50), (5,51), (5,52), (5,53), (5,54), (5,55), 	
	   (5,100), (5,101), (5,102), (5,103), (5,104), (5,105), (5,106), (5,107), (5,108), (5,109), (5,110);
	  
ALTER TABLE clinic.registration
ADD CONSTRAINT reg_fk_1
FOREIGN KEY (schedule_id) REFERENCES clinic.doc_schedule(id);


CALL insert_registration(1, 57, 1, NULL,@tran_result);
select @tran_result;
CALL insert_registration(3, 38, 2, NULL,@tran_result);
select @tran_result;
CALL insert_registration(6, 14, 4, NULL,@tran_result);
select @tran_result;
CALL insert_registration(2, 4, 3, NULL,@tran_result);
select @tran_result;
CALL insert_registration(4, 102, 9, NULL,@tran_result);
select @tran_result;
CALL insert_registration(5, 14, 5, NULL,@tran_result);
select @tran_result; -- Error occured. Code: 45000. Text: INSERT canceled. Time is busy.
CALL insert_registration(5, 15, 9, NULL,@tran_result);
select @tran_result; -- Service isnt available for this doctor

select * from doc_schedule ds where id in (1,4, 14, 15, 57, 38, 102); -- проверяем, что IS_FREE изменилось
select * from registration;

UPDATE registration 
SET schedule_id = 103
where id = 5;

select * from doc_schedule ds where id in (101,102,103); -- проверяем, что промежуток 102 теперь свободен, а 103 занят

DELETE FROM registration 
where id = 3;

select * from doc_schedule ds where id = 14; -- после удаления регистрации время стало свободно для записи

CALL insert_registration(6, 14, 4, NULL,@tran_result);
select @tran_result;
CALL insert_registration(5, 15, 5, NULL,@tran_result);
select @tran_result;
CALL insert_registration(10, 70, 4, NULL,@tran_result);
select @tran_result;
CALL insert_registration(10, 77, 4, NULL,@tran_result);
select @tran_result;
CALL insert_registration(6, 73, 4, 6 ,@tran_result);
select @tran_result;
CALL insert_registration(6, 74, 4, 6 ,@tran_result);
select @tran_result;

CALL new_appointment(1, 'hdhhljjljhhkj.fjghjghhg.jgjchfxgxgh.gjfjhgjkhkgfvchch', @tran_result);
select @tran_result;
select * from payments; -- добавлен новый чек для оплаты

CALL new_appointment(4, 'hdhhljjljhhkj.fjghjghhg.jgjchfxgxgh.gjfjhgjkhkgfvchch', @tran_result);
select @tran_result;
CALL new_appointment(5, 'hdhhljjljhhkj.fjghjghhg.jgjchfxgxgh.gjfjhgjkhkgfvchch', @tran_result);
select @tran_result;
CALL new_appointment(6, 'hdhhljjljhhkj.fjghjghhg.jgjchfxgxgh.gjfjhgjkhkgfvchch', @tran_result);
select @tran_result;
CALL new_appointment(9, 'hdhhljjljhhkj.fjghjghhg.jgjchfxgxgh.gjfjhgjkhkgfvchch', @tran_result);
select @tran_result;
CALL new_appointment(10, 'hdhhljjljhhkj.fjghjghhg.jgjchfxgxgh.gjfjhgjkhkgfvchch', @tran_result);
select @tran_result;
CALL new_appointment(11, 'hdhhljjljhhkj.fjghjghhg.jgjchfxgxgh.gjfjhgjkhkgfvchch', @tran_result);
select @tran_result;

select id, IS_SUCEED from registration; -- проверяем, что есть отметка о состоявшихся приемах

CALL get_check(2, 2, 'cash',@tran_result); 
select @tran_result;
CALL get_check(4, null, 'cash',@tran_result); 
select @tran_result;

-- в идеале будет заполняться через процедуру
UPDATE payments p
SET account_id = 2
WHERE registration_id in (1,6,10,11);
UPDATE payments p
SET account_id = 2
WHERE registration_id = 8;


UPDATE payments 
SET pay_method = 'deposit'
where id = 5; -- проверяем, что недоступно для этого клиента

UPDATE payments 
SET pay_method = 'deposit'
where id = 8; 

UPDATE payments 
SET pay_method = 'credit'
where id = 5; 

CALL get_check(8, 1, 'deposit',@tran_result); 
select @tran_result;

CALL get_check(5, 2, 'credit',@tran_result); 
select @tran_result;

select id, IS_PAY from payments; -- проверяем, что часть платежей оплачена

-- проверяем, что сумма кредитного счета увеличилась, депозитного уменьшилась
SELECT a.id,a.credit_sum, a.deposit_sum, p.total from accounts a join payments p on p.account_id = a.id where p.id in(5,8); 




