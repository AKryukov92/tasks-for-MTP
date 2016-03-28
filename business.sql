REVOKE SELECT, INSERT, UPDATE, DELETE ON ProductGroups FROM business;
REVOKE SELECT, INSERT, UPDATE, DELETE ON Children FROM business;
REVOKE SELECT, INSERT, UPDATE, DELETE ON Positions FROM business;
REVOKE SELECT, INSERT, UPDATE, DELETE ON Units FROM business;
REVOKE SELECT, INSERT, UPDATE, DELETE ON Orders FROM business;
REVOKE SELECT, INSERT, UPDATE, DELETE ON Clients FROM business;
REVOKE SELECT, INSERT, UPDATE, DELETE ON HireTypes FROM business;
REVOKE SELECT, INSERT, UPDATE, DELETE ON Employees FROM business;
REVOKE SELECT, INSERT, UPDATE, DELETE ON PhoneNumbers FROM business;
REVOKE SELECT, INSERT, UPDATE, DELETE ON PhoneTypes FROM business;
REVOKE SELECT, INSERT, UPDATE, DELETE ON Products FROM business;

DROP USER IF EXISTS business;
CREATE USER business PASSWORD 'business' CONNECTION LIMIT 1;

DROP TABLE IF EXISTS ProductGroups CASCADE;
DROP TABLE IF EXISTS Children CASCADE;
DROP TABLE IF EXISTS Positions CASCADE;
DROP TABLE IF EXISTS Units CASCADE;
DROP TABLE IF EXISTS Orders CASCADE;
DROP TABLE IF EXISTS Clients CASCADE;
DROP TABLE IF EXISTS HireTypes CASCADE;
DROP TABLE IF EXISTS Employees CASCADE;
DROP TABLE IF EXISTS PhoneNumbers CASCADE;
DROP TABLE IF EXISTS PhoneTypes CASCADE;
DROP TABLE IF EXISTS Products CASCADE;

CREATE TABLE ProductGroups (
	ProductGroupId uuid PRIMARY KEY,
	Name varchar
);
COMMENT ON TABLE ProductGroups IS 'Группы';
COMMENT ON COLUMN ProductGroups.ProductGroupId IS 'Код';
COMMENT ON COLUMN ProductGroups.Name IS 'Группа';

CREATE TABLE Children (
	ChildId uuid PRIMARY KEY,
	EmployeeId uuid NOT NULL,
	LastName varchar,
	FirstName varchar,
	FatherName varchar,
	Gender varchar NOT NULL,
	BirthDate date NOT NULL
);
COMMENT ON TABLE Children IS 'Дети';
COMMENT ON COLUMN Children.ChildId IS 'Код';
COMMENT ON COLUMN Children.EmployeeId IS 'Сотрудник';
COMMENT ON COLUMN Children.LastName IS 'Фамилия';
COMMENT ON COLUMN Children.FirstName IS 'Имя';
COMMENT ON COLUMN Children.FatherName IS 'Отчество';
COMMENT ON COLUMN Children.Gender IS 'Пол';
COMMENT ON COLUMN Children.BirthDate IS 'Дата рождения';

CREATE TABLE Positions (
	PositionId varchar PRIMARY KEY,
	Name varchar NOT NULL,
	ManagerId uuid NULL
);
COMMENT ON TABLE Positions IS 'Должности';
COMMENT ON COLUMN Positions.PositionId IS 'Код';
COMMENT ON COLUMN Positions.Name IS 'Должность';
COMMENT ON COLUMN Positions.ManagerId IS 'Код_нач';

CREATE TABLE Units (
	UnitId varchar PRIMARY KEY,
	Name varchar NOT NULL
);
COMMENT ON TABLE Units IS 'Единицы измерения';
COMMENT ON COLUMN Units.UnitId IS 'Код';
COMMENT ON COLUMN Units.Name IS 'Единица';

CREATE TABLE Orders (
	OrderId uuid PRIMARY KEY,
	OrderDate date,
	ProductId uuid,
	Quantity integer,
	ClientId uuid,
	EmployeeId uuid,
	Finished boolean
);
COMMENT ON TABLE Orders IS 'Заказы';
COMMENT ON COLUMN Orders.OrderId IS 'Код';
COMMENT ON COLUMN Orders.OrderDate IS 'дата';
COMMENT ON COLUMN Orders.ProductId IS 'код_товара';
COMMENT ON COLUMN Orders.Quantity IS 'количество';
COMMENT ON COLUMN Orders.ClientId IS 'клиент';
COMMENT ON COLUMN Orders.EmployeeId IS 'ответственный';
COMMENT ON COLUMN Orders.Finished IS 'выполнено';

CREATE TABLE Clients (
	ClientId uuid PRIMARY KEY,
	Name varchar
);
COMMENT ON TABLE Clients IS 'Клиенты';
COMMENT ON COLUMN Clients.ClientId IS 'Код - Уникальный идентификатор клиента';
COMMENT ON COLUMN Clients.Name IS 'Название';

