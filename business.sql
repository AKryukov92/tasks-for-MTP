CREATE USER business PASSWORD 'business' CONNECTION LIMIT 1;

DROP TABLE IF EXISTS product_groups CASCADE;
DROP TABLE IF EXISTS children CASCADE;
DROP TABLE IF EXISTS positions CASCADE;
DROP TABLE IF EXISTS units CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS clients CASCADE;
DROP TABLE IF EXISTS hire_types CASCADE;
DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS phone_numbers CASCADE;
DROP TABLE IF EXISTS phone_types CASCADE;
DROP TABLE IF EXISTS products CASCADE;

CREATE TABLE product_groups (
	id uuid PRIMARY KEY,
	name varchar
);
COMMENT ON TABLE product_groups IS 'Группы';
COMMENT ON COLUMN product_groups.id IS 'Код';
COMMENT ON COLUMN product_groups.name IS 'Группа';

CREATE TABLE children (
	id uuid PRIMARY KEY,
	employee_id uuid NOT NULL,
	last_name varchar,
	first_name varchar,
	father_name varchar,
	gender varchar NOT NULL,
	birth_date date NOT NULL
);
COMMENT ON TABLE children IS 'Дети';
COMMENT ON COLUMN children.id IS 'Код';
COMMENT ON COLUMN children.employee_id IS 'Сотрудник';
COMMENT ON COLUMN children.last_name IS 'Фамилия';
COMMENT ON COLUMN children.first_name IS 'Имя';
COMMENT ON COLUMN children.father_name IS 'Отчество';
COMMENT ON COLUMN children.gender IS 'Пол';
COMMENT ON COLUMN children.birth_date IS 'Дата рождения';

CREATE TABLE positions (
	id varchar PRIMARY KEY,
	name varchar NOT NULL,
	manager_id uuid NULL
);
COMMENT ON TABLE positions IS 'Должности';
COMMENT ON COLUMN positions.id IS 'Код';
COMMENT ON COLUMN positions.name IS 'Должность';
COMMENT ON COLUMN positions.manager_id IS 'Код_нач';

CREATE TABLE units (
	id varchar PRIMARY KEY,
	name varchar NOT NULL
);
COMMENT ON TABLE units IS 'Единицы измерения';
COMMENT ON COLUMN units.id IS 'Код';
COMMENT ON COLUMN units.name IS 'Единица';

CREATE TABLE orders (
	id uuid PRIMARY KEY,
	order_date date,
	product_id uuid,
	quantity integer,
	client_id uuid,
	employee_id uuid,
	finished boolean
);
COMMENT ON TABLE orders IS 'Заказы';
COMMENT ON COLUMN orders.id IS 'Код';
COMMENT ON COLUMN orders.order_date IS 'дата';
COMMENT ON COLUMN orders.product_id IS 'код_товара';
COMMENT ON COLUMN orders.quantity IS 'количество';
COMMENT ON COLUMN orders.client_id IS 'клиент';
COMMENT ON COLUMN orders.employee_id IS 'ответственный';
COMMENT ON COLUMN orders.finished IS 'выполнено';

CREATE TABLE clients (
	id uuid PRIMARY KEY,
	checking_account varchar,
	INN varchar,
	name varchar
);
COMMENT ON TABLE clients IS 'Клиенты';
COMMENT ON COLUMN clients.id IS 'Код - Уникальный идентификатор клиента';
COMMENT ON COLUMN clients.checking_account IS 'Расчетный счет';
COMMENT ON COLUMN clients.INN IS 'ИНН - Индивидуальный налоговый номер';
COMMENT ON COLUMN clients.name IS 'Название';

CREATE TABLE hire_types (
	id varchar PRIMARY KEY,
	description varchar NOT NULL
);
COMMENT ON TABLE hire_types IS 'Найм';
COMMENT ON COLUMN hire_types.id IS 'Код';
COMMENT ON COLUMN hire_types.description IS 'Условие найма';

