USE Shop
/*Создать хранимые процедуры для выборки данных (Поставки):*/
/*⦁	Список поставки за период  по товарам */
SELECT * 
FROM spisok_postavki
WHERE id_spisok_postavki in (SELECT id_spisok_postavki FROM spisok_tovarov WHERE id_tovar in (SELECT id_tovar FROM tovar WHERE id_tovar in 
(SELECT id_tovar FROM price_list WHERE data = '2022-06-24')))

/*⦁	Список товаров поставленных по поставщику*/
SELECT *
FROM spisok_tovarov
WHERE id_spisok_postavki in (SELECT id_spisok_postavki FROM spisok_postavki WHERE id_postavki in (SELECT id_postavki FROM postavki
WHERE id_postavshik in (SELECT id_postavshik FROM postavshik WHERE fam = 'Robert')))


/*⦁	Список товаров поставленных по типу товара*/
SELECT *
FROM spisok_postavki
WHERE id_spisok_postavki in (SELECT id_spisok_postavki FROM spisok_tovarov WHERE id_tovar in (SELECT id_tovar FROM tovar WHERE tovar = 'Avocado'))


/*⦁	Поставки по товарам за период*/
SELECT *
FROM postavki
WHERE id_postavki in (SELECT id_postavki FROM spisok_postavki WHERE id_spisok_postavki in (SELECT id_spisok_postavki FROM spisok_tovarov WHERE id_tovar in (SELECT id_tovar FROM tovar WHERE tovar = 'Pants')) )


/*⦁	Изменение цен на товары, поставленные за период*/
UPDATE price_list SET cena = 95
WHERE data >= '2022-09-01' and data <= '2022-12-31';


/*⦁	Оплата по поставкам (журнал) за период*/
SELECT *
FROM oplata
WHERE id_zakaz in (SELECT id_zakaz FROM zakaz WHERE id_zakaz in (SELECT id_zakaz FROM spisok_tovarov WHERE id_spisok_postavki IN (
SELECT id_spisok_postavki FROM spisok_postavki WHERE id_postavki in (SELECT id_postavki FROM postavki WHERE data BETWEEN ('2022-08-20')and('2022-11-24')))))




/*Создать хранимые процедуры для выборки данных (Продажи):*/
/*⦁	Заказы по типу продаж за период*/
DECLARE @id_zaka INT

SELECT @id_zaka = id_zakaz 
FROM zakaz
WHERE id_sostoyanie	= (SELECT id_sostoyanie FROM sostoyanie WHERE sostoyanie = 'inactive') and data >= '2023-02-11' and data <= '2023-02-13'

SELECT id_tovar, kol_vo
FROM spisok_tovarov
WHERE id_zakaz = @id_zaka


/*⦁	Заказы клиента за период*/
SELECT *
FROM zakaz
WHERE id_klient in (SELECT id_klient FROM klient WHERE id_klient = 1) and data BETWEEN ('2022-08-11')and('2022-09-21')


/*⦁	Изменение цен на товары, поставленные за период*/
UPDATE price_list SET cena = 890
WHERE data >= '2022-09-01' and data <= '2022-12-01';


/*⦁	Актуальный прайс-лист*/
SELECT *
FROM price_list;


/*⦁	Оплата по продажам (журнал) за период*/
SELECT id_oplata, summa, id_zakaz
FROM oplata
WHERE data >= '2022-07-15' and data <= '2022-08-30'


/*⦁	Оплата по виду оплаты за период*/
SELECT summa
FROM oplata
WHERE id_vid_oplaty = (SELECT id_vid_oplaty from vid_oplaty WHERE vid_oplaty = 'nalichnye') and data >= '2022-09-01' and data <= '2022-11-25'


/*⦁	Продажи по сотрудникам статистика*/
SELECT *
FROM zakaz
WHERE id_sotrudnik  = 1


/*⦁	Продажи по району за период*/
SELECT *
FROM zakaz
WHERE id_klient in (SELECT id_klient FROM klient WHERE id_rayon in (SELECT id_rayon FROM rayon WHERE rayon = 'suzakskiy'))


/*⦁	Контакты клиентов*/
SELECT kontakty
FROM kontakty
WHERE id_klient = (SELECT id_klient FROM klient WHERE id_klient = 2)


/*⦁	Заказы по типу продаж за период*/
SELECT id_zakaz, id_tip_prodaj
FROM zakaz


/*⦁	Заказы по типу заказа за период*/
SELECT id_zakaz, id_tip_zakaza
FROM zakaz


/*⦁	Остаток товара за период (в одной выборке отразить поставки и продажи)*/
DECLARE @id_kol INT
SELECT @id_kol = kol_vo
FROM spisok_tovarov
WHERE id_spisok_postavki = 3;

DECLARE @id_koll INT
SELECT @id_koll = kol_vo
FROM spisok_postavki
WHERE id_spisok_postavki = 3;

print (@id_koll - @id_kol) 
