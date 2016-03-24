DROP USER IF EXISTS babylon;
CREATE USER babylon PASSWORD 'babylon' CONNECTION LIMIT 1;

DROP TABLE IF EXISTS Clients CASCADE;
DROP TABLE IF EXISTS Products CASCADE;
DROP TABLE IF EXISTS Orders CASCADE;
DROP TABLE IF EXISTS Suppliers CASCADE;
DROP TABLE IF EXISTS ProductUnits CASCADE;

CREATE TABLE Clients (
	ClientId uuid PRIMARY KEY NOT NULL,
	Name varchar,
	Address varchar,
	Chief varchar,
	CheckingAccount varchar,
	City varchar,
	INN varchar,
	OKONH varchar,
	OKPO varchar,
	SupplierId uuid NULL
);
COMMENT ON TABLE Clients IS 'Pokupateli - Покупатели';
COMMENT ON COLUMN Clients.ClientId IS 'Kod - Уникальный идентификатор клиента';
COMMENT ON COLUMN Clients.Name IS 'Imya - Имя покупателя';
COMMENT ON COLUMN Clients.Address IS 'Address - Адрес покупателя';
COMMENT ON COLUMN Clients.Chief IS 'FamRuk - Фамилия руководителя';
COMMENT ON COLUMN Clients.CheckingAccount IS 'RasStchot - Расчетный счет';
COMMENT ON COLUMN Clients.City IS 'Gorod - город';
COMMENT ON COLUMN Clients.INN IS 'INN - Индивидуальный налоговый номер';
COMMENT ON COLUMN Clients.OKONH IS 'KodOKOHX - Общероссийский классификатор "Отрасли народного хозяйства"';
COMMENT ON COLUMN Clients.OKPO IS 'KodOKPO - Общероссийский классификатор предприятий и организаций';
COMMENT ON COLUMN Clients.SupplierId IS 'KodPostavshika - Код поставщика';

CREATE TABLE Products (
	ProductId uuid PRIMARY KEY NOT NULL,
	Unit varchar,
	Cost integer,
	Name varchar,
	Quantity integer
);
COMMENT ON TABLE Products IS 'TovarNaBase - Товар на базе';
COMMENT ON COLUMN Products.ProductId IS 'PNT - Уникальный идентификатор товара';
COMMENT ON COLUMN Products.Unit IS 'EdIzmer - Единица измерения';
COMMENT ON COLUMN Products.Cost IS 'Tsena - Цена за единицу';
COMMENT ON COLUMN Products.Name IS 'ImyaTovar - Наименование товара';
COMMENT ON COLUMN Products.Quantity IS 'Ostatok - Количество товара на складе';

CREATE TABLE Orders (
	OrderId uuid PRIMARY KEY NOT NULL,
	ClientId uuid,
	OrderDate date,
	ProductId uuid,
	Quantity integer
);
COMMENT ON TABLE Orders IS 'ZakazNaTovary - Заказы на товар';
COMMENT ON COLUMN Orders.OrderId IS 'Nomer - Уникальный идентификатор товара';
COMMENT ON COLUMN Orders.ClientId IS 'KodPokupatelya - Код покупателя';
COMMENT ON COLUMN Orders.OrderDate IS 'DataZakaza - Дата оформления заказа';
COMMENT ON COLUMN Orders.ProductId IS 'PNT - Код товара';
COMMENT ON COLUMN Orders.Quantity IS 'Kolich - Количество товара в заказе';

CREATE TABLE Suppliers (
	SupplierId uuid PRIMARY KEY NOT NULL,
	Name varchar,
	Address varchar,
	CheckingAccount varchar,
	City varchar,
	INN varchar,
	OKONH varchar,
	OKPO varchar
);
COMMENT ON TABLE Suppliers IS 'Postavshiki - Поставщики';
COMMENT ON COLUMN Suppliers.SupplierId IS 'Kod - Уникальный идентификатор поставщика';
COMMENT ON COLUMN Suppliers.Name IS 'Поставщик - Наименование поставщика';
COMMENT ON COLUMN Suppliers.Address IS 'Адрес - Адрес поставщика';
COMMENT ON COLUMN Suppliers.CheckingAccount IS 'Расчётный счёт - Расчетный счет поставщика';
COMMENT ON COLUMN Suppliers.City IS 'Город - Город поставщика';
COMMENT ON COLUMN Suppliers.INN IS 'ИНН пост - Индивидуальный налоговый номер';
COMMENT ON COLUMN Suppliers.OKONH IS 'Код по ОКОНХ - Общероссийский классификатор "Отрасли народного хозяйства"';
COMMENT ON COLUMN Suppliers.OKPO IS 'Код по ОКПО - Общероссийский классификатор предприятий и организаций';

CREATE TABLE ProductUnits (
	UnitName varchar PRIMARY KEY NOT NULL,
	Description varchar NOT NULL
);

