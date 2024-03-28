
-- let's check our data base
SELECT *
FROM client;


-- can delete smth, that you want
DELETE *
FROM client
WHERE adress == 'Америка';


-- let's go to latin alphabet
UPDATE client 
SET adress =
    CASE 
        WHEN adress = 'Москва' THEN 'Moscow'
        WHEN adress = 'Санкт-Петербург' THEN 'Saint Petersburg'
        WHEN adress = 'Новосибирск' THEN 'Novosibirsk'
        WHEN adress = 'Екатеринбург' THEN 'Yekaterinburg'
        WHEN adress = 'Казань' THEN 'Kazan'
        WHEN adress = 'Ростов-на-Дону' THEN 'Rostov-on-Don'
        WHEN adress = 'Волгоград' THEN 'Volgograd'
        WHEN adress = 'Нижний Новгород' THEN 'Nizhny Novgorod'
        WHEN adress = 'Челябинск' THEN 'Chelyabinsk'
        WHEN adress = 'Уфа' THEN 'Ufa'
        ELSE adress
    END;


-- Повторю инфу из README, много запросов INSERT в point_4
-- Больше SELECTов будет в point_6
