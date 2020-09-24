USE clinic;


/*Представлении для определения результов доктора за месяц*/
CREATE OR REPLACE VIEW doctor_results AS
(SELECT sch.doctor_id as doctor, SUM(p.total) as result_sum, COUNT(r.id) as busy_hour, COUNT(sch.id) as work_hour
FROM clinic.payments p
JOIN registration r on r.id = p.registration_id 
RIGHT JOIN doc_schedule sch on sch.id = r.schedule_id
GROUP BY doctor);

select * from doctor_results;

/*Контакты задолжавших пациентов*/
CREATE OR REPLACE VIEW pacient_debt AS
(SELECT CONCAT(u.firstname,' ',u.lastname) pacient, u.phone phonenumber, SUM(p.total) debt_sum
from users u
join registration r on r.pacient_id = u.id
join appointment a on a.registration_id = r.id 
join payments p on p.registration_id  = r.id and is_pay = FALSE 
GROUP BY u.id
ORDER BY debt_sum DESC);

select * from pacient_debt;

-- медицинская карта клиента
SET @id = 6;

SELECT u.firstname, u.lastname, s.name , a.body 
from appointment a
join registration r on a.registration_id = r.id
join services s on r.service_id = s.id
join users u on u.id = r.pacient_id
where pacient_id = @id ORDER BY a.created_at;

-- общее расписание
SELECT CONCAT (d.firstname,' ',d.lastname) doctor, 
sch.date_app date, 
s.name service, 
CONCAT(u.firstname,' ',u.lastname) pacient, 
CASE WHEN r.prev_id IS NULL then 'первичный'
ELSE prev_id END status
FROM doctors d
JOIN doc_schedule dsch on dsch.doctor_id = d.id
JOIN schedule sch on dsch.date_id = sch.id
LEFT JOIN registration r on r.schedule_id = dsch.id 
LEFT JOIN services s on s.id = r.service_id
LEFT JOIN users u on u.id = r.pacient_id;

-- свободно на услугу (время-врач) 
SET @service = 3;

SELECT date_app, d.firstname, d.lastname
FROM clinic.schedule sch
JOIN doc_schedule ds on (sch.id = ds.date_id and ds.is_free = true)
join doctors d on d.id = ds.doctor_id
join doctors_services dser on dser.doctor_id = d.id
WHERE (sch.date_app between '2020-09-03' and '2020-09-07') and dser.service_id = @service;

