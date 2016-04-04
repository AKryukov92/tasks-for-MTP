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
        private static String GET_LIST_CMD = @"SELECT
productid,
description,
productgroupid,
unitid,
weight,
cost,
quantity 
FROM products;";

        private static String GET_SINGLE_CMD = @"SELECT
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

        private String connectionString;

        public ProductsDao(String connectionString)
        {
            this.connectionString = connectionString;
        }

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
                Product temp = new Product();
                temp.Id = reader.GetGuid(0);//Получаем значение типа GUID из первой колонки
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

        public Product getById(String id)
        {
            return null;
        }

        public bool insert(Product p)
        {
            NpgsqlConnection connection = new NpgsqlConnection("Host=localhost;Username=business;Password=business;Database=business");
            connection.Open();
            NpgsqlCommand cmd = new NpgsqlCommand(INSERT_CMD, connection);
            cmd.Parameters.Add(
                //Используется конструктор с одновременной инициализацией поля Value
                new NpgsqlParameter(":id", NpgsqlDbType.Uuid) { Value = p.Id }
                );
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
            NpgsqlCommand cmd = new NpgsqlCommand(DELETE_CMD, connection);
            cmd.Parameters.Add(new NpgsqlParameter(":id", NpgsqlDbType.Uuid) { Value = id });
            bool result = cmd.ExecuteNonQuery() == 1;
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