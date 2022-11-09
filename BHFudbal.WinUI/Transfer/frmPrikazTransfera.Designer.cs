
namespace BHFudbal.WinUI.Transfer
{
    partial class frmPrikazTransfera
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
            this.label1 = new System.Windows.Forms.Label();
            this.cmbSezona = new System.Windows.Forms.ComboBox();
            this.btnPrikazi = new System.Windows.Forms.Button();
            this.dgvTransferi = new System.Windows.Forms.DataGridView();
            this.Ime = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Cijena = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.GodineUgovora = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.StariKlub = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.NoviKlub = new System.Windows.Forms.DataGridViewTextBoxColumn();
            ((System.ComponentModel.ISupportInitialize)(this.dgvTransferi)).BeginInit();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 10.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(12, 29);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(74, 24);
            this.label1.TabIndex = 0;
            this.label1.Text = "Sezona";
            // 
            // cmbSezona
            // 
            this.cmbSezona.Font = new System.Drawing.Font("Microsoft Sans Serif", 10.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmbSezona.FormattingEnabled = true;
            this.cmbSezona.Location = new System.Drawing.Point(12, 56);
            this.cmbSezona.Name = "cmbSezona";
            this.cmbSezona.Size = new System.Drawing.Size(172, 30);
            this.cmbSezona.TabIndex = 1;
            // 
            // btnPrikazi
            // 
            this.btnPrikazi.Location = new System.Drawing.Point(691, 56);
            this.btnPrikazi.Name = "btnPrikazi";
            this.btnPrikazi.Size = new System.Drawing.Size(97, 30);
            this.btnPrikazi.TabIndex = 2;
            this.btnPrikazi.Text = "Prikazi";
            this.btnPrikazi.UseVisualStyleBackColor = true;
            this.btnPrikazi.Click += new System.EventHandler(this.btnPrikazi_Click);
            // 
            // dgvTransferi
            // 
            this.dgvTransferi.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvTransferi.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.Ime,
            this.Cijena,
            this.GodineUgovora,
            this.StariKlub,
            this.NoviKlub});
            this.dgvTransferi.Location = new System.Drawing.Point(12, 118);
            this.dgvTransferi.Name = "dgvTransferi";
            this.dgvTransferi.RowHeadersWidth = 51;
            this.dgvTransferi.RowTemplate.Height = 24;
            this.dgvTransferi.Size = new System.Drawing.Size(776, 320);
            this.dgvTransferi.TabIndex = 3;
            // 
            // Ime
            // 
            this.Ime.DataPropertyName = "ImeFudbalera";
            this.Ime.HeaderText = "Ime fudbalera";
            this.Ime.MinimumWidth = 6;
            this.Ime.Name = "Ime";
            this.Ime.Width = 125;
            // 
            // Cijena
            // 
            this.Cijena.DataPropertyName = "Cijena";
            this.Cijena.HeaderText = "Cijena";
            this.Cijena.MinimumWidth = 6;
            this.Cijena.Name = "Cijena";
            this.Cijena.Width = 125;
            // 
            // GodineUgovora
            // 
            this.GodineUgovora.DataPropertyName = "BrojGodinaUgovora";
            this.GodineUgovora.HeaderText = "Godine ugovora";
            this.GodineUgovora.MinimumWidth = 6;
            this.GodineUgovora.Name = "GodineUgovora";
            this.GodineUgovora.Width = 125;
            // 
            // StariKlub
            // 
            this.StariKlub.DataPropertyName = "StariKlub";
            this.StariKlub.HeaderText = "Stari klub";
            this.StariKlub.MinimumWidth = 6;
            this.StariKlub.Name = "StariKlub";
            this.StariKlub.Width = 125;
            // 
            // NoviKlub
            // 
            this.NoviKlub.DataPropertyName = "NazivKluba";
            this.NoviKlub.HeaderText = "Novi klub";
            this.NoviKlub.MinimumWidth = 6;
            this.NoviKlub.Name = "NoviKlub";
            this.NoviKlub.Width = 125;
            // 
            // frmPrikazTransfera
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.dgvTransferi);
            this.Controls.Add(this.btnPrikazi);
            this.Controls.Add(this.cmbSezona);
            this.Controls.Add(this.label1);
            this.Name = "frmPrikazTransfera";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "frmPrikazTransfera";
            this.Load += new System.EventHandler(this.frmPrikazTransfera_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dgvTransferi)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.ComboBox cmbSezona;
        private System.Windows.Forms.Button btnPrikazi;
        private System.Windows.Forms.DataGridView dgvTransferi;
        private System.Windows.Forms.DataGridViewTextBoxColumn Ime;
        private System.Windows.Forms.DataGridViewTextBoxColumn Cijena;
        private System.Windows.Forms.DataGridViewTextBoxColumn GodineUgovora;
        private System.Windows.Forms.DataGridViewTextBoxColumn StariKlub;
        private System.Windows.Forms.DataGridViewTextBoxColumn NoviKlub;
    }
}