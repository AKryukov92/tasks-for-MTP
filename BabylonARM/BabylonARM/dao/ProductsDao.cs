using BabylonARM.dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BabylonARM.dao
{
    public class ProductsDao
    {
        private String connectionString;

        public ProductsDao(String connectionString)
        {
            this.connectionString = connectionString;
        }

        public List<Product> getList()
        {
            List<Product> products = new List<Product>();
            Product p1 = new Product("AF0A356792254ACB920A51DB95F224DB", Units.FromDbName("BOX"), 123432);
            p1.Name = "Носки";
            p1.Cost = 25;
            products.Add(p1);
            Product p2 = new Product("8ed9324be08f44bfb0f2051d459fc113", Units.FromDbName("UNIT"), 12000);
            p2.Cost = 250;
            p2.Name = "Свитер";
            products.Add(p2);
            return products;
        }

        public Product getById(String id)
        {
            if (id.Equals("A94C6CC3999845E7ADDF3BEE18F7302D"))
            {
                Product p = new Product("A94C6CC3999845E7ADDF3BEE18F7302D", Units.FromDbName("BOX"), 1020);
                p.Name = "Кроссовки";
                p.Cost = 213;
                return p;
            }
            return null;
        }

        public bool insert(Product p)
        {
            String unitdbName = p.Unit.ToString();
            return true;
        }

        public bool delete(Product p)
        {
            return true;
        }

        public bool update(Product p)
        {
            return true;
        }
    }
}
