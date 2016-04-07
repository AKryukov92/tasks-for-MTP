using BabylonARM.dao;
using BabylonARM.dto;
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
        private bool processAdd = false;

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
            displayFilteredProducts();
        }
        //Фильтрация списка товаров
        public void filterWith(String value)
        {
            filter = value.ToLower();
            displayFilteredProducts();
        }
        
        private void displayFilteredProducts()
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
                view.clearFields();
                view.displayProducts(new ReadOnlyCollection<Product>(filtered));
            }
            else
            {
                view.clearFields();
                view.displayProducts(new ReadOnlyCollection<Product>(cached));
            }
        }

        //Начало добавления товара
        public void beginAdd()
        {
            processAdd = true;
            view.clearFields();
            view.lockForAdd();
        }

        //Отмена добавления товара
        public void cancelAdd()
        {
            processAdd = false;
            view.unlock();
        }

        //Сохранение данных по товару
        public void save(Product selected, String name, String unit, Decimal cost, int quantity, float weight, Guid productGroupId)
        {
            if (processAdd)//Если происходит процесс добавления товара
            {
                //Создаем новый экземпляр
                Product p = new Product(Guid.NewGuid())
                {
                    Name = name,
                    Unit = unit,
                    Cost = cost,
                    Quantity = quantity,
                    Weight = weight,
                    GroupId = productGroupId
                };
                //Вставляем в базу
                if (productDao.insert(p))
                {
                    //Добавляем товар в список товаров "из базы"
                    cached.Add(p);
                    view.clearFields();
                    displayFilteredProducts();
                    //Сообщаем пользователю о том, что товар добавлен успешно
                    view.NotifyUser("Добавление товара успешно");
                }
                view.unlock();
                processAdd = false;
            }
            else//В остальных случаях считаем, что товар редактируется
            {
                if (selected == null)
                {
                    view.NotifyUser("Выберите продукт для изменения");
                    return;
                }
                //Переписываем значения полей
                selected.Name = name;
                selected.Unit = unit;
                selected.Cost = cost;
                selected.Quantity = quantity;
                selected.Weight = weight;
                selected.GroupId = productGroupId;
                //Обновляем в базе
                if (productDao.update(selected))
                {
                    view.NotifyUser("Сохранение успешно");
                    view.clearFields();
                    displayFilteredProducts();
                }
            }
        }

        //Удаление товара
        public void delete(Product product)
        {
            if (product == null)
            {
                view.NotifyUser("Выберите продукт для удаления.");
                return;
            }
                
            if (productDao.delete(product.Id))
            {
                cached.Remove(product);
                view.clearFields();
                displayFilteredProducts();
                view.NotifyUser("Удаление успешно");
            }
        }
    }
}