CREATE TABLE employees (
	id uuid PRIMARY KEY,
	last_name varchar,
	first_name varchar,
	father_name varchar,
	gender varchar,
	birth_date date,
	marriage boolean,
	postal_index varchar,
	address varchar,
	position varchar,
	hire_type varchar,
	notes varchar
);
COMMENT ON TABLE employees IS 'Сотрудники';
COMMENT ON COLUMN employees.id IS 'Код';
COMMENT ON COLUMN employees.last_name IS 'Фамилия';
COMMENT ON COLUMN employees.first_name IS 'Имя';
COMMENT ON COLUMN employees.father_name IS 'Отчество';
COMMENT ON COLUMN employees.gender IS 'пол';
COMMENT ON COLUMN employees.birth_date IS 'дата_рожд';
COMMENT ON COLUMN employees.marriage IS 'в_браке';
COMMENT ON COLUMN employees.postal_index IS 'Индекс';
COMMENT ON COLUMN employees.address IS 'Адрес';
COMMENT ON COLUMN employees.position IS 'должность';
COMMENT ON COLUMN employees.hire_type IS 'Условие';
COMMENT ON COLUMN employees.notes IS 'Примечание';

CREATE TABLE phone_types (
	id varchar PRIMARY KEY,
	description varchar
);
COMMENT ON TABLE phone_types IS 'Типы талафонов';
COMMENT ON COLUMN phone_types.id IS 'Код';
COMMENT ON COLUMN phone_types.description IS 'тип';

INSERT INTO phone_types (id, description)
VALUES ('HOME', 'домашний');
INSERT INTO phone_types (id, description)
VALUES ('WORK', 'рабочий');
INSERT INTO phone_types (id, description)
VALUES ('MOBILE', 'мобильный');

CREATE TABLE phone_numbers (
	employee_id uuid NOT NULL,
	phone_number varchar,
	phone_type varchar,
	PRIMARY KEY (employee_id, phone_number, phone_type)
);
COMMENT ON TABLE phone_numbers IS 'Сотрудники';
COMMENT ON COLUMN phone_numbers.employee_id IS 'Сотрудник';
COMMENT ON COLUMN phone_numbers.phone_number IS 'Телефон';
COMMENT ON COLUMN phone_numbers.phone_type IS 'Тип';

CREATE TABLE products (
	id uuid PRIMARY KEY,
	description varchar,
	product_group_id uuid,
	unit_id varchar,
	weight decimal,
	cost decimal,
	quantity integer
);
COMMENT ON TABLE products IS 'Товары';
COMMENT ON COLUMN products.id IS 'Код';
COMMENT ON COLUMN products.description IS 'Описание';
COMMENT ON COLUMN products.product_group_id IS 'Группа товара';
COMMENT ON COLUMN products.unit_id IS 'Единица измерения';
COMMENT ON COLUMN products.weight IS 'Масса';
COMMENT ON COLUMN products.cost IS 'Стоимость';
COMMENT ON COLUMN products.quantity IS 'Количество';

ALTER TABLE children
	ADD CONSTRAINT "children_employees_id_fkey"
	FOREIGN KEY (employee_id)
	REFERENCES employees(id)
	ON DELETE NO ACTION;
-- ALTER TABLE positions
	-- ADD CONSTRAINT "positions_employees_id_fkey"
	-- FOREIGN KEY (manager_id)
	-- REFERENCES employees(id)
	-- ON DELETE NO ACTION;
ALTER TABLE orders
	ADD CONSTRAINT "orders_products_id_fkey"
	FOREIGN KEY (product_id)
	REFERENCES products(id)
	ON DELETE NO ACTION;
ALTER TABLE orders
	ADD CONSTRAINT "orders_employees_id_fkey"
	FOREIGN KEY (employee_id)
	REFERENCES employees(id)
	ON DELETE NO ACTION;
ALTER TABLE orders
	ADD CONSTRAINT "orders_clients_id_fkey"
	FOREIGN KEY (client_id)
	REFERENCES clients(id)
	ON DELETE NO ACTION;
ALTER TABLE employees
	ADD CONSTRAINT "employees_hire_types_id_fkey"
	FOREIGN KEY (hire_type)
	REFERENCES hire_types(id)
	ON DELETE NO ACTION;
ALTER TABLE employees
	ADD CONSTRAINT "employees_positions_id_fkey"
	FOREIGN KEY (position)
	REFERENCES positions(id)
	ON DELETE NO ACTION;
ALTER TABLE phone_numbers
	ADD CONSTRAINT "phone_numbers_employees_id_fkey"
	FOREIGN KEY (employee_id)
	REFERENCES employees(id)
	ON DELETE NO ACTION;
ALTER TABLE phone_numbers
	ADD CONSTRAINT "phone_numbers_phone_types_id_fkey"
	FOREIGN KEY (phone_type)
	REFERENCES phone_types(id)
	ON DELETE NO ACTION;
ALTER TABLE products
	ADD CONSTRAINT "products_product_groups_id_fkey"
	FOREIGN KEY (product_group_id)
	REFERENCES product_groups(id)
	ON DELETE NO ACTION;
