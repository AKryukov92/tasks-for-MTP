using BabylonARM.dto;
using BabylonARM.presenter;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace BabylonARM
{
    public partial class ProductCatalog : Form
    {
        private ProductCatalogPresenter presenter;

        public ProductCatalog()
        {
            InitializeComponent();
            presenter = new ProductCatalogPresenter(this);
        }

        //Методы для презентера
        //Отображение списка товаров
        public void displayProducts(IList<Product> value)
        {
            listProducts.DataSource = value;
        }

        //Метод для блокирования элементов управления при начале добавления товара
        public void lockForAdd()
        {
            listProducts.Enabled = false;
            txtFilter.Enabled = false;
            btnRefresh.Enabled = false;
            btnAdd.Enabled = false;
            btnDelete.Enabled = false;

            btnCancel.Enabled = true;
        }

        //Метод для разблокирования элементов управления
        public void unlock()
        {
            listProducts.Enabled = true;
            txtFilter.Enabled = true;
            btnRefresh.Enabled = true;
            btnAdd.Enabled = true;
            btnDelete.Enabled = true;

            btnCancel.Enabled = false;
        }

        //Очистка полей формы
        public void clearFields()
        {
            txtName.Clear();
            cmbUnit.SelectedItem = "";
            txtCost.Clear();
            txtQuantity.Clear();
            cmbProductGroup.Text = "";
        }

        // Оповещение пользователя о чем-либо
        public void NotifyUser(string message)
        {
            MessageBox.Show(message);
        }

        private void ProductCatalog_Load(object sender, EventArgs e)
        {
            presenter.loadProducts();//Запуск обновления списка товаров
        }

        private void listProducts_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (listProducts.SelectedItem != null)
            {
                Product current = listProducts.SelectedItem as Product;
                //Заполняем поля на форме
                txtName.Text = current.Name;
                cmbUnit.SelectedItem = current.Unit;
                txtCost.Text = current.Cost.ToString();
                txtQuantity.Text = current.Quantity.ToString();
                cmbProductGroup.Text = current.GroupId.ToString();
            }
        }

        private void btnAdd_Click(object sender, EventArgs e)
        {
            //Начинаем процесс добавления товара
            presenter.beginAdd();
        }

        private void btnRefresh_Click(object sender, EventArgs e)
        {
            presenter.loadProducts();
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            //Задача формы - преобразовать данные из текстовых полей в значения нужных типов
            Decimal cost = 0;
            int quantity = 0;
            float weight = 0;
            Guid groupid = Guid.Parse("ac2a862a9f8440d597b8c4188b07c4ed");//Пока просто заглушка
            if (!Decimal.TryParse(txtCost.Text, out cost))//Если не удалось преобразовать, сообщаем пользователю об этом
            {
                NotifyUser("Неверный формат цены");
                return;
            }
            if (!int.TryParse(txtQuantity.Text, out quantity))
            {
                NotifyUser("Неверный формат количества");
                return;
            }
            //Вызываем метод "сохранить"
            //Презентер сам решит что делать с этими данными: добавлять новое или удалять
            presenter.save(
                listProducts.SelectedItem as Product,
                txtName.Text,
                cmbUnit.SelectedItem.ToString(),
                cost,
                quantity,
                weight,
                groupid
            );
        }

        private void btnDelete_Click(object sender, EventArgs e)
        {
            //Просим презентер удалить выбранный товар
            presenter.delete(listProducts.SelectedItem as Product);
        }

        private void txtFilter_TextChanged(object sender, EventArgs e)
        {
            presenter.filterWith(txtFilter.Text);
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            //Завершаем процесс добавления товара
            presenter.cancelAdd();
        }
    }
}
