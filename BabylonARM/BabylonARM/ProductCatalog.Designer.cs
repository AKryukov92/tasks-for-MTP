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
            this.gboxProductCard = new System.Windows.Forms.GroupBox();
            this.btnCancel = new System.Windows.Forms.Button();
            this.lblProductGroup = new System.Windows.Forms.Label();
            this.cmbProductGroup = new System.Windows.Forms.ComboBox();
            this.btnRefresh = new System.Windows.Forms.Button();
            this.txtFilter = new System.Windows.Forms.TextBox();
            this.gboxProductCard.SuspendLayout();
            this.SuspendLayout();
            // 
            // listProducts
            // 
            this.listProducts.FormattingEnabled = true;
            this.listProducts.Location = new System.Drawing.Point(12, 38);
            this.listProducts.Name = "listProducts";
            this.listProducts.Size = new System.Drawing.Size(156, 121);
            this.listProducts.TabIndex = 0;
            this.listProducts.SelectedIndexChanged += new System.EventHandler(this.listProducts_SelectedIndexChanged);
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
            this.txtName.AutoCompleteCustomSource.AddRange(new string[] {
            "abc",
            "abcd",
            "abcde"});
            this.txtName.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.SuggestAppend;
            this.txtName.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.CustomSource;
            this.txtName.Location = new System.Drawing.Point(146, 19);
            this.txtName.Name = "txtName";
            this.txtName.Size = new System.Drawing.Size(100, 20);
            this.txtName.TabIndex = 1;
            // 
            // txtCost
            // 
            this.txtCost.Location = new System.Drawing.Point(146, 72);
            this.txtCost.Name = "txtCost";
            this.txtCost.Size = new System.Drawing.Size(100, 20);
            this.txtCost.TabIndex = 3;
            // 
            // cmbUnit
            // 
            this.cmbUnit.FormattingEnabled = true;
            this.cmbUnit.Items.AddRange(new object[] {
            "",
            "UNIT",
            "PACKING",
            "PACK",
            "BOTTLE_05",
            "BOTTLE_033",
            "BOX",
            "CRATE",
            "TIN_POT",
            "GLASS_POT"});
            this.cmbUnit.Location = new System.Drawing.Point(146, 45);
            this.cmbUnit.Name = "cmbUnit";
            this.cmbUnit.Size = new System.Drawing.Size(100, 21);
            this.cmbUnit.TabIndex = 2;
            // 
            // txtQuantity
            // 
            this.txtQuantity.Location = new System.Drawing.Point(146, 98);
            this.txtQuantity.Name = "txtQuantity";
            this.txtQuantity.Size = new System.Drawing.Size(100, 20);
            this.txtQuantity.TabIndex = 4;
            // 
            // lblCost
            // 
            this.lblCost.AutoSize = true;
            this.lblCost.Location = new System.Drawing.Point(6, 75);
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
            this.lblQuantity.Location = new System.Drawing.Point(6, 101);
            this.lblQuantity.Name = "lblQuantity";
            this.lblQuantity.Size = new System.Drawing.Size(66, 13);
            this.lblQuantity.TabIndex = 9;
            this.lblQuantity.Text = "Количество";
            // 
            // btnDelete
            // 
            this.btnDelete.Location = new System.Drawing.Point(171, 152);
            this.btnDelete.Name = "btnDelete";
            this.btnDelete.Size = new System.Drawing.Size(75, 23);
            this.btnDelete.TabIndex = 6;
            this.btnDelete.Text = "Удалить";
            this.btnDelete.UseVisualStyleBackColor = true;
            this.btnDelete.Click += new System.EventHandler(this.btnDelete_Click);
            // 
            // btnAdd
            // 
            this.btnAdd.Location = new System.Drawing.Point(93, 163);
            this.btnAdd.Name = "btnAdd";
            this.btnAdd.Size = new System.Drawing.Size(75, 23);
            this.btnAdd.TabIndex = 8;
            this.btnAdd.Text = "Добавить";
            this.btnAdd.UseVisualStyleBackColor = true;
            this.btnAdd.Click += new System.EventHandler(this.btnAdd_Click);
            // 
            // btnSave
            // 
            this.btnSave.Location = new System.Drawing.Point(90, 152);
            this.btnSave.Name = "btnSave";
            this.btnSave.Size = new System.Drawing.Size(75, 23);
            this.btnSave.TabIndex = 5;
            this.btnSave.Text = "Сохранить";
            this.btnSave.UseVisualStyleBackColor = true;
            this.btnSave.Click += new System.EventHandler(this.btnSave_Click);
            // 
            // gboxProductCard
            // 
            this.gboxProductCard.Controls.Add(this.btnCancel);
            this.gboxProductCard.Controls.Add(this.lblProductGroup);
            this.gboxProductCard.Controls.Add(this.cmbProductGroup);
            this.gboxProductCard.Controls.Add(this.lblName);
            this.gboxProductCard.Controls.Add(this.btnSave);
            this.gboxProductCard.Controls.Add(this.txtName);
            this.gboxProductCard.Controls.Add(this.txtCost);
            this.gboxProductCard.Controls.Add(this.btnDelete);
            this.gboxProductCard.Controls.Add(this.cmbUnit);
            this.gboxProductCard.Controls.Add(this.lblQuantity);
            this.gboxProductCard.Controls.Add(this.txtQuantity);
            this.gboxProductCard.Controls.Add(this.lblUnit);
            this.gboxProductCard.Controls.Add(this.lblCost);
            this.gboxProductCard.Location = new System.Drawing.Point(174, 12);
            this.gboxProductCard.Name = "gboxProductCard";
            this.gboxProductCard.Size = new System.Drawing.Size(257, 181);
            this.gboxProductCard.TabIndex = 1;
            this.gboxProductCard.TabStop = false;
            this.gboxProductCard.Text = "Карточка товара";
            // 
            // btnCancel
            // 
            this.btnCancel.Enabled = false;
            this.btnCancel.Location = new System.Drawing.Point(9, 152);
            this.btnCancel.Name = "btnCancel";
            this.btnCancel.Size = new System.Drawing.Size(75, 23);
            this.btnCancel.TabIndex = 9;
            this.btnCancel.Text = "Отмена";
            this.btnCancel.UseVisualStyleBackColor = true;
            this.btnCancel.Click += new System.EventHandler(this.btnCancel_Click);
            // 
            // lblProductGroup
            // 
            this.lblProductGroup.AutoSize = true;
            this.lblProductGroup.Location = new System.Drawing.Point(6, 127);
            this.lblProductGroup.Name = "lblProductGroup";
            this.lblProductGroup.Size = new System.Drawing.Size(80, 13);
            this.lblProductGroup.TabIndex = 11;
            this.lblProductGroup.Text = "Группа товара";
            // 
            // cmbProductGroup
            // 
            this.cmbProductGroup.FormattingEnabled = true;
            this.cmbProductGroup.Location = new System.Drawing.Point(146, 124);
            this.cmbProductGroup.Name = "cmbProductGroup";
            this.cmbProductGroup.Size = new System.Drawing.Size(100, 21);
            this.cmbProductGroup.TabIndex = 10;
            // 
            // btnRefresh
            // 
            this.btnRefresh.Location = new System.Drawing.Point(12, 163);
            this.btnRefresh.Name = "btnRefresh";
            this.btnRefresh.Size = new System.Drawing.Size(75, 23);
            this.btnRefresh.TabIndex = 7;
            this.btnRefresh.Text = "Обновить";
            this.btnRefresh.UseVisualStyleBackColor = true;
            this.btnRefresh.Click += new System.EventHandler(this.btnRefresh_Click);
            // 
            // txtFilter
            // 
            this.txtFilter.Location = new System.Drawing.Point(12, 12);
            this.txtFilter.Name = "txtFilter";
            this.txtFilter.Size = new System.Drawing.Size(156, 20);
            this.txtFilter.TabIndex = 0;
            this.txtFilter.TextChanged += new System.EventHandler(this.txtFilter_TextChanged);
            // 
            // ProductCatalog
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(435, 197);
            this.Controls.Add(this.txtFilter);
            this.Controls.Add(this.btnRefresh);
            this.Controls.Add(this.gboxProductCard);
            this.Controls.Add(this.btnAdd);
            this.Controls.Add(this.listProducts);
            this.Name = "ProductCatalog";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Справочник товаров";
            this.Load += new System.EventHandler(this.ProductCatalog_Load);
            this.gboxProductCard.ResumeLayout(false);
            this.gboxProductCard.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

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
        private System.Windows.Forms.GroupBox gboxProductCard;
        private System.Windows.Forms.Button btnRefresh;
        private System.Windows.Forms.Label lblProductGroup;
        private System.Windows.Forms.ComboBox cmbProductGroup;
        private System.Windows.Forms.TextBox txtFilter;
        private System.Windows.Forms.Button btnCancel;
    }
}