CREATE TABLE HireTypes (
	HireTypeId varchar PRIMARY KEY,
	Description varchar NOT NULL
);
COMMENT ON TABLE HireTypes IS 'Найм';
COMMENT ON COLUMN HireTypes.HireTypeId IS 'Код';
COMMENT ON COLUMN HireTypes.Description IS 'Условие';

CREATE TABLE Employees (
	EmployeeId uuid PRIMARY KEY,
	LastName varchar,
	FirstName varchar,
	FatherName varchar,
	Gender varchar,
	BirthDate date,
	Marriage boolean,
	PostalIndex varchar,
	Address varchar,
	Position varchar,
	HireType varchar,
	Notes varchar
);
COMMENT ON TABLE Employees IS 'Сотрудники';
COMMENT ON COLUMN Employees.EmployeeId IS 'Код';
COMMENT ON COLUMN Employees.LastName IS 'Фамилия';
COMMENT ON COLUMN Employees.FirstName IS 'Имя';
COMMENT ON COLUMN Employees.FatherName IS 'Отчество';
COMMENT ON COLUMN Employees.Gender IS 'пол';
COMMENT ON COLUMN Employees.BirthDate IS 'дата_рожд';
COMMENT ON COLUMN Employees.Marriage IS 'в_браке';
COMMENT ON COLUMN Employees.PostalIndex IS 'Индекс';
COMMENT ON COLUMN Employees.Address IS 'Адрес';
COMMENT ON COLUMN Employees.Position IS 'должность';
COMMENT ON COLUMN Employees.HireType IS 'Условие';
COMMENT ON COLUMN Employees.Notes IS 'Примечание';

CREATE TABLE PhoneTypes (
	PhoneTypeId varchar PRIMARY KEY,
	Description varchar
);
COMMENT ON TABLE PhoneTypes IS 'Типы талафонов';
COMMENT ON COLUMN PhoneTypes.PhoneTypeId IS 'Код';
COMMENT ON COLUMN PhoneTypes.Description IS 'тип';

INSERT INTO PhoneTypes (PhoneTypeId, Description)
VALUES ('HOME', 'домашний');
INSERT INTO PhoneTypes (PhoneTypeId, Description)
VALUES ('WORK', 'рабочий');
INSERT INTO PhoneTypes (PhoneTypeId, Description)
VALUES ('MOBILE', 'мобильный');

CREATE TABLE PhoneNumbers (
	EmployeeId uuid NOT NULL,
	PhoneNumber varchar,
	PhoneType varchar,
	PRIMARY KEY (EmployeeId, PhoneNumber, PhoneType)
);
COMMENT ON TABLE PhoneNumbers IS 'Сотрудники';
COMMENT ON COLUMN PhoneNumbers.EmployeeId IS 'Сотрудник';
COMMENT ON COLUMN PhoneNumbers.PhoneNumber IS 'Телефон';
COMMENT ON COLUMN PhoneNumbers.PhoneType IS 'Тип';

CREATE TABLE Products (
	ProductId uuid PRIMARY KEY,
	Description varchar,
	ProductGroupId uuid,
	UnitId varchar,
	Weight real,
	Cost money,
	Quantity integer
);
COMMENT ON TABLE Products IS 'Товары';
COMMENT ON COLUMN Products.ProductId IS 'Код';
COMMENT ON COLUMN Products.Description IS 'Описание';
COMMENT ON COLUMN Products.ProductGroupId IS 'Группа товара';
COMMENT ON COLUMN Products.UnitId IS 'Единица измерения';
COMMENT ON COLUMN Products.Weight IS 'Масса';
COMMENT ON COLUMN Products.Cost IS 'Стоимость';
COMMENT ON COLUMN Products.Quantity IS 'Количество';

ALTER TABLE Children
	ADD CONSTRAINT "Children_Employees_id_fkey"
	FOREIGN KEY (EmployeeId)
	REFERENCES Employees(EmployeeId)
	ON DELETE NO ACTION;
-- ALTER TABLE Positions
	-- ADD CONSTRAINT "Positions_Employees_id_fkey"
	-- FOREIGN KEY (ManagerId)
	-- REFERENCES Employees(EmployeeId)
	-- ON DELETE NO ACTION;
ALTER TABLE Orders
	ADD CONSTRAINT "Orders_Products_id_fkey"
	FOREIGN KEY (ProductId)
	REFERENCES Products(ProductId)
	ON DELETE NO ACTION;
ALTER TABLE Orders
	ADD CONSTRAINT "Orders_Employees_id_fkey"
	FOREIGN KEY (EmployeeId)
	REFERENCES Employees(EmployeeId)
	ON DELETE NO ACTION;
ALTER TABLE Orders
	ADD CONSTRAINT "Orders_Clients_id_fkey"
	FOREIGN KEY (ClientId)
	REFERENCES Clients(ClientId)
	ON DELETE NO ACTION;