ALTER TABLE products
	ADD CONSTRAINT "products_units_id_fkey"
	FOREIGN KEY (unit_id)
	REFERENCES units(id)
	ON DELETE NO ACTION;

GRANT SELECT, INSERT, UPDATE, DELETE ON product_groups TO business;
GRANT SELECT, INSERT, UPDATE, DELETE ON children TO business;
GRANT SELECT, INSERT, UPDATE, DELETE ON positions TO business;
GRANT SELECT, INSERT, UPDATE, DELETE ON units TO business;
GRANT SELECT, INSERT, UPDATE, DELETE ON orders TO business;
GRANT SELECT, INSERT, UPDATE, DELETE ON clients TO business;
GRANT SELECT, INSERT, UPDATE, DELETE ON hire_types TO business;
GRANT SELECT, INSERT, UPDATE, DELETE ON employees TO business;
GRANT SELECT, INSERT, UPDATE, DELETE ON phone_numbers TO business;
GRANT SELECT, INSERT, UPDATE, DELETE ON phone_types TO business;
GRANT SELECT, INSERT, UPDATE, DELETE ON products TO business;

INSERT INTO hire_types (id, description)
VALUES ('CONST', 'Постоянно');
INSERT INTO hire_types (id, description)
VALUES ('TEMP', 'Временно');
INSERT INTO hire_types (id, description)
VALUES ('AGREEMENT', 'Трудовое соглашение');
INSERT INTO hire_types (id, description)
VALUES ('DISMISSED', 'Уволен');

INSERT INTO product_groups (id, name)
VALUES ('ac2a862a9f8440d597b8c4188b07c4ed', 'Чай');
INSERT INTO product_groups (id, name)
VALUES ('9fca6f4e5e3547d6b59b2325c2fa3fe7', 'Кофе');
INSERT INTO product_groups (id, name)
VALUES ('2107053f62f4401f9e1ef19a2039fa0b', 'Безалкогольные напитки');
INSERT INTO product_groups (id, name)
VALUES ('02855ed032a24415a37f942d4b99cb5a', 'Хлебо-булочные изделия');
INSERT INTO product_groups (id, name)
VALUES ('043dd2bbe1524149bf13eb5ae9dde160', 'Кондитерские изделия');

INSERT INTO positions (id, name, manager_id)
VALUES ('CHIEF', 'Директор', NULL);
INSERT INTO positions (id, name, manager_id)
VALUES ('CHIEF_ACCOUNTANT', 'Главный бухгалтер', '04c65c28e4d64dda9439ddfddac7c483');
INSERT INTO positions (id, name, manager_id)
VALUES ('ACCOUNTANT', 'Бухгалтер', '95a4485b7c7143fba582843a704a376e');
INSERT INTO positions (id, name, manager_id)
VALUES ('CASHIER', 'Кассир', '95a4485b7c7143fba582843a704a376e');
INSERT INTO positions (id, name, manager_id)
VALUES ('AGENT', 'Агент', '691c029458c54db0ac2809584f7c8b43');
INSERT INTO positions (id, name, manager_id)
VALUES ('COURIER', 'Курьер', 'a6e61e149d9149bb846ade9d23353fa5');
INSERT INTO positions (id, name, manager_id)
VALUES ('MANAGER', 'Менеджер', '04c65c28e4d64dda9439ddfddac7c483');
INSERT INTO positions (id, name, manager_id)
VALUES ('SELLER', 'Продавец', 'a6e61e149d9149bb846ade9d23353fa5');

INSERT INTO units (id, name)
VALUES ('UNIT','штука');
INSERT INTO units (id, name)
VALUES ('PACKING','упаковка');
INSERT INTO units (id, name)
VALUES ('PACK','пачка');
INSERT INTO units (id, name)
VALUES ('BOTTLE_05','бутылка 0.5 л.');
INSERT INTO units (id, name)
VALUES ('BOTTLE_033','бутылка 0.33 л.');
INSERT INTO units (id, name)
VALUES ('BOX','коробка');
INSERT INTO units (id, name)
VALUES ('CRATE','ящик');
INSERT INTO units (id, name)
VALUES ('TIN_POT','банка, жесть');
INSERT INTO units (id, name)
VALUES ('GLASS_POT','банка, стекло');

