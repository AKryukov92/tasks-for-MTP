using BabylonARM.dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Npgsql;
using NpgsqlTypes;


namespace BabylonARM.dao
{
    public class ProductsDao
    {
        private static String GET_LIST_CMD =
@"SELECT
productid,
description,
productgroupid,
unitid,
weight,
cost,
quantity 
FROM products;";

        private static String GET_SINGLE_CMD =
    @"SELECT
productid,
description,
productgroupid,
unitid,
weight,
cost,
quantity 
FROM products WHERE productid=:id;";

        private static String INSERT_CMD =
    @"INSERT INTO products(productid, description, productgroupid, unitid, weight, cost, quantity)
VALUES (:id, :desc, :groupid, :unitid, :weight, :cost, :quantity);";

        private static String UPDATE_CMD =
    @"UPDATE products
SET productgroupid = :groupid,
desc = :desc,
unitid = :unitid,
weight = :weight,
cost = :cost,
quantity = :quantity
WHERE productid = :id;";

        private static String DELETE_CMD =
    @"DELETE FROM products WHERE productid = :id";

        private static String GET_ORDERS_COUNT_CMD =
@"SELECT count(*)
FROM orders
WHERE productid = :pid";
        
        public List<Product> getList()
        {
            NpgsqlConnection connection = new NpgsqlConnection("Host=localhost;Username=business;Password=business;Database=business");
            connection.Open();
            NpgsqlCommand cmd = new NpgsqlCommand(GET_LIST_CMD, connection);
            List<Product> result = new List<Product>();//Коллекция для хранения результата
            var reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                //Конструируем объект из данных в текущей строке
                Product temp = new Product(reader.GetGuid(0));//Получаем значение типа GUID из первой колонки
                temp.Name = reader.GetString(1);//Получаем строковое значение из второй колонки
                temp.GroupId = reader.GetGuid(2);
                temp.Unit = reader.GetString(3);
                if (!reader.IsDBNull(4))
                {
                    temp.Weight = reader.GetFloat(4);//Получаем дробное значение из пятой колонки
                }
                temp.Cost = reader.GetDecimal(5);
                temp.Quantity = reader.GetInt32(6);//Получаем целое значение из седьмой колонки
                result.Add(temp);//Добавляем сконструированный объект к результату
            }
            connection.Close();
            return result;
        }

        public Product getById(Guid id)
        {
            if (Guid.Parse("cc873c2777004d4ea4c8569feb6bb93f").Equals(id))
            {
                return new Product(Guid.Parse("cc873c2777004d4ea4c8569feb6bb93f"))
                {
                    Name = "Принцесса Нури",
                    GroupId = Guid.Parse("ac2a862a9f8440d597b8c4188b07c4ed"),
                    Unit = "PACK",
                    Weight = 0.1f,
                    Cost = 12m,
                    Quantity = 100
                };
            }
            if (Guid.Parse("d28cfd5e10144214ab09c37be1771202").Equals(id))
            {
                return new Product(Guid.Parse("d28cfd5e10144214ab09c37be1771202"))
                {
                    Name = "Нескафе Классик",
                    GroupId = Guid.Parse("9fca6f4e5e3547d6b59b2325c2fa3fe7"),
                    Unit = "TIN_POT",
                    Weight = 0.05f,
                    Cost = 52m,
                    Quantity = 25
                };
            }
            if (Guid.Parse("b96d685c96c44ab4bcd8c4b212b78895").Equals(id))
            {
                return new Product(Guid.Parse("b96d685c96c44ab4bcd8c4b212b78895"))
                {
                    Name = "кекс Абрикосовый",
                    GroupId = Guid.Parse("043dd2bbe1524149bf13eb5ae9dde160"),
                    Unit = "UNIT",
                    Weight = 0.2f,
                    Cost = 24m,
                    Quantity = 12
                };
            }
            return null;
        }
        