ALTER TABLE Employees
	ADD CONSTRAINT "Employees_HireTypes_id_fkey"
	FOREIGN KEY (HireType)
	REFERENCES HireTypes(HireTypeId)
	ON DELETE NO ACTION;
ALTER TABLE Employees
	ADD CONSTRAINT "Employees_Positions_id_fkey"
	FOREIGN KEY (Position)
	REFERENCES Positions(PositionId)
	ON DELETE NO ACTION;
ALTER TABLE PhoneNumbers
	ADD CONSTRAINT "PhoneNumbers_Employees_id_fkey"
	FOREIGN KEY (EmployeeId)
	REFERENCES Employees(EmployeeId)
	ON DELETE NO ACTION;
ALTER TABLE PhoneNumbers
	ADD CONSTRAINT "PhoneNumbers_PhoneTypes_id_fkey"
	FOREIGN KEY (PhoneType)
	REFERENCES PhoneTypes(PhoneTypeId)
	ON DELETE NO ACTION;
ALTER TABLE Products
	ADD CONSTRAINT "Products_ProductGroups_id_fkey"
	FOREIGN KEY (ProductGroupId)
	REFERENCES ProductGroups(ProductGroupId)
	ON DELETE NO ACTION;
ALTER TABLE Products
	ADD CONSTRAINT "Products_Units_id_fkey"
	FOREIGN KEY (UnitId)
	REFERENCES Units(UnitId)
	ON DELETE NO ACTION;

GRANT SELECT, INSERT, UPDATE, DELETE ON ProductGroups TO business;
GRANT SELECT, INSERT, UPDATE, DELETE ON Children TO business;
GRANT SELECT, INSERT, UPDATE, DELETE ON Positions TO business;
GRANT SELECT, INSERT, UPDATE, DELETE ON Units TO business;
GRANT SELECT, INSERT, UPDATE, DELETE ON Orders TO business;
GRANT SELECT, INSERT, UPDATE, DELETE ON Clients TO business;
GRANT SELECT, INSERT, UPDATE, DELETE ON HireTypes TO business;
GRANT SELECT, INSERT, UPDATE, DELETE ON Employees TO business;
GRANT SELECT, INSERT, UPDATE, DELETE ON PhoneNumbers TO business;
GRANT SELECT, INSERT, UPDATE, DELETE ON PhoneTypes TO business;
GRANT SELECT, INSERT, UPDATE, DELETE ON Products TO business;

INSERT INTO HireTypes (HireTypeId, Description)
VALUES ('CONST', 'Постоянно');
INSERT INTO HireTypes (HireTypeId, Description)
VALUES ('TEMP', 'Временно');
INSERT INTO HireTypes (HireTypeId, Description)
VALUES ('AGREEMENT', 'Трудовое соглашение');

INSERT INTO ProductGroups (ProductGroupId, Name)
VALUES ('ac2a862a9f8440d597b8c4188b07c4ed', 'Чай');
INSERT INTO ProductGroups (ProductGroupId, Name)
VALUES ('9fca6f4e5e3547d6b59b2325c2fa3fe7', 'Кофе');
INSERT INTO ProductGroups (ProductGroupId, Name)
VALUES ('2107053f62f4401f9e1ef19a2039fa0b', 'Безалкогольные напитки');
INSERT INTO ProductGroups (ProductGroupId, Name)
VALUES ('02855ed032a24415a37f942d4b99cb5a', 'Хлебо-булочные изделия');
INSERT INTO ProductGroups (ProductGroupId, Name)
VALUES ('043dd2bbe1524149bf13eb5ae9dde160', 'Кондитерские изделия');

INSERT INTO Positions (PositionId, Name, ManagerId)
VALUES ('CHIEF', 'Директор', NULL);
INSERT INTO Positions (PositionId, Name, ManagerId)
VALUES ('CHIEF_ACCOUNTANT', 'Главный бухгалтер', '04c65c28e4d64dda9439ddfddac7c483');
INSERT INTO Positions (PositionId, Name, ManagerId)
VALUES ('ACCOUNTANT', 'Бухгалтер', '95a4485b7c7143fba582843a704a376e');
INSERT INTO Positions (PositionId, Name, ManagerId)
VALUES ('CASHIER', 'Кассир', '95a4485b7c7143fba582843a704a376e');
INSERT INTO Positions (PositionId, Name, ManagerId)
VALUES ('AGENT', 'Агент', 'a6e61e149d9149bb846ade9d23353fa5');
INSERT INTO Positions (PositionId, Name, ManagerId)
VALUES ('COURIER', 'Курьер', 'a6e61e149d9149bb846ade9d23353fa5');
INSERT INTO Positions (PositionId, Name, ManagerId)
VALUES ('MANAGER', 'Менеджер', NULL);
INSERT INTO Positions (PositionId, Name, ManagerId)
VALUES ('SELLER', 'Продавец', 'a6e61e149d9149bb846ade9d23353fa5');