INSERT INTO products (id, description, product_group_id, unit_id, weight, cost, quantity)
VALUES('cc873c2777004d4ea4c8569feb6bb93f','Принцесса Нури','ac2a862a9f8440d597b8c4188b07c4ed','PACK','0.1','12','100');
INSERT INTO products (id, description, product_group_id, unit_id, weight, cost, quantity)
VALUES('9ab182189692413da489f8857966a437','Принцесса Гита','ac2a862a9f8440d597b8c4188b07c4ed','PACK','0.1','11','68');
INSERT INTO products (id, description, product_group_id, unit_id, weight, cost, quantity)
VALUES('4911b1d6a1ae45a28f513051d7338351','Принцесса Ява','ac2a862a9f8440d597b8c4188b07c4ed','PACK','0.25','12','80');
INSERT INTO products (id, description, product_group_id, unit_id, weight, cost, quantity)
VALUES('43d2d576ee8149ee8f1afa254f060538','Остров Цейлон','ac2a862a9f8440d597b8c4188b07c4ed','PACK','0.1','20','0');
INSERT INTO products (id, description, product_group_id, unit_id, weight, cost, quantity)
VALUES('d28cfd5e10144214ab09c37be1771202','Нескафе Классик','9fca6f4e5e3547d6b59b2325c2fa3fe7','TIN_POT','0.05','52','25');
INSERT INTO products (id, description, product_group_id, unit_id, weight, cost, quantity)
VALUES('6992f73e4c5d4180bb6eca0471be60f4','Нескафе Голд','9fca6f4e5e3547d6b59b2325c2fa3fe7','TIN_POT','0.25','110','80');
INSERT INTO products (id, description, product_group_id, unit_id, weight, cost, quantity)
VALUES('9ee3e7acf6114eb9b9fb5eb4dbfad0d9','Чибо','9fca6f4e5e3547d6b59b2325c2fa3fe7','GLASS_POT','0.05','42','120');
INSERT INTO products (id, description, product_group_id, unit_id, weight, cost, quantity)
VALUES('459b52b62fcf431cb9a0344d47c3430d','конфеты "Родные просторы"','043dd2bbe1524149bf13eb5ae9dde160','BOX','0.2','40','65');
INSERT INTO products (id, description, product_group_id, unit_id, weight, cost, quantity)
VALUES('d1123ce97531457982726af7bb767a78','шоколад "Вдохновени"','043dd2bbe1524149bf13eb5ae9dde160','PACK','0.1','10','250');
INSERT INTO products (id, description, product_group_id, unit_id, weight, cost, quantity)
VALUES('5f654c635a1b42cd85cd6bbb48f2f9e6','конфеты "Ассорти"','043dd2bbe1524149bf13eb5ae9dde160','BOX','0.25','40','0');
INSERT INTO products (id, description, product_group_id, unit_id, weight, cost, quantity)
VALUES('b35da2df57fc4061b46560c29dbdcb64','конфеты "Вечерняя Москва"','043dd2bbe1524149bf13eb5ae9dde160','BOX','0.8','50','12');
INSERT INTO products (id, description, product_group_id, unit_id, weight, cost, quantity)
VALUES('8e1759f3a1bc4856a6a87e1b04845a08','шоколад "Жигули"','043dd2bbe1524149bf13eb5ae9dde160','PACK','0.1','8','50');
INSERT INTO products (id, description, product_group_id, unit_id, weight, cost, quantity)
VALUES('cb254f7ecb1a40bb8b68a552bddeeaeb','конфеты "Монпасье"','043dd2bbe1524149bf13eb5ae9dde160','PACKING','0.2','25','0');
INSERT INTO products (id, description, product_group_id, unit_id, weight, cost, quantity)
VALUES('e14d2ced9be849f08a1c111da98fa24b','печенье "Уикенд"','043dd2bbe1524149bf13eb5ae9dde160','PACK','0.1','12','35');
INSERT INTO products (id, description, product_group_id, unit_id, weight, cost, quantity)
VALUES('b96d685c96c44ab4bcd8c4b212b78895','кекс Абрикосовый','043dd2bbe1524149bf13eb5ae9dde160','UNIT','0.2','24','12');
INSERT INTO products (id, description, product_group_id, unit_id, weight, cost, quantity)
VALUES('190d93bc7d874908b5ae8a738b254b98','печенье Ванильное','043dd2bbe1524149bf13eb5ae9dde160','PACK','0.1','12','20');
INSERT INTO products (id, description, product_group_id, unit_id, weight, cost, quantity)
VALUES('e7b27ac5aa3741ef89f49c3e8372f8ff','Кока-Кола','2107053f62f4401f9e1ef19a2039fa0b','BOTTLE_033',NULL,'8','0');
INSERT INTO products (id, description, product_group_id, unit_id, weight, cost, quantity)
VALUES('bb1d2dd577ef41b79f8553da6175b0ce','Лимонад','2107053f62f4401f9e1ef19a2039fa0b','BOTTLE_05',NULL,'6','40');
INSERT INTO products (id, description, product_group_id, unit_id, weight, cost, quantity)
VALUES('c9ffb3b096f1490e81bd2d6e58cee6f1','Пепси-Кола','2107053f62f4401f9e1ef19a2039fa0b','BOTTLE_033',NULL,'8','45');

