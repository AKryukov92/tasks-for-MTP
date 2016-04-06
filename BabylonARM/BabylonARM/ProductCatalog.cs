using BabylonARM.dao;
using BabylonARM.dto;
using BabylonARM.presenter;
using BabylonARM.view;
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
        private Product current;

        public ProductCatalog()
        {
            InitializeComponent();
            presenter = new ProductCatalogPresenter(this);
        }

        public void displayProducts(IList<Product> value)
        {
            listProducts.DataSource = value;
        }

        public void NotifyUser(string message)
        {
            MessageBox.Show(message);
        }

        private void ProductCatalog_Load(object sender, EventArgs e)
        {
            presenter.loadProducts();
        }

        private void listProducts_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (listProducts.SelectedItem != null)
            {
                current = (Product) listProducts.SelectedItem;
                txtName.Text = current.Name;
                cmbUnit.SelectedItem = current.Unit;
                txtCost.Text = current.Cost.ToString();
                txtQuantity.Text = current.Quantity.ToString();
                cmbProductGroup.Text = current.GroupId.ToString();
            }
        }

        private void btnAdd_Click(object sender, EventArgs e)
        {
            MessageBox.Show("Пользователь нажал кнопку \"Добавить\"");
        }

        private void btnRefresh_Click(object sender, EventArgs e)
        {
            presenter.loadProducts();
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            current.Name = txtName.Text;
            current.Unit = cmbUnit.SelectedItem.ToString();
            current.Cost = Decimal.Parse(txtCost.Text);
            current.Quantity = Int32.Parse(txtQuantity.Text);
            current.GroupId = Guid.Parse(cmbProductGroup.Text);
            presenter.save(current);
        }

        private void btnDelete_Click(object sender, EventArgs e)
        {
            presenter.delete(current);
        }

        private void txtFilter_TextChanged(object sender, EventArgs e)
        {
            presenter.filterWith(txtFilter.Text);
        }
    }
}