INSERT INTO Units (UnitId, Name)
VALUES ('UNIT','штука');
INSERT INTO Units (UnitId, Name)
VALUES ('PACKING','упаковка');
INSERT INTO Units (UnitId, Name)
VALUES ('PACK','пачка');
INSERT INTO Units (UnitId, Name)
VALUES ('BOTTLE_05','бутылка 0.5 л.');
INSERT INTO Units (UnitId, Name)
VALUES ('BOTTLE_033','бутылка 0.33 л.');
INSERT INTO Units (UnitId, Name)
VALUES ('BOX','коробка');
INSERT INTO Units (UnitId, Name)
VALUES ('CRATE','ящик');
INSERT INTO Units (UnitId, Name)
VALUES ('TIN_POT','банка, жесть');
INSERT INTO Units (UnitId, Name)
VALUES ('GLASS_POT','банка, стекло');

INSERT INTO Products (ProductId, Description, ProductGroupId, UnitId, Weight, Cost, Quantity)
VALUES('cc873c2777004d4ea4c8569feb6bb93f','Принцесса Нури','ac2a862a9f8440d597b8c4188b07c4ed','PACK','0.1','12','100');
INSERT INTO Products (ProductId, Description, ProductGroupId, UnitId, Weight, Cost, Quantity)
VALUES('9ab182189692413da489f8857966a437','Принцесса Гита','ac2a862a9f8440d597b8c4188b07c4ed','PACK','0.1','11','68');
INSERT INTO Products (ProductId, Description, ProductGroupId, UnitId, Weight, Cost, Quantity)
VALUES('4911b1d6a1ae45a28f513051d7338351','Принцесса Ява','ac2a862a9f8440d597b8c4188b07c4ed','PACK','0.25','12','80');
INSERT INTO Products (ProductId, Description, ProductGroupId, UnitId, Weight, Cost, Quantity)
VALUES('43d2d576ee8149ee8f1afa254f060538','Остров Цейлон','ac2a862a9f8440d597b8c4188b07c4ed','PACK','0.1','20','0');
INSERT INTO Products (ProductId, Description, ProductGroupId, UnitId, Weight, Cost, Quantity)
VALUES('d28cfd5e10144214ab09c37be1771202','Нескафе Классик','9fca6f4e5e3547d6b59b2325c2fa3fe7','TIN_POT','0.05','52','25');
INSERT INTO Products (ProductId, Description, ProductGroupId, UnitId, Weight, Cost, Quantity)
VALUES('6992f73e4c5d4180bb6eca0471be60f4','Нескафе Голд','9fca6f4e5e3547d6b59b2325c2fa3fe7','TIN_POT','0.25','110','80');
INSERT INTO Products (ProductId, Description, ProductGroupId, UnitId, Weight, Cost, Quantity)
VALUES('9ee3e7acf6114eb9b9fb5eb4dbfad0d9','Чибо','9fca6f4e5e3547d6b59b2325c2fa3fe7','GLASS_POT','0.05','42','120');
INSERT INTO Products (ProductId, Description, ProductGroupId, UnitId, Weight, Cost, Quantity)
VALUES('459b52b62fcf431cb9a0344d47c3430d','"конфеты ""Родные просторы"""','043dd2bbe1524149bf13eb5ae9dde160','BOX','0.2','40','65');
INSERT INTO Products (ProductId, Description, ProductGroupId, UnitId, Weight, Cost, Quantity)
VALUES('d1123ce97531457982726af7bb767a78','"шоколад ""Вдохновение"""','043dd2bbe1524149bf13eb5ae9dde160','PACK','0.1','10','250');
INSERT INTO Products (ProductId, Description, ProductGroupId, UnitId, Weight, Cost, Quantity)
VALUES('5f654c635a1b42cd85cd6bbb48f2f9e6','"конфеты ""Ассорти"""','043dd2bbe1524149bf13eb5ae9dde160','BOX','0.25','40','0');
INSERT INTO Products (ProductId, Description, ProductGroupId, UnitId, Weight, Cost, Quantity)
VALUES('b35da2df57fc4061b46560c29dbdcb64','"конфеты ""Вечерняя Москва"""','043dd2bbe1524149bf13eb5ae9dde160','BOX','0.8','50','12');
INSERT INTO Products (ProductId, Description, ProductGroupId, UnitId, Weight, Cost, Quantity)
VALUES('8e1759f3a1bc4856a6a87e1b04845a08','"шоколад ""Жигули"""','043dd2bbe1524149bf13eb5ae9dde160','PACK','0.1','8','50');
INSERT INTO Products (ProductId, Description, ProductGroupId, UnitId, Weight, Cost, Quantity)
VALUES('cb254f7ecb1a40bb8b68a552bddeeaeb','"конфеты ""Монпасье"""','043dd2bbe1524149bf13eb5ae9dde160','PACKING','0.2','25','0');
INSERT INTO Products (ProductId, Description, ProductGroupId, UnitId, Weight, Cost, Quantity)
VALUES('e14d2ced9be849f08a1c111da98fa24b','"печенье ""Уикенд"""','043dd2bbe1524149bf13eb5ae9dde160','PACK','0.1','12','35');
INSERT INTO Products (ProductId, Description, ProductGroupId, UnitId, Weight, Cost, Quantity)
VALUES('b96d685c96c44ab4bcd8c4b212b78895','кекс Абрикосовый','043dd2bbe1524149bf13eb5ae9dde160','UNIT','0.2','24','12');
INSERT INTO Products (ProductId, Description, ProductGroupId, UnitId, Weight, Cost, Quantity)
VALUES('190d93bc7d874908b5ae8a738b254b98','печенье Ванильное','043dd2bbe1524149bf13eb5ae9dde160','PACK','0.1','12','20');
INSERT INTO Products (ProductId, Description, ProductGroupId, UnitId, Weight, Cost, Quantity)
VALUES('e7b27ac5aa3741ef89f49c3e8372f8ff','Кока-Кола','2107053f62f4401f9e1ef19a2039fa0b','BOTTLE_033',NULL,'8','0');
INSERT INTO Products (ProductId, Description, ProductGroupId, UnitId, Weight, Cost, Quantity)
VALUES('bb1d2dd577ef41b79f8553da6175b0ce','Лимонад','2107053f62f4401f9e1ef19a2039fa0b','BOTTLE_05',NULL,'6','40');
INSERT INTO Products (ProductId, Description, ProductGroupId, UnitId, Weight, Cost, Quantity)
VALUES('c9ffb3b096f1490e81bd2d6e58cee6f1','Пепси-Кола','2107053f62f4401f9e1ef19a2039fa0b','BOTTLE_033',NULL,'8','45');

