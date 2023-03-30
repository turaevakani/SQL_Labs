
--Написать триггеры (before, after, instead of DML) для любой таблицы в базе данных и проверить эффекты работы

CREATE TRIGGER trg_kontakty_insert
ON kontakty
INSTEAD OF INSERT
AS
BEGIN
  IF EXISTS (SELECT * FROM inserted WHERE kontakty = '')
  BEGIN
    RAISERROR ('Insertion of a kontakts with an empty value is not allowed.', 1, 1)
    ROLLBACK TRANSACTION
  END
END;
GO