INSERT INTO employees (id, last_name, first_name, father_name, gender, birth_date, marriage, postal_index, address, position, hire_type, notes)
VALUES ('04c65c28e4d64dda9439ddfddac7c483','Иванов',' Иван','Иванович','М','25.12.1959','TRUE','644050','проезд Ильича, 12-3','CHIEF','CONST','Босс');
INSERT INTO employees (id, last_name, first_name, father_name, gender, birth_date, marriage, postal_index, address, position, hire_type, notes)
VALUES ('95a4485b7c7143fba582843a704a376e','Кузнецова','Тамара','Ивановна','Ж','30.08.1969','TRUE','644042','Спортивный Проезд, 2-21','CHIEF_ACCOUNTANT','CONST','');
INSERT INTO employees (id, last_name, first_name, father_name, gender, birth_date, marriage, postal_index, address, position, hire_type, notes)
VALUES ('ebb729718f614ca39d5c3ed7c9400328','Петрова','Светлана','Сергеевна','Ж','14.02.1975','FALSE','644065','ул. Володарская, 22-123','ACCOUNTANT','CONST','');
INSERT INTO employees (id, last_name, first_name, father_name, gender, birth_date, marriage, postal_index, address, position, hire_type, notes)
VALUES ('6ee3de354976482ca25b8d88d674f005','Сидоров','Петр','Сергеевич','М','25.05.1968','TRUE','644008','ул. Зеленая, 77-5','SELLER','TEMP','имеет опыт работы, хорошие рекомендации');
INSERT INTO employees (id, last_name, first_name, father_name, gender, birth_date, marriage, postal_index, address, position, hire_type, notes)
VALUES ('691c029458c54db0ac2809584f7c8b43','Долгих','Зинаида','Васильевна','Ж','23.11.1971','TRUE','644111','проспект Космонавтов, д3/2, кв.230','MANAGER','CONST','');
INSERT INTO employees (id, last_name, first_name, father_name, gender, birth_date, marriage, postal_index, address, position, hire_type, notes)
VALUES ('43b386f354a444cebd3d3a41943c639f','Сидоров','Антон','Прокопьевич','М','28.02.1949','FALSE','644044','ул. Строителей, 12-24','AGENT','CONST','');
INSERT INTO employees (id, last_name, first_name, father_name, gender, birth_date, marriage, postal_index, address, position, hire_type, notes)
VALUES ('a6e61e149d9149bb846ade9d23353fa5','Воронин','Сергей','Александрович','М','12.12.1969','TRUE','644027','ул. Родионова, 34','AGENT','TEMP','');
INSERT INTO employees (id, last_name, first_name, father_name, gender, birth_date, marriage, postal_index, address, position, hire_type, notes)
VALUES ('35ae930259244b70ac85940e453852df','Прохоренко','Михаил','Васильевич','М','07.06.1944','TRUE','644080','ул. Светлая, 4, корпус 2, кв. 13','AGENT','CONST','');
INSERT INTO employees (id, last_name, first_name, father_name, gender, birth_date, marriage, postal_index, address, position, hire_type, notes)
VALUES ('e6fd9c0d6e7d4255849ef340140fbf79','Фролова','Вероника','Станиславовна','Ж','17.09.1976','FALSE','644013','ул. Новая, д. 4, кв. 53','CASHIER','TEMP','');
INSERT INTO employees (id, last_name, first_name, father_name, gender, birth_date, marriage, postal_index, address, position, hire_type, notes)
VALUES ('61e6455900e642b1a5df11853713df92','Яковлев','Евгений','Васильевич','М','25.04.1970','FALSE','644045','ул. Молодежная, 33а, кв. 118','COURIER','TEMP','');