INSERT INTO Employees (EmployeeId, LastName, FirstName, FatherName, Gender, BirthDate, Marriage, PostalIndex, Address, Position, HireType, Notes)
VALUES ('04c65c28e4d64dda9439ddfddac7c483','Иванов',' Иван','Иванович','М','25.12.1959','TRUE','644050','проезд Ильича, 12-3','CHIEF','CONST','Босс');
INSERT INTO Employees (EmployeeId, LastName, FirstName, FatherName, Gender, BirthDate, Marriage, PostalIndex, Address, Position, HireType, Notes)
VALUES ('95a4485b7c7143fba582843a704a376e','Кузнецова','Тамара','Ивановна','Ж','30.08.1969','TRUE','644042','Спортивный Проезд, 2-21','CHIEF_ACCOUNTANT','CONST','');
INSERT INTO Employees (EmployeeId, LastName, FirstName, FatherName, Gender, BirthDate, Marriage, PostalIndex, Address, Position, HireType, Notes)
VALUES ('ebb729718f614ca39d5c3ed7c9400328','Петрова','Светлана','Сергеевна','Ж','14.02.1975','FALSE','644065','ул. Володарская, 22-123','ACCOUNTANT','CONST','');
INSERT INTO Employees (EmployeeId, LastName, FirstName, FatherName, Gender, BirthDate, Marriage, PostalIndex, Address, Position, HireType, Notes)
VALUES ('6ee3de354976482ca25b8d88d674f005','Сидоров','Петр','Сергеевич','М','25.05.1968','TRUE','644008','ул. Зеленая, 77-5','SELLER','TEMP','имеет опыт работы, хорошие рекомендации');
INSERT INTO Employees (EmployeeId, LastName, FirstName, FatherName, Gender, BirthDate, Marriage, PostalIndex, Address, Position, HireType, Notes)
VALUES ('691c029458c54db0ac2809584f7c8b43','Долгих','Зинаида','Васильевна','Ж','23.11.1971','TRUE','644111','проспект Космонавтов, д3/2, кв.230','MANAGER','CONST','');
INSERT INTO Employees (EmployeeId, LastName, FirstName, FatherName, Gender, BirthDate, Marriage, PostalIndex, Address, Position, HireType, Notes)
VALUES ('43b386f354a444cebd3d3a41943c639f','Сидоров','Антон','Прокопьевич','М','28.02.1949','FALSE','644044','ул. Строителей, 12-24','AGENT','CONST','');
INSERT INTO Employees (EmployeeId, LastName, FirstName, FatherName, Gender, BirthDate, Marriage, PostalIndex, Address, Position, HireType, Notes)
VALUES ('a6e61e149d9149bb846ade9d23353fa5','Воронин','Сергей','Александрович','М','12.12.1969','TRUE','644027','ул. Родионова, 34','AGENT','TEMP','');
INSERT INTO Employees (EmployeeId, LastName, FirstName, FatherName, Gender, BirthDate, Marriage, PostalIndex, Address, Position, HireType, Notes)
VALUES ('35ae930259244b70ac85940e453852df','Прохоренко','Михаил','Васильевич','М','07.06.1944','TRUE','644080','ул. Светлая, 4, корпус 2, кв. 13','AGENT','CONST','');
INSERT INTO Employees (EmployeeId, LastName, FirstName, FatherName, Gender, BirthDate, Marriage, PostalIndex, Address, Position, HireType, Notes)
VALUES ('e6fd9c0d6e7d4255849ef340140fbf79','Фролова','Вероника','Станиславовна','Ж','17.09.1976','FALSE','644013','ул. Новая, д. 4, кв. 53','CASHIER','TEMP','');
INSERT INTO Employees (EmployeeId, LastName, FirstName, FatherName, Gender, BirthDate, Marriage, PostalIndex, Address, Position, HireType, Notes)
VALUES ('61e6455900e642b1a5df11853713df92','Яковлев','Евгений','Васильевич','М','25.04.1970','FALSE','644045','ул. Молодежная, 33а, кв. 118','COURIER','TEMP','');

INSERT INTO Children (ChildId, EmployeeId, LastName, FirstName, FatherName, Gender, BirthDate)
VALUES ('8d4dbc6e26fc4bc5bc6fa2742f85bf4e', '95a4485b7c7143fba582843a704a376e', 'Кузнецов', 'Сергей', 'Леонидович', 'М', '12.08.1993');
INSERT INTO Children (ChildId, EmployeeId, LastName, FirstName, FatherName, Gender, BirthDate)
VALUES ('f284c884bb4d4cf7bb31d84c86d5b51e', 'ebb729718f614ca39d5c3ed7c9400328', 'Петров', 'Станислав', 'Сергеевич', 'М', '21.04.1998');
INSERT INTO Children (ChildId, EmployeeId, LastName, FirstName, FatherName, Gender, BirthDate)
VALUES ('77c48d68148643698969adbc1d9e6c50', '61e6455900e642b1a5df11853713df92', 'Яковлев', 'Иван', 'Евгеньевич', 'М', '30.04.1989');
INSERT INTO Children (ChildId, EmployeeId, LastName, FirstName, FatherName, Gender, BirthDate)
VALUES ('ac17323ecd014510951cddd15449929b', '61e6455900e642b1a5df11853713df92', 'Яковлева', 'Надежда', 'Евгеньевна', 'Ж', '24.09.1991');
INSERT INTO Children (ChildId, EmployeeId, LastName, FirstName, FatherName, Gender, BirthDate)
VALUES ('38ba48babee4435db9d0159d028a69c7', '35ae930259244b70ac85940e453852df', 'Прохоренко', 'Сергей', 'Михайлович', 'М', '22.10.1970');

INSERT INTO Clients (ClientId, Name)
VALUES ('f20464cb2c6b4f8db1dd3cef77ea2e35','ООО "Рога и копыта"');
INSERT INTO Clients (ClientId, Name)
VALUES ('0b027250e1e14a5c887ec462f1a2d875','магазин "Колос"');
INSERT INTO Clients (ClientId, Name)
VALUES ('10eb0fdc33784f35b7855332c6f54ddb','кафе "Три толстяка"');
INSERT INTO Clients (ClientId, Name)
VALUES ('2963c311fa64492dac12a7916f01e963','ЧП А. А. Соснов');
INSERT INTO Clients (ClientId, Name)
VALUES ('26007c7423c346b4be6294855275056b','магазин "Оазис"');
INSERT INTO Clients (ClientId, Name)
VALUES ('900ee4da4b2c4b54a3b66ab01c1ccdee','ЗАО "Дебют"');
INSERT INTO Clients (ClientId, Name)
VALUES ('4c288a239fb14f27a03925be33c9a410','ООО "Фролов и К."');

INSERT INTO PhoneNumbers (EmployeeId, PhoneNumber, PhoneType)
VALUES ('04c65c28e4d64dda9439ddfddac7c483', '3812224584', 'HOME');
INSERT INTO PhoneNumbers (EmployeeId, PhoneNumber, PhoneType)
VALUES ('04c65c28e4d64dda9439ddfddac7c483', '3812440484', 'WORK');
INSERT INTO PhoneNumbers (EmployeeId, PhoneNumber, PhoneType)
VALUES ('04c65c28e4d64dda9439ddfddac7c483', '3812445230', 'WORK');
INSERT INTO PhoneNumbers (EmployeeId, PhoneNumber, PhoneType)
VALUES ('95a4485b7c7143fba582843a704a376e', '3812440412', 'WORK');
INSERT INTO PhoneNumbers (EmployeeId, PhoneNumber, PhoneType)
VALUES ('ebb729718f614ca39d5c3ed7c9400328', '3812440412', 'WORK');
INSERT INTO PhoneNumbers (EmployeeId, PhoneNumber, PhoneType)
VALUES ('6ee3de354976482ca25b8d88d674f005', '3812130054', 'HOME');
INSERT INTO PhoneNumbers (EmployeeId, PhoneNumber, PhoneType)
VALUES ('691c029458c54db0ac2809584f7c8b43', '3812440421', 'WORK');
INSERT INTO PhoneNumbers (EmployeeId, PhoneNumber, PhoneType)
VALUES ('691c029458c54db0ac2809584f7c8b43', '3812258552', 'HOME');
INSERT INTO PhoneNumbers (EmployeeId, PhoneNumber, PhoneType)
VALUES ('a6e61e149d9149bb846ade9d23353fa5', '218754', 'HOME');
INSERT INTO PhoneNumbers (EmployeeId, PhoneNumber, PhoneType)
VALUES ('35ae930259244b70ac85940e453852df', '258534', 'HOME');
INSERT INTO PhoneNumbers (EmployeeId, PhoneNumber, PhoneType)
VALUES ('e6fd9c0d6e7d4255849ef340140fbf79', '142514', 'HOME');

