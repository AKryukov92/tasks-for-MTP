namespace BabylonARM
{
    partial class ProductCatalog
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.listProducts = new System.Windows.Forms.ListBox();
            this.lblName = new System.Windows.Forms.Label();
            this.txtName = new System.Windows.Forms.TextBox();
            this.txtCost = new System.Windows.Forms.TextBox();
            this.cmbUnit = new System.Windows.Forms.ComboBox();
            this.txtQuantity = new System.Windows.Forms.TextBox();
            this.lblCost = new System.Windows.Forms.Label();
            this.lblUnit = new System.Windows.Forms.Label();
            this.lblQuantity = new System.Windows.Forms.Label();
            this.btnDelete = new System.Windows.Forms.Button();
            this.btnAdd = new System.Windows.Forms.Button();
            this.btnSave = new System.Windows.Forms.Button();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.btnRefresh = new System.Windows.Forms.Button();
            this.groupBox1.SuspendLayout();
            this.SuspendLayout();
            // 
            // listProducts
            // 
            this.listProducts.FormattingEnabled = true;
            this.listProducts.Location = new System.Drawing.Point(12, 12);
            this.listProducts.Name = "listProducts";
            this.listProducts.Size = new System.Drawing.Size(120, 134);
            this.listProducts.TabIndex = 0;
            this.listProducts.SelectedIndexChanged += new System.EventHandler(this.listBox1_SelectedIndexChanged);
            // 
            // lblName
            // 
            this.lblName.AutoSize = true;
            this.lblName.Location = new System.Drawing.Point(6, 22);
            this.lblName.Name = "lblName";
            this.lblName.Size = new System.Drawing.Size(83, 13);
            this.lblName.TabIndex = 1;
            this.lblName.Text = "Наименование";
            // 
            // txtName
            // 
            this.txtName.Location = new System.Drawing.Point(131, 19);
            this.txtName.Name = "txtName";
            this.txtName.Size = new System.Drawing.Size(100, 20);
            this.txtName.TabIndex = 2;
            // 
            // txtCost
            // 
            this.txtCost.Location = new System.Drawing.Point(131, 98);
            this.txtCost.Name = "txtCost";
            this.txtCost.Size = new System.Drawing.Size(100, 20);
            this.txtCost.TabIndex = 3;
            // 
            // cmbUnit
            // 
            this.cmbUnit.FormattingEnabled = true;
            this.cmbUnit.Items.AddRange(new object[] {
            "штука",
            "пара"});
            this.cmbUnit.Location = new System.Drawing.Point(131, 45);
            this.cmbUnit.Name = "cmbUnit";
            this.cmbUnit.Size = new System.Drawing.Size(100, 21);
            this.cmbUnit.TabIndex = 5;
            // 
            // txtQuantity
            // 
            this.txtQuantity.Location = new System.Drawing.Point(131, 124);
            this.txtQuantity.Name = "txtQuantity";
            this.txtQuantity.Size = new System.Drawing.Size(100, 20);
            this.txtQuantity.TabIndex = 6;
            // 
            // lblCost
            // 
            this.lblCost.AutoSize = true;
            this.lblCost.Location = new System.Drawing.Point(6, 101);
            this.lblCost.Name = "lblCost";
            this.lblCost.Size = new System.Drawing.Size(92, 13);
            this.lblCost.TabIndex = 7;
            this.lblCost.Text = "Цена за единицу";
            // 
            // lblUnit
            // 
            this.lblUnit.AutoSize = true;
            this.lblUnit.Location = new System.Drawing.Point(6, 48);
            this.lblUnit.Name = "lblUnit";
            this.lblUnit.Size = new System.Drawing.Size(109, 13);
            this.lblUnit.TabIndex = 8;
            this.lblUnit.Text = "Единица измерения";
            // 
            // lblQuantity
            // 
            this.lblQuantity.AutoSize = true;
            this.lblQuantity.Location = new System.Drawing.Point(6, 127);
            this.lblQuantity.Name = "lblQuantity";
            this.lblQuantity.Size = new System.Drawing.Size(66, 13);
            this.lblQuantity.TabIndex = 9;
            this.lblQuantity.Text = "Количество";
            // 
            // btnDelete
            // 
            this.btnDelete.Location = new System.Drawing.Point(156, 170);
            this.btnDelete.Name = "btnDelete";
            this.btnDelete.Size = new System.Drawing.Size(75, 23);
            this.btnDelete.TabIndex = 10;
            this.btnDelete.Text = "Удалить";
            this.btnDelete.UseVisualStyleBackColor = true;
            this.btnDelete.Click += new System.EventHandler(this.btnDelete_Click);
            // 
            // btnAdd
            // 
            this.btnAdd.Location = new System.Drawing.Point(12, 153);
            this.btnAdd.Name = "btnAdd";
            this.btnAdd.Size = new System.Drawing.Size(75, 23);
            this.btnAdd.TabIndex = 11;
            this.btnAdd.Text = "Добавить";
            this.btnAdd.UseVisualStyleBackColor = true;
            this.btnAdd.Click += new System.EventHandler(this.btnAdd_Click);
            // 
            // btnSave
            // 
            this.btnSave.Enabled = false;
            this.btnSave.Location = new System.Drawing.Point(75, 170);
            this.btnSave.Name = "btnSave";
            this.btnSave.Size = new System.Drawing.Size(75, 23);
            this.btnSave.TabIndex = 12;
            this.btnSave.Text = "Сохранить";
            this.btnSave.UseVisualStyleBackColor = true;
            this.btnSave.Click += new System.EventHandler(this.btnSave_Click);
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.lblName);
            this.groupBox1.Controls.Add(this.btnSave);
            this.groupBox1.Controls.Add(this.txtName);
            this.groupBox1.Controls.Add(this.txtCost);
            this.groupBox1.Controls.Add(this.btnDelete);
            this.groupBox1.Controls.Add(this.cmbUnit);
            this.groupBox1.Controls.Add(this.lblQuantity);
            this.groupBox1.Controls.Add(this.txtQuantity);
            this.groupBox1.Controls.Add(this.lblUnit);
            this.groupBox1.Controls.Add(this.lblCost);
            this.groupBox1.Location = new System.Drawing.Point(154, 12);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(237, 199);
            this.groupBox1.TabIndex = 13;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Карточка товара";
            // 
            // btnRefresh
            // 
            this.btnRefresh.Location = new System.Drawing.Point(12, 182);
            this.btnRefresh.Name = "btnRefresh";
            this.btnRefresh.Size = new System.Drawing.Size(75, 23);
            this.btnRefresh.TabIndex = 14;
            this.btnRefresh.Text = "Обновить";
            this.btnRefresh.UseVisualStyleBackColor = true;
            this.btnRefresh.Click += new System.EventHandler(this.btnRefresh_Click);
            // 
            // ProductCatalog
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(400, 219);
            this.Controls.Add(this.btnRefresh);
            this.Controls.Add(this.groupBox1);
            this.Controls.Add(this.btnAdd);
            this.Controls.Add(this.listProducts);
            this.Name = "ProductCatalog";
            this.Text = "Справочник товаров";
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.ListBox listProducts;
        private System.Windows.Forms.Label lblName;
        private System.Windows.Forms.TextBox txtName;
        private System.Windows.Forms.TextBox txtCost;
        private System.Windows.Forms.ComboBox cmbUnit;
        private System.Windows.Forms.TextBox txtQuantity;
        private System.Windows.Forms.Label lblCost;
        private System.Windows.Forms.Label lblUnit;
        private System.Windows.Forms.Label lblQuantity;
        private System.Windows.Forms.Button btnDelete;
        private System.Windows.Forms.Button btnAdd;
        private System.Windows.Forms.Button btnSave;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.Button btnRefresh;
    }
}