INSERT INTO children (id, employee_id, last_name, first_name, father_name, gender, birth_date)
VALUES ('8d4dbc6e26fc4bc5bc6fa2742f85bf4e', '95a4485b7c7143fba582843a704a376e', 'Кузнецов', 'Сергей', 'Леонидович', 'М', '12.08.1993');
INSERT INTO children (id, employee_id, last_name, first_name, father_name, gender, birth_date)
VALUES ('f284c884bb4d4cf7bb31d84c86d5b51e', 'ebb729718f614ca39d5c3ed7c9400328', 'Петров', 'Станислав', 'Сергеевич', 'М', '21.04.1998');
INSERT INTO children (id, employee_id, last_name, first_name, father_name, gender, birth_date)
VALUES ('77c48d68148643698969adbc1d9e6c50', '61e6455900e642b1a5df11853713df92', 'Яковлев', 'Иван', 'Евгеньевич', 'М', '30.04.1989');
INSERT INTO children (id, employee_id, last_name, first_name, father_name, gender, birth_date)
VALUES ('ac17323ecd014510951cddd15449929b', '61e6455900e642b1a5df11853713df92', 'Яковлева', 'Надежда', 'Евгеньевна', 'Ж', '24.09.1991');
INSERT INTO children (id, employee_id, last_name, first_name, father_name, gender, birth_date)
VALUES ('38ba48babee4435db9d0159d028a69c7', '35ae930259244b70ac85940e453852df', 'Прохоренко', 'Сергей', 'Михайлович', 'М', '22.10.1970');

INSERT INTO clients (id, name, checking_account, INN)
VALUES ('f20464cb2c6b4f8db1dd3cef77ea2e35','ООО "Рога и копыта"','407002545448948','3245001416');
INSERT INTO clients (id, name, checking_account, INN)
VALUES ('0b027250e1e14a5c887ec462f1a2d875','магазин "Колос"','407002545448949','5612072836');
INSERT INTO clients (id, name, checking_account, INN)
VALUES ('10eb0fdc33784f35b7855332c6f54ddb','кафе "Три толстяка"','407002545448950','6154102109');
INSERT INTO clients (id, name, checking_account, INN)
VALUES ('2963c311fa64492dac12a7916f01e963','КФХ А. А. Соснов','407002545448951','4628001814');
INSERT INTO clients (id, name, checking_account, INN)
VALUES ('26007c7423c346b4be6294855275056b','магазин "Оазис"','407002545448952','7420009721');
INSERT INTO clients (id, name, checking_account, INN)
VALUES ('900ee4da4b2c4b54a3b66ab01c1ccdee','ЗАО "Дебют"','407002545448953','7808029483');
INSERT INTO clients (id, name, checking_account, INN)
VALUES ('4c288a239fb14f27a03925be33c9a410','ООО "Фролов и К."','407002545448954','7732017742');

INSERT INTO phone_numbers (employee_id, phone_number, phone_type)
VALUES ('04c65c28e4d64dda9439ddfddac7c483', '3812224584', 'HOME');
INSERT INTO phone_numbers (employee_id, phone_number, phone_type)
VALUES ('04c65c28e4d64dda9439ddfddac7c483', '3812440484', 'WORK');
INSERT INTO phone_numbers (employee_id, phone_number, phone_type)
VALUES ('04c65c28e4d64dda9439ddfddac7c483', '3812445230', 'WORK');
INSERT INTO phone_numbers (employee_id, phone_number, phone_type)
VALUES ('95a4485b7c7143fba582843a704a376e', '3812440412', 'WORK');
INSERT INTO phone_numbers (employee_id, phone_number, phone_type)
VALUES ('ebb729718f614ca39d5c3ed7c9400328', '3812440412', 'WORK');
INSERT INTO phone_numbers (employee_id, phone_number, phone_type)
VALUES ('6ee3de354976482ca25b8d88d674f005', '3812130054', 'HOME');
INSERT INTO phone_numbers (employee_id, phone_number, phone_type)
VALUES ('691c029458c54db0ac2809584f7c8b43', '3812440421', 'WORK');
INSERT INTO phone_numbers (employee_id, phone_number, phone_type)
VALUES ('691c029458c54db0ac2809584f7c8b43', '3812258552', 'HOME');
INSERT INTO phone_numbers (employee_id, phone_number, phone_type)
VALUES ('a6e61e149d9149bb846ade9d23353fa5', '218754', 'HOME');
INSERT INTO phone_numbers (employee_id, phone_number, phone_type)
VALUES ('35ae930259244b70ac85940e453852df', '258534', 'HOME');
INSERT INTO phone_numbers (employee_id, phone_number, phone_type)
VALUES ('e6fd9c0d6e7d4255849ef340140fbf79', '142514', 'HOME');

