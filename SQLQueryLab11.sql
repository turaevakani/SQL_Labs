--declare @a int = 10, @b int = 15, @c  int =0
--Если @c >= 0 то вычислить сумму чисел, иначе откат транзакции   

BEGIN TRANSACTION
DECLARE @a int, @b int, @c int;
SET @a = 10;
SET @b = 15;
SET @c = 0;
IF @c >= 0
BEGIN
  DECLARE @sum int = @a + @b + @c
  PRINT 'The sum: ' + CAST(@sum AS VARCHAR)
END
ELSE
BEGIN
  ROLLBACK TRANSACTION
  PRINT 'transaction rollback'
END

COMMIT TRANSACTION

--Вставить данные в таблицу клиентов, если не заполнена фамилия клиента – откат транзакции
USE Shop
BEGIN TRANSACTION

DECLARE @fam NVARCHAR(50) = 'Akyl'
DECLARE @imya NVARCHAR(50) = 'Bolsunbekov'
DECLARE @otch NVARCHAR(50) = 'Bolsunbekovich'  
DECLARE @pasword NVARCHAR(50) = '2688888'
DECLARE @mesto_raboty NVARCHAR = 'Inai'
DECLARE @skidka NVARCHAR = '3%'
DECLARE @id_tip_klienta INT = 1
DECLARE @id_rayon INT = 2

IF LEN(@fam) > 0
BEGIN
  INSERT INTO klient 
  VALUES (@fam, @imya, @otch, @pasword, @mesto_raboty, @skidka, @id_tip_klienta, @id_rayon)
  SELECT SCOPE_IDENTITY() AS id_sotrudnik
END
ELSE
BEGIN
  ROLLBACK TRANSACTION
  PRINT 'transaction rollback'
END

COMMIT TRANSACTION

--Вставить данные в таблицу заказов, если есть задолженность по предыдущим заказам, откатить транзакцию 
USE Shop
BEGIN TRANSACTION

DECLARE @id_dolg INT = 4 
DECLARE @cena DECIMAL(10, 2) = 100.00 
DECLARE @id_tovara INT = 2

IF EXISTS (
  SELECT 1 FROM price_list WHERE id_price_list = @id_dolg AND cena > 0
)
BEGIN
  ROLLBACK TRANSACTION
  PRINT 'transaction rollback'
END
ELSE
BEGIN
  
  INSERT INTO price_list(id_price_list, dataa, cena, id_tovara)
  VALUES (@id_dolg, GETDATE(), @cena, @comm, @id_tov)

  SELECT SCOPE_IDENTITY() AS NewOrderId 
END

COMMIT TRANSACTION

--Выполнить индивидуальное задание по транзакциям 
USE Shop
BEGIN TRANSACTION;

UPDATE rayu
SET rayon = 'pervomayskiy'
WHERE id_rayon = 1;

COMMIT TRANSACTION;