INSERT INTO Orders (OrderId, OrderDate, ProductId, Quantity, ClientId, EmployeeId, Finished)
VALUES ('fa93fb0fb1ca4bbfb7e9dd7a57c40cca','07.04.2001','cc873c2777004d4ea4c8569feb6bb93f','24','f20464cb2c6b4f8db1dd3cef77ea2e35','a6e61e149d9149bb846ade9d23353fa5','TRUE');
INSERT INTO Orders (OrderId, OrderDate, ProductId, Quantity, ClientId, EmployeeId, Finished)
VALUES ('eed48e5434154394af11b679b93b6561','07.04.2001','d28cfd5e10144214ab09c37be1771202','20','10eb0fdc33784f35b7855332c6f54ddb','04c65c28e4d64dda9439ddfddac7c483','FALSE');
INSERT INTO Orders (OrderId, OrderDate, ProductId, Quantity, ClientId, EmployeeId, Finished)
VALUES ('48bd337e8efd48d69c44f40db6b326f1','06.05.2001','e7b27ac5aa3741ef89f49c3e8372f8ff','12','26007c7423c346b4be6294855275056b','35ae930259244b70ac85940e453852df','FALSE');
INSERT INTO Orders (OrderId, OrderDate, ProductId, Quantity, ClientId, EmployeeId, Finished)
VALUES ('73c2edcb49ac4994b39eaa028c8bf70b','10.05.2001','e7b27ac5aa3741ef89f49c3e8372f8ff','20','0b027250e1e14a5c887ec462f1a2d875','35ae930259244b70ac85940e453852df','FALSE');
INSERT INTO Orders (OrderId, OrderDate, ProductId, Quantity, ClientId, EmployeeId, Finished)
VALUES ('ac6523c0d5184efe90908b4bea5d8989','10.05.2001','bb1d2dd577ef41b79f8553da6175b0ce','45','26007c7423c346b4be6294855275056b','ebb729718f614ca39d5c3ed7c9400328','FALSE');
INSERT INTO Orders (OrderId, OrderDate, ProductId, Quantity, ClientId, EmployeeId, Finished)
VALUES ('b9cce5a2d8444843baaa6d23a9514aff','10.05.2001','d28cfd5e10144214ab09c37be1771202','10','10eb0fdc33784f35b7855332c6f54ddb', '35ae930259244b70ac85940e453852df','FALSE');
INSERT INTO Orders (OrderId, OrderDate, ProductId, Quantity, ClientId, EmployeeId, Finished)
VALUES ('c4a81e7799574b0e8b42586a2787f479','24.05.2000','8e1759f3a1bc4856a6a87e1b04845a08','24','26007c7423c346b4be6294855275056b','43b386f354a444cebd3d3a41943c639f','TRUE');
INSERT INTO Orders (OrderId, OrderDate, ProductId, Quantity, ClientId, EmployeeId, Finished)
VALUES ('b8345a012f244af7981893c277c23060','24.05.2000','e14d2ced9be849f08a1c111da98fa24b','13','f20464cb2c6b4f8db1dd3cef77ea2e35','43b386f354a444cebd3d3a41943c639f','TRUE');
INSERT INTO Orders (OrderId, OrderDate, ProductId, Quantity, ClientId, EmployeeId, Finished)
VALUES ('3c4a8923d25a460a8f35bed51f41dbf7','28.05.2000','190d93bc7d874908b5ae8a738b254b98','6','f20464cb2c6b4f8db1dd3cef77ea2e35','35ae930259244b70ac85940e453852df','FALSE');
INSERT INTO Orders (OrderId, OrderDate, ProductId, Quantity, ClientId, EmployeeId, Finished)
VALUES ('60f72b6f1c8042d0b594743b05480239','28.05.2000','43d2d576ee8149ee8f1afa254f060538','44','2963c311fa64492dac12a7916f01e963','43b386f354a444cebd3d3a41943c639f','TRUE');
INSERT INTO Orders (OrderId, OrderDate, ProductId, Quantity, ClientId, EmployeeId, Finished)
VALUES ('d6957d5ce3b0433281b2c21663883b0b','28.04.2001','6992f73e4c5d4180bb6eca0471be60f4','12','2963c311fa64492dac12a7916f01e963','6ee3de354976482ca25b8d88d674f005','FALSE');
INSERT INTO Orders (OrderId, OrderDate, ProductId, Quantity, ClientId, EmployeeId, Finished)
VALUES ('0e11365ebfc34727b7609d6a394d0ea1','28.04.2001','b35da2df57fc4061b46560c29dbdcb64','50','f20464cb2c6b4f8db1dd3cef77ea2e35','61e6455900e642b1a5df11853713df92','FALSE');
INSERT INTO Orders (OrderId, OrderDate, ProductId, Quantity, ClientId, EmployeeId, Finished)
VALUES ('f68b0242475542b6a2dce787170292c6','29.05.1999','5f654c635a1b42cd85cd6bbb48f2f9e6','24','900ee4da4b2c4b54a3b66ab01c1ccdee','35ae930259244b70ac85940e453852df','FALSE');
INSERT INTO Orders (OrderId, OrderDate, ProductId, Quantity, ClientId, EmployeeId, Finished)
VALUES ('9388d49cf62e44ed8c11ac49310a8aaf','01.03.2001','e14d2ced9be849f08a1c111da98fa24b','26','4c288a239fb14f27a03925be33c9a410','6ee3de354976482ca25b8d88d674f005','FALSE');
INSERT INTO Orders (OrderId, OrderDate, ProductId, Quantity, ClientId, EmployeeId, Finished)
VALUES ('1dcb9e7f4f3b415384e0d570db4a1484','01.03.2001','b35da2df57fc4061b46560c29dbdcb64','32','4c288a239fb14f27a03925be33c9a410','43b386f354a444cebd3d3a41943c639f','TRUE');
INSERT INTO Orders (OrderId, OrderDate, ProductId, Quantity, ClientId, EmployeeId, Finished)
VALUES ('8b63d1aa8ef8441abd70f7533d14ed3e','01.03.2001','b96d685c96c44ab4bcd8c4b212b78895','23','10eb0fdc33784f35b7855332c6f54ddb','a6e61e149d9149bb846ade9d23353fa5','FALSE');
INSERT INTO Orders (OrderId, OrderDate, ProductId, Quantity, ClientId, EmployeeId, Finished)
VALUES ('fef14e3b1e414ef4a47ef1136cc95e1c','06.03.2001','6992f73e4c5d4180bb6eca0471be60f4','23','4c288a239fb14f27a03925be33c9a410','35ae930259244b70ac85940e453852df','FALSE');
INSERT INTO Orders (OrderId, OrderDate, ProductId, Quantity, ClientId, EmployeeId, Finished)
VALUES ('ee38b24a8b9b406f9f49ef252aacc43b','06.03.2001','e7b27ac5aa3741ef89f49c3e8372f8ff','11','0b027250e1e14a5c887ec462f1a2d875','43b386f354a444cebd3d3a41943c639f','FALSE');
INSERT INTO Orders (OrderId, OrderDate, ProductId, Quantity, ClientId, EmployeeId, Finished)
VALUES ('f3509b9dd5a94576836089945fc4609c','01.04.2001','b35da2df57fc4061b46560c29dbdcb64','12','f20464cb2c6b4f8db1dd3cef77ea2e35','a6e61e149d9149bb846ade9d23353fa5','FALSE');
INSERT INTO Orders (OrderId, OrderDate, ProductId, Quantity, ClientId, EmployeeId, Finished)
VALUES ('552758c046ae4c39ba2de737edb37b30','06.03.2001','b96d685c96c44ab4bcd8c4b212b78895','20','900ee4da4b2c4b54a3b66ab01c1ccdee','43b386f354a444cebd3d3a41943c639f','TRUE');
INSERT INTO Orders (OrderId, OrderDate, ProductId, Quantity, ClientId, EmployeeId, Finished)
VALUES ('6db57d5702694cb8a40b4740782e00ca','01.04.2001','e7b27ac5aa3741ef89f49c3e8372f8ff','41','2963c311fa64492dac12a7916f01e963','61e6455900e642b1a5df11853713df92','TRUE');
INSERT INTO Orders (OrderId, OrderDate, ProductId, Quantity, ClientId, EmployeeId, Finished)
VALUES ('21313bff22c24db7ab3a3674339c887b','07.03.2001','cb254f7ecb1a40bb8b68a552bddeeaeb','23','4c288a239fb14f27a03925be33c9a410','61e6455900e642b1a5df11853713df92','FALSE');
INSERT INTO Orders (OrderId, OrderDate, ProductId, Quantity, ClientId, EmployeeId, Finished)
VALUES ('631b4708286442d6a97f1bbcdafb383d','07.03.2001','e7b27ac5aa3741ef89f49c3e8372f8ff','52','0b027250e1e14a5c887ec462f1a2d875','43b386f354a444cebd3d3a41943c639f','FALSE');
INSERT INTO Orders (OrderId, OrderDate, ProductId, Quantity, ClientId, EmployeeId, Finished)
VALUES ('7b8ba05557d4461b9ff4ecad505e61bb','07.03.2001','cc873c2777004d4ea4c8569feb6bb93f','20','f20464cb2c6b4f8db1dd3cef77ea2e35','04c65c28e4d64dda9439ddfddac7c483','TRUE');