ALTER TABLE Clients
	ADD CONSTRAINT "Clients_Suppliers_id_fkey"
	FOREIGN KEY (SupplierId)
	REFERENCES Suppliers(SupplierId)
	ON DELETE NO ACTION;
ALTER TABLE Orders
	ADD CONSTRAINT "Orders_Clients_id_fkey"
	FOREIGN KEY (ClientId)
	REFERENCES Clients(ClientId)
	ON DELETE NO ACTION;
ALTER TABLE Orders
	ADD CONSTRAINT "Orders_Products_id_fkey"
	FOREIGN KEY (ProductId)
	REFERENCES Products(ProductId)
	ON DELETE NO ACTION;
ALTER TABLE Products
	ADD CONSTRAINT "Products_ProductUnits_id_fkey"
	FOREIGN KEY (Unit)
	REFERENCES ProductUnits(UnitName)
	ON DELETE NO ACTION;

INSERT INTO ProductUnits (UnitName, Description) VALUES ('ITEM', 'Штука');
INSERT INTO ProductUnits (UnitName, Description) VALUES ('PAIR', 'Пара');
	
INSERT INTO Suppliers (SupplierId, Name, Address, CheckingAccount, City, INN, OKONH, OKPO)
VALUES ('F4F91D0DAC724F548DCF838182DDA25F','"Фирма ""Оптовая торговля"""','Новосибирск, К. Маркса,2','"246712 в КБ ""Россия"""','Новосибирск','002811453','9200','42835201');
	
INSERT INTO Clients (ClientId, Name, Address, Chief, CheckingAccount, City, INN, OKONH, OKPO)
VALUES ('3EDC6F774DE64711A0B538B9474F2D5A', 'Новосибирское райпо', 'Новосибирск, Октябрьская, 1', 'Попов А.В.', '"467321 в КБ ""Гамма"""', 'Новосибирск', '0067495978', '87000', '42830152');
INSERT INTO Clients (ClientId, Name, Address, Chief, CheckingAccount, City, INN, OKONH, OKPO)
VALUES ('4ED880432950469F9AC36AEFE9277855','"Магазин ""Лили"""','Новосибирск, Маркса, 2','Колыванов А.А.','"8549900 в КБ ""Омега"""','Новосибирск','0067495579','87003','42851751');
INSERT INTO Clients (ClientId, Name, Address, Chief, CheckingAccount, City, INN, OKONH, OKPO)
VALUES ('2A65E27C1CBF47DEA41CFFB2AB3DA108','"ТОО ""Восток"""','Омск, Ленина, 24','Сидоров И.С.','"67853 в КБ ""Иртыш"""','Омск','0067558145','87045','42854688');
INSERT INTO Clients (ClientId, Name, Address, Chief, CheckingAccount, City, INN, OKONH, OKPO)
VALUES ('4E284F7B81D34636BDAC1B970897D79F','"ТД ""Урал"""','Екатеринбург, Путевая, 12','Панасенко П.П.','"4455789 в КБ ""Уралбизнесбанк"""','Екатеринбург','0067789784','87056','45868456');
INSERT INTO Clients (ClientId, Name, Address, Chief, CheckingAccount, City, INN, OKONH, OKPO)
VALUES ('8DFA309E537D48B0902836B1A6144F27','"Магазин ""Мода плюс"""','Томск, Северная, 32','Степанцов А.П.','"583656 в КБ ""ТомскКБ"""','Томск','0067687867','58675','46574562');
INSERT INTO Clients (ClientId, Name, Address, Chief, CheckingAccount, City, INN, OKONH, OKPO)
VALUES ('EE839BBC99434122BA42AC271807E74C','"Магазин ""Силует"""','Омск, Маркса, 45','Потапова Л. Ю.','"4875743 в КБ ""ОмскПСБ"""','Омкк','0067685848','87584','58438383');
INSERT INTO Clients (ClientId, Name, Address, Chief, CheckingAccount, City, INN, OKONH, OKPO)
VALUES ('0AD64FF3F2B34BD08E9E7E67A1E6A725','"ТД ""Рассвет сибирский"""','Новосибирск, Таежная, 17','Лесников С.А.','"4875636 в КБ ""КлиоБанк"""','Новосибирск','0067574848','57376','48385476');
INSERT INTO Clients (ClientId, Name, Address, Chief, CheckingAccount, City, INN, OKONH, OKPO, SupplierId)
VALUES ('F40FCC6763004B3DB4E4D6C7CE81409E','"ЗАО ""Модная одежда"""','Кемерово, Лесная, 53','Алгазин Д. М.','"4766536 в КБ ""БанкПлюс"""','Кемерово','0067483947','88843','83920484','F4F91D0DAC724F548DCF838182DDA25F');