INSERT INTO orders (id, order_date, product_id, quantity, client_id, employee_id, finished)
VALUES ('fa93fb0fb1ca4bbfb7e9dd7a57c40cca','07.04.2001','cc873c2777004d4ea4c8569feb6bb93f','24','f20464cb2c6b4f8db1dd3cef77ea2e35','a6e61e149d9149bb846ade9d23353fa5','TRUE');
INSERT INTO orders (id, order_date, product_id, quantity, client_id, employee_id, finished)
VALUES ('eed48e5434154394af11b679b93b6561','07.04.2001','d28cfd5e10144214ab09c37be1771202','20','10eb0fdc33784f35b7855332c6f54ddb','04c65c28e4d64dda9439ddfddac7c483','FALSE');
INSERT INTO orders (id, order_date, product_id, quantity, client_id, employee_id, finished)
VALUES ('48bd337e8efd48d69c44f40db6b326f1','06.05.2001','e7b27ac5aa3741ef89f49c3e8372f8ff','12','26007c7423c346b4be6294855275056b','35ae930259244b70ac85940e453852df','FALSE');
INSERT INTO orders (id, order_date, product_id, quantity, client_id, employee_id, finished)
VALUES ('73c2edcb49ac4994b39eaa028c8bf70b','10.05.2001','e7b27ac5aa3741ef89f49c3e8372f8ff','20','0b027250e1e14a5c887ec462f1a2d875','35ae930259244b70ac85940e453852df','FALSE');
INSERT INTO orders (id, order_date, product_id, quantity, client_id, employee_id, finished)
VALUES ('ac6523c0d5184efe90908b4bea5d8989','10.05.2001','bb1d2dd577ef41b79f8553da6175b0ce','45','26007c7423c346b4be6294855275056b','ebb729718f614ca39d5c3ed7c9400328','FALSE');
INSERT INTO orders (id, order_date, product_id, quantity, client_id, employee_id, finished)
VALUES ('b9cce5a2d8444843baaa6d23a9514aff','10.05.2001','d28cfd5e10144214ab09c37be1771202','10','10eb0fdc33784f35b7855332c6f54ddb', '35ae930259244b70ac85940e453852df','FALSE');
INSERT INTO orders (id, order_date, product_id, quantity, client_id, employee_id, finished)
VALUES ('c4a81e7799574b0e8b42586a2787f479','24.05.2000','8e1759f3a1bc4856a6a87e1b04845a08','24','26007c7423c346b4be6294855275056b','43b386f354a444cebd3d3a41943c639f','TRUE');
INSERT INTO orders (id, order_date, product_id, quantity, client_id, employee_id, finished)
VALUES ('b8345a012f244af7981893c277c23060','24.05.2000','e14d2ced9be849f08a1c111da98fa24b','13','f20464cb2c6b4f8db1dd3cef77ea2e35','43b386f354a444cebd3d3a41943c639f','TRUE');
INSERT INTO orders (id, order_date, product_id, quantity, client_id, employee_id, finished)
VALUES ('3c4a8923d25a460a8f35bed51f41dbf7','28.05.2000','190d93bc7d874908b5ae8a738b254b98','6','f20464cb2c6b4f8db1dd3cef77ea2e35','35ae930259244b70ac85940e453852df','FALSE');
INSERT INTO orders (id, order_date, product_id, quantity, client_id, employee_id, finished)
VALUES ('60f72b6f1c8042d0b594743b05480239','28.05.2000','43d2d576ee8149ee8f1afa254f060538','44','2963c311fa64492dac12a7916f01e963','43b386f354a444cebd3d3a41943c639f','TRUE');
INSERT INTO orders (id, order_date, product_id, quantity, client_id, employee_id, finished)
VALUES ('d6957d5ce3b0433281b2c21663883b0b','28.04.2001','6992f73e4c5d4180bb6eca0471be60f4','12','2963c311fa64492dac12a7916f01e963','6ee3de354976482ca25b8d88d674f005','FALSE');
INSERT INTO orders (id, order_date, product_id, quantity, client_id, employee_id, finished)
VALUES ('0e11365ebfc34727b7609d6a394d0ea1','28.04.2001','b35da2df57fc4061b46560c29dbdcb64','50','f20464cb2c6b4f8db1dd3cef77ea2e35','61e6455900e642b1a5df11853713df92','FALSE');
INSERT INTO orders (id, order_date, product_id, quantity, client_id, employee_id, finished)
VALUES ('f68b0242475542b6a2dce787170292c6','29.05.1999','5f654c635a1b42cd85cd6bbb48f2f9e6','24','900ee4da4b2c4b54a3b66ab01c1ccdee','35ae930259244b70ac85940e453852df','FALSE');
INSERT INTO orders (id, order_date, product_id, quantity, client_id, employee_id, finished)
VALUES ('9388d49cf62e44ed8c11ac49310a8aaf','01.03.2001','e14d2ced9be849f08a1c111da98fa24b','26','4c288a239fb14f27a03925be33c9a410','6ee3de354976482ca25b8d88d674f005','FALSE');
INSERT INTO orders (id, order_date, product_id, quantity, client_id, employee_id, finished)
VALUES ('1dcb9e7f4f3b415384e0d570db4a1484','01.03.2001','b35da2df57fc4061b46560c29dbdcb64','32','4c288a239fb14f27a03925be33c9a410','43b386f354a444cebd3d3a41943c639f','TRUE');
INSERT INTO orders (id, order_date, product_id, quantity, client_id, employee_id, finished)
VALUES ('8b63d1aa8ef8441abd70f7533d14ed3e','01.03.2001','b96d685c96c44ab4bcd8c4b212b78895','23','10eb0fdc33784f35b7855332c6f54ddb','a6e61e149d9149bb846ade9d23353fa5','FALSE');
INSERT INTO orders (id, order_date, product_id, quantity, client_id, employee_id, finished)
VALUES ('fef14e3b1e414ef4a47ef1136cc95e1c','06.03.2001','6992f73e4c5d4180bb6eca0471be60f4','23','4c288a239fb14f27a03925be33c9a410','35ae930259244b70ac85940e453852df','FALSE');
INSERT INTO orders (id, order_date, product_id, quantity, client_id, employee_id, finished)
VALUES ('ee38b24a8b9b406f9f49ef252aacc43b','06.03.2001','e7b27ac5aa3741ef89f49c3e8372f8ff','11','0b027250e1e14a5c887ec462f1a2d875','43b386f354a444cebd3d3a41943c639f','FALSE');
INSERT INTO orders (id, order_date, product_id, quantity, client_id, employee_id, finished)
VALUES ('f3509b9dd5a94576836089945fc4609c','01.04.2001','b35da2df57fc4061b46560c29dbdcb64','12','f20464cb2c6b4f8db1dd3cef77ea2e35','a6e61e149d9149bb846ade9d23353fa5','FALSE');
INSERT INTO orders (id, order_date, product_id, quantity, client_id, employee_id, finished)
VALUES ('552758c046ae4c39ba2de737edb37b30','06.03.2001','b96d685c96c44ab4bcd8c4b212b78895','20','900ee4da4b2c4b54a3b66ab01c1ccdee','43b386f354a444cebd3d3a41943c639f','TRUE');
INSERT INTO orders (id, order_date, product_id, quantity, client_id, employee_id, finished)
VALUES ('6db57d5702694cb8a40b4740782e00ca','01.04.2001','e7b27ac5aa3741ef89f49c3e8372f8ff','41','2963c311fa64492dac12a7916f01e963','61e6455900e642b1a5df11853713df92','TRUE');
INSERT INTO orders (id, order_date, product_id, quantity, client_id, employee_id, finished)
VALUES ('21313bff22c24db7ab3a3674339c887b','07.03.2001','cb254f7ecb1a40bb8b68a552bddeeaeb','23','4c288a239fb14f27a03925be33c9a410','61e6455900e642b1a5df11853713df92','FALSE');
INSERT INTO orders (id, order_date, product_id, quantity, client_id, employee_id, finished)
VALUES ('631b4708286442d6a97f1bbcdafb383d','07.03.2001','e7b27ac5aa3741ef89f49c3e8372f8ff','52','0b027250e1e14a5c887ec462f1a2d875','43b386f354a444cebd3d3a41943c639f','FALSE');
INSERT INTO orders (id, order_date, product_id, quantity, client_id, employee_id, finished)
VALUES ('7b8ba05557d4461b9ff4ecad505e61bb','07.03.2001','cc873c2777004d4ea4c8569feb6bb93f','20','f20464cb2c6b4f8db1dd3cef77ea2e35','04c65c28e4d64dda9439ddfddac7c483','TRUE');