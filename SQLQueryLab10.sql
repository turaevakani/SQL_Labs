
CREATE TRIGGER Kontaky_UPDATE
ON kontakty
AFTER UPDATE
AS
INSERT INTO tip_kontaktov(id_tip_kontaktov, tip_kontaktov)
SELECT id_kontakty, '������ ' + id_klient + ' ��� �������� ' + id_tip_kontaktov + ' ������� ' + kontakty
FROM INSERTED

INSERT INTO kontakty VALUES(1, 1, '0705264895')
UPDATE kontakty SET id_klient='Kani'
WHERE id_klient=1

SELECT * FROM tip_kontaktov