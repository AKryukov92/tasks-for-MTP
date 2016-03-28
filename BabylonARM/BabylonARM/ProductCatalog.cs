using BabylonARM.dao;
using BabylonARM.dto;
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
        List<Product> products;
        private Product current;
        private ProductsDao dao;

        public Product Current {
            set
            {
                txtCost.Text = value.Cost.ToString();
                txtName.Text = value.Name;
                txtQuantity.Text = value.Quantity.ToString();
                cmbUnit.SelectedItem = value.Unit;
            }
            get
            {
                return current;
            }
        }

        public ProductCatalog()
        {
            InitializeComponent();
            dao = new ProductsDao("");
            cmbUnit.DataSource = Units.UnitsList;
            List<Product> products = dao.getList();
            listProducts.DataSource = products;
        }

        private void listBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (listProducts.SelectedItem != null)
            {
                Current = (Product) listProducts.SelectedItem;
            }
        }

        private void btnAdd_Click(object sender, EventArgs e)
        {

        }

        private void btnRefresh_Click(object sender, EventArgs e)
        {

        }

        private void btnSave_Click(object sender, EventArgs e)
        {

        }

        private void btnDelete_Click(object sender, EventArgs e)
        {

        }
    }
}