        public bool insert(Product p)
        {
            NpgsqlConnection connection = new NpgsqlConnection("Host=localhost;Username=business;Password=business;Database=business");
            connection.Open();
            NpgsqlCommand cmd = new NpgsqlCommand(INSERT_CMD, connection);
            cmd.Parameters.Add(new NpgsqlParameter(":id", NpgsqlDbType.Uuid) { Value = Guid.NewGuid() });
            cmd.Parameters.Add(new NpgsqlParameter(":desc", NpgsqlDbType.Text) { Value = p.Name });
            cmd.Parameters.Add(new NpgsqlParameter(":groupid", NpgsqlDbType.Uuid) { Value = p.GroupId });
            cmd.Parameters.Add(new NpgsqlParameter(":unitid", NpgsqlDbType.Text) { Value = p.Unit });
            cmd.Parameters.Add(new NpgsqlParameter(":weight", NpgsqlDbType.Real) { Value = p.Weight });
            cmd.Parameters.Add(new NpgsqlParameter(":cost", NpgsqlDbType.Money) { Value = p.Cost });
            cmd.Parameters.Add(new NpgsqlParameter(":quantity", NpgsqlDbType.Integer) { Value = p.Quantity });
            bool result = cmd.ExecuteNonQuery() == 1;//Проверяется количество измененных строк
            connection.Close();//Закрывается подключение
            return result;
            //Если вставилось 0 строк, значит запрос выполнился некорректно
        }

        public bool delete(Guid id)
        {
            NpgsqlConnection connection = new NpgsqlConnection("Host=localhost;Username=business;Password=business;Database=business");
            connection.Open();
            NpgsqlTransaction transaction = connection.BeginTransaction();//Создаем новую транзакцию
            //Готовим команду для получения количества заказов
            NpgsqlCommand getOrdersCmd = new NpgsqlCommand(GET_ORDERS_COUNT_CMD, connection);
            getOrdersCmd.Parameters.Add(new NpgsqlParameter(":pid", NpgsqlDbType.Uuid) { Value = id });
            //Запрос возвращает одну строчку и одну колонку, поэтому подходит такой вариант вызова
            int count = (int)getOrdersCmd.ExecuteScalar();
            if (count > 0)//Если заказы есть
            {
                transaction.Rollback();//Откатываем транзакцию
                connection.Close();//Закрываем подключение
                return false;//Сообщаем результат
            }
            NpgsqlCommand cmd = new NpgsqlCommand(DELETE_CMD, connection);
            cmd.Parameters.Add(new NpgsqlParameter(":id", NpgsqlDbType.Uuid) { Value = id });
            bool result = cmd.ExecuteNonQuery() == 1;
            transaction.Commit();
            connection.Close();
            return result;
        }

        public bool update(Product p)
        {
            NpgsqlConnection connection = new NpgsqlConnection("Host=localhost;Username=business;Password=business;Database=business");
            connection.Open();
            NpgsqlCommand cmd = new NpgsqlCommand(UPDATE_CMD, connection);
            cmd.Parameters.Add(new NpgsqlParameter(":id", NpgsqlDbType.Uuid) { Value = p.Id });
            cmd.Parameters.Add(new NpgsqlParameter(":desc", NpgsqlDbType.Text) { Value = p.Name });
            cmd.Parameters.Add(new NpgsqlParameter(":groupid", NpgsqlDbType.Uuid) { Value = p.GroupId });
            cmd.Parameters.Add(new NpgsqlParameter(":unitid", NpgsqlDbType.Text) { Value = p.Unit });
            cmd.Parameters.Add(new NpgsqlParameter(":weight", NpgsqlDbType.Real) { Value = p.Weight });
            cmd.Parameters.Add(new NpgsqlParameter(":cost", NpgsqlDbType.Money) { Value = p.Cost });
            cmd.Parameters.Add(new NpgsqlParameter(":quantity", NpgsqlDbType.Integer) { Value = p.Quantity });
            bool result = cmd.ExecuteNonQuery() == 1;
            connection.Close();
            return result;
        }
    }
}