INSERT INTO Products (ProductId, Unit, Cost, Name, Quantity)
VALUES ('BF0A356792254ACA920A51DB95F224DB','ITEM','800','Брюки','58000');
INSERT INTO Products (ProductId, Unit, Cost, Name, Quantity)
VALUES ('8ED9324BE08F44BFB0F2051D459FC113','ITEM','250','Свитер','12000');
INSERT INTO Products (ProductId, Unit, Cost, Name, Quantity)
VALUES ('AB979BCE304A4BDA9CEB5A4DF06EA07C','ITEM','134','Жилетка','600');
INSERT INTO Products (ProductId, Unit, Cost, Name, Quantity)
VALUES ('A94C6CC3999845E7ADDF3BEE18F7302D','PAIR','213','Кроссовки','1020');
INSERT INTO Products (ProductId, Unit, Cost, Name, Quantity)
VALUES ('76775D03E6C740628B6A5198938B6316','PAIR','25','Носки','123432');
INSERT INTO Products (ProductId, Unit, Cost, Name, Quantity)
VALUES ('C5E9057DA2514DBE9C48CCCDC81C4444','ITEM','64','Плащ','3432');

INSERT INTO Orders (OrderId, ClientId, OrderDate, ProductId, Quantity)
VALUES ('3AB72170718F45F281646CF27BE04B37','3EDC6F774DE64711A0B538B9474F2D5A','12.02.2002','AB979BCE304A4BDA9CEB5A4DF06EA07C','25');
INSERT INTO Orders (OrderId, ClientId, OrderDate, ProductId, Quantity)
VALUES ('38A119287066489C909E8CE621D5DB1A','0AD64FF3F2B34BD08E9E7E67A1E6A725','13.02.2002','BF0A356792254ACA920A51DB95F224DB','40');
INSERT INTO Orders (OrderId, ClientId, OrderDate, ProductId, Quantity)
VALUES ('B7A2DB0A43CC4EAABCDB7A4143E743B1','F40FCC6763004B3DB4E4D6C7CE81409E','14.02.2002','A94C6CC3999845E7ADDF3BEE18F7302D','40');
INSERT INTO Orders (OrderId, ClientId, OrderDate, ProductId, Quantity)
VALUES ('9A30C4E8D8E543A9812C0EF1C3F7EADD','F40FCC6763004B3DB4E4D6C7CE81409E','22.02.2002','8ED9324BE08F44BFB0F2051D459FC113','56');
INSERT INTO Orders (OrderId, ClientId, OrderDate, ProductId, Quantity)
VALUES ('BC64F63D69F04E7D898FA82922D83D07','3EDC6F774DE64711A0B538B9474F2D5A','12.02.2002','AB979BCE304A4BDA9CEB5A4DF06EA07C','32');
INSERT INTO Orders (OrderId, ClientId, OrderDate, ProductId, Quantity)
VALUES ('6E0469BBA9D54E6692BC38784CC5ABC5','0AD64FF3F2B34BD08E9E7E67A1E6A725','25.02.2002','8ED9324BE08F44BFB0F2051D459FC113','45');
INSERT INTO Orders (OrderId, ClientId, OrderDate, ProductId, Quantity)
VALUES ('C3DE4D1FB1CA4499A44869B557622A6B','F40FCC6763004B3DB4E4D6C7CE81409E','26.02.2002','A94C6CC3999845E7ADDF3BEE18F7302D','37');
INSERT INTO Orders (OrderId, ClientId, OrderDate, ProductId, Quantity)
VALUES ('A90CC9F8AF40432D9D625C212BD0454D','4ED880432950469F9AC36AEFE9277855','21.02.2002','BF0A356792254ACA920A51DB95F224DB','45');
INSERT INTO Orders (OrderId, ClientId, OrderDate, ProductId, Quantity)
VALUES ('2194C74A1C1B453FB1720E1A0223B478','4E284F7B81D34636BDAC1B970897D79F','28.02.2002','8ED9324BE08F44BFB0F2051D459FC113','45');
INSERT INTO Orders (OrderId, ClientId, OrderDate, ProductId, Quantity)
VALUES ('A970BF5AB0D548BFB029D76D055791B9','0AD64FF3F2B34BD08E9E7E67A1E6A725','13.02.2002','AB979BCE304A4BDA9CEB5A4DF06EA07C','12');
INSERT INTO Orders (OrderId, ClientId, OrderDate, ProductId, Quantity)
VALUES ('C6CEDF0991AD43848B8563B7FF56CDAE','4ED880432950469F9AC36AEFE9277855','21.02.2002','AB979BCE304A4BDA9CEB5A4DF06EA07C','15');
INSERT INTO Orders (OrderId, ClientId, OrderDate, ProductId, Quantity)
VALUES ('3F58A3A81A7C461C93C3D472C87DF8A8','8DFA309E537D48B0902836B1A6144F27','20.02.2002','76775D03E6C740628B6A5198938B6316','32');
INSERT INTO Orders (OrderId, ClientId, OrderDate, ProductId, Quantity)
VALUES ('2DDE6DE73EF84B22949E3D5B50E4B607','4E284F7B81D34636BDAC1B970897D79F','19.02.2002','A94C6CC3999845E7ADDF3BEE18F7302D','21');