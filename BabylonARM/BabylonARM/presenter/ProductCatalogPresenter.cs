using BabylonARM.dao;
using BabylonARM.dto;
using BabylonARM.view;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;

namespace BabylonARM.presenter
{
    public class ProductCatalogPresenter
    {
        private ProductsDao productDao;
        private ProductCatalog view;
        private List<Product> cached = new List<Product>();
        private String filter = "";

        public ProductCatalogPresenter(ProductCatalog view)
        {
            if (view == null)
            {
                throw new ArgumentException("Представление не инициализировано");
            }
            productDao = new ProductsDao();
            this.view = view;
        }

        //Загрузка списка товаров
        public void loadProducts()
        {
            cached = productDao.getList();
            displayResult();
        }
        //Фильтрация списка товаров
        public void filterWith(String value)
        {
            filter = value.ToLower();
            displayResult();
        }
        
        private void displayResult()
        {
            if (!String.IsNullOrWhiteSpace(filter))
            {
                List<Product> filtered = new List<Product>();
                foreach (Product p in cached)
                {
                    if (p.Name.ToLower().Contains(filter))
                    {
                        filtered.Add(p);
                    }
                }
                view.displayProducts(new ReadOnlyCollection<Product>(filtered));
            } else
            {
                view.displayProducts(new ReadOnlyCollection<Product>(cached));
            }
        }
        //Сохранение данных по товару
        public void save(Product product)
        {
            if (productDao.update(product))
            {
                view.NotifyUser("Сохранение успешно");
            }
        }
        //Удаление товара
        public void delete(Product product)
        {
            if (productDao.delete(product.Id))
            {
                view.NotifyUser("Удаление успешно");
            }
        }
    }
}
