/* Процедура генерирует расписание на ближайшие 10 дней с заданной даты*/
CREATE DEFINER=`root`@`localhost` PROCEDURE `clinic`.`insert_schedule`(start_date DATETIME)
BEGIN
	INSERT INTO clinic.schedule(date_app)
	SELECT 
		DATE(start_date) + INTERVAL t.workhours HOUR + INTERVAL d.adding DAY as sc_day
	FROM times t
	JOIN days d
	ORDER BY sc_day;
END

/*Процедура, добавляет регистрацию на прием, устанавливает в распиании доктора, что промежуток занят*/
CREATE DEFINER=`root`@`localhost` PROCEDURE `clinic`.`insert_registration`(pacient_id BIGINT, 
schedule_id BIGINT,service_id BIGINT, prev_id BIGINT, OUT tran_result varchar(200))
BEGIN
	DECLARE `_rollback` BOOL DEFAULT 0;
   	DECLARE code varchar(100);
   	DECLARE error_string varchar(100);

   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   begin
	   SET `_rollback` = 1;
	GET stacked DIAGNOSTICS CONDITION 1
          code = RETURNED_SQLSTATE, error_string = MESSAGE_TEXT;
    	set tran_result := concat('Error occured. Code: ', code, '. Text: ', error_string);
    end;
   
   	IF EXISTS (select * from doctors_services ds join doc_schedule sch on (ds.doctor_id = sch.doctor_id 
   			and sch.date_id = schedule_id) 
   				where ds.service_id = service_id) THEN
    START TRANSACTION;
		INSERT INTO registration(prev_id, pacient_id, schedule_id, service_id)
		  VALUES (prev_id, pacient_id, schedule_id, service_id);
	
		UPDATE doc_schedule
		SET IS_FREE = FALSE 
		WHERE doc_schedule.id = schedule_id;
	
	    IF `_rollback` THEN
	       ROLLBACK;
	    ELSE
		set tran_result := 'ok';
	       COMMIT;
	    END IF;
	  ELSE set tran_result := 'Service isnt available for this doctor';
	 END IF;
END
/* Триггер на проверку, что время для записи свободно при вставке новой записи и обнолвении */
CREATE DEFINER=`root`@`localhost` TRIGGER insert_registration
BEFORE INSERT
ON registration FOR EACH ROW
BEGIN
DECLARE check_free BIT;
SELECT IS_FREE INTO check_free FROM doc_schedule ds WHERE ds.id = NEW.schedule_id;
	IF check_free = FALSE THEN 
  		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INSERT canceled. Time is busy.';
	END IF;
END

CREATE DEFINER=`root`@`localhost` TRIGGER update_registration
BEFORE UPDATE
ON registration FOR EACH ROW
BEGIN
DECLARE check_free BIT;
SELECT IS_FREE INTO check_free FROM doc_schedule ds WHERE ds.id = NEW.schedule_id;
	IF (check_free = FALSE) and (NEW.schedule_id <> OLD.schedule_id) THEN 
  		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Update canceled. Time is busy.';
	END IF;
END

/*При обновлении времени записи изменить доступность времени у доктора*/
CREATE DEFINER=`root`@`localhost` TRIGGER update_change_free
AFTER UPDATE
ON registration FOR EACH ROW
BEGIN
IF NEW.schedule_id <> OLD.schedule_id THEN 
  		UPDATE doc_schedule ds
  		SET IS_FREE = FALSE where ds.id = NEW.schedule_id;
  		UPDATE doc_schedule ds
  		SET IS_FREE = TRUE where ds.id = OLD.schedule_id;
	END IF;
END

/*При удалении записии освободить промежуток у доктора*/
CREATE DEFINER=`root`@`localhost` TRIGGER del_registration
AFTER DELETE
ON registration FOR EACH ROW
BEGIN
	UPDATE doc_schedule ds
  		SET IS_FREE = TRUE where ds.id = OLD.schedule_id;
END

/* Процедура для создания нового описания посещения. В таблице регистрации устанавливает, что регистрация прошла успешно. 
 Создается чек на оплату посещения*/
CREATE DEFINER=`root`@`localhost` PROCEDURE `clinic`.`new_appointment`(registration_id BIGINT, body TEXT,
OUT tran_result varchar(200))
BEGIN
	DECLARE `_rollback` BOOL DEFAULT 0;
   	DECLARE code varchar(100);
   	DECLARE error_string varchar(100);
    DECLARE total DECIMAL (11,2);
   	

   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   begin
	   SET `_rollback` = 1;
	GET stacked DIAGNOSTICS CONDITION 1
          code = RETURNED_SQLSTATE, error_string = MESSAGE_TEXT;
    	set tran_result := concat('Error occured. Code: ', code, '. Text: ', error_string);
    end;
   
   START TRANSACTION;
		INSERT INTO appointment(registration_id, body)
		  VALUES (registration_id, body);
		 
		SET total = (select price from services s join registration r on s.id = r.service_id where r.id = registration_id);
			
		INSERT INTO clinic.payments (registration_id, total, IS_PAY)
		VALUES (registration_id, total, false);
	
		UPDATE registration
		SET IS_SUCEED = TRUE
		WHERE registration.id = registration_id;
	
	    IF `_rollback` THEN
	       ROLLBACK;
	    ELSE
		set tran_result := 'ok';
	       COMMIT;
	    END IF;
END

/*Процедура для окончательного расчета с пациентом*/

CREATE DEFINER=`root`@`localhost` PROCEDURE `clinic`.`get_check`(id BIGINT, account_id BIGINT, pay_method CHAR(10),
 OUT tran_result varchar(200))
BEGIN
	DECLARE `_rollback` BOOL DEFAULT 0;
   	DECLARE code varchar(100);
   	DECLARE error_string varchar(100);
    DECLARE new_total DECIMAL (11,2);
    DECLARE discount TINYINT;
 
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   begin
	   SET `_rollback` = 1;
	GET stacked DIAGNOSTICS CONDITION 1
          code = RETURNED_SQLSTATE, error_string = MESSAGE_TEXT;
    	set tran_result := concat('Error occured. Code: ', code, '. Text: ', error_string);
    end;
   
   IF account_id = NULL or account_id = 0
   THEN 
	   UPDATE payments 
	   SET IS_PAY = TRUE WHERE payments.id = id;
	   SET tran_result := 'ok';
   ELSE
   
   SET discount = 0.01*(select discount from accounts a where a.id = account_id);
   SET new_total = round((select total*(1-@discount) from payments where payments.id = id),2);
  
   START TRANSACTION;
		UPDATE clinic.payments 
		SET total = new_total, IS_PAY = TRUE WHERE payments.id = id;
		
		IF pay_method = 'credit' THEN
		UPDATE clinic.accounts 
		JOIN payments on payments.account_id = accounts.id
		SET accounts.credit_sum = accounts.credit_sum + new_total WHERE payments.id = id; END IF;
		 
		IF pay_method = 'deposit' THEN
		UPDATE clinic.accounts 
		JOIN payments on payments.account_id = accounts.id
		SET accounts.deposit_sum = accounts.deposit_sum - new_total WHERE payments.id = id; END IF;
	
	COMMIT;
	END IF;

	    IF `_rollback` THEN
	       ROLLBACK;
	    ELSE
		set tran_result := 'ok';
	       COMMIT;
	    END IF;
END

/*Триггер на проверку, что при изменении метода оплаты клиент имеет подключение к счету*/
CREATE DEFINER=`root`@`localhost` TRIGGER update_method
BEFORE UPDATE
ON payments FOR EACH ROW
BEGIN 
	IF NEW.pay_method<>'cash' and NEW.account_id IS NULL THEN 
  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'UPDATE canceled. Method is able to account only';
 END IF;
END
