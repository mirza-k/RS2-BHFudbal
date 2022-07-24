
namespace BHFudbal.WinUI.Klub
{
    partial class frmPrikazKlubova
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
            this.dgvKlub = new System.Windows.Forms.DataGridView();
            this.Naziv = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Grad = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.GodinaOsnivanja = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Liga = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Nadimak = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.cmbLiga = new System.Windows.Forms.ComboBox();
            this.btbPrikazi = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.dgvKlub)).BeginInit();
            this.SuspendLayout();
            // 
            // dgvKlub
            // 
            this.dgvKlub.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvKlub.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.Naziv,
            this.Grad,
            this.GodinaOsnivanja,
            this.Liga,
            this.Nadimak});
            this.dgvKlub.Location = new System.Drawing.Point(12, 51);
            this.dgvKlub.Name = "dgvKlub";
            this.dgvKlub.RowHeadersWidth = 51;
            this.dgvKlub.RowTemplate.Height = 24;
            this.dgvKlub.Size = new System.Drawing.Size(776, 387);
            this.dgvKlub.TabIndex = 0;
            this.dgvKlub.CellDoubleClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgvKlub_CellDoubleClick);
            // 
            // Naziv
            // 
            this.Naziv.DataPropertyName = "Naziv";
            this.Naziv.HeaderText = "Naziv";
            this.Naziv.MinimumWidth = 6;
            this.Naziv.Name = "Naziv";
            this.Naziv.Width = 125;
            // 
            // Grad
            // 
            this.Grad.DataPropertyName = "Grad";
            this.Grad.HeaderText = "Grad";
            this.Grad.MinimumWidth = 6;
            this.Grad.Name = "Grad";
            this.Grad.Width = 125;
            // 
            // GodinaOsnivanja
            // 
            this.GodinaOsnivanja.DataPropertyName = "GodinaOsnivanja";
            this.GodinaOsnivanja.HeaderText = "GodinaOsnivanja";
            this.GodinaOsnivanja.MinimumWidth = 6;
            this.GodinaOsnivanja.Name = "GodinaOsnivanja";
            this.GodinaOsnivanja.Width = 125;
            // 
            // Liga
            // 
            this.Liga.DataPropertyName = "Liga";
            this.Liga.HeaderText = "Liga";
            this.Liga.MinimumWidth = 6;
            this.Liga.Name = "Liga";
            this.Liga.Width = 125;
            // 
            // Nadimak
            // 
            this.Nadimak.DataPropertyName = "Nadimak";
            this.Nadimak.HeaderText = "Nadimak";
            this.Nadimak.MinimumWidth = 6;
            this.Nadimak.Name = "Nadimak";
            this.Nadimak.Width = 125;
            // 
            // cmbLiga
            // 
            this.cmbLiga.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmbLiga.FormattingEnabled = true;
            this.cmbLiga.Location = new System.Drawing.Point(12, 12);
            this.cmbLiga.Name = "cmbLiga";
            this.cmbLiga.Size = new System.Drawing.Size(177, 28);
            this.cmbLiga.TabIndex = 1;
            // 
            // btbPrikazi
            // 
            this.btbPrikazi.Location = new System.Drawing.Point(710, 12);
            this.btbPrikazi.Name = "btbPrikazi";
            this.btbPrikazi.Size = new System.Drawing.Size(78, 33);
            this.btbPrikazi.TabIndex = 2;
            this.btbPrikazi.Text = "Prikazi";
            this.btbPrikazi.UseVisualStyleBackColor = true;
            this.btbPrikazi.Click += new System.EventHandler(this.button1_Click);
            // 
            // frmPrikazKlubova
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.btbPrikazi);
            this.Controls.Add(this.cmbLiga);
            this.Controls.Add(this.dgvKlub);
            this.Name = "frmPrikazKlubova";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "frmPrikazKlubova";
            this.Load += new System.EventHandler(this.frmPrikazKlubova_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dgvKlub)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.DataGridView dgvKlub;
        private System.Windows.Forms.ComboBox cmbLiga;
        private System.Windows.Forms.Button btbPrikazi;
        private System.Windows.Forms.DataGridViewTextBoxColumn Naziv;
        private System.Windows.Forms.DataGridViewTextBoxColumn Grad;
        private System.Windows.Forms.DataGridViewTextBoxColumn GodinaOsnivanja;
        private System.Windows.Forms.DataGridViewTextBoxColumn Liga;
        private System.Windows.Forms.DataGridViewTextBoxColumn Nadimak;
    }
}