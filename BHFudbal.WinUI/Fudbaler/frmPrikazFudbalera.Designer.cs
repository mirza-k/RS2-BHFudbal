
namespace BHFudbal.WinUI.Fudbaler
{
    partial class frmPrikazFudbalera
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
            this.dgvFudbaleri = new System.Windows.Forms.DataGridView();
            this.Ime = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Prezime = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Visina = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Težina = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Klub = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.DatumRodjenja = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.JačaNoga = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.cmbLiga = new System.Windows.Forms.ComboBox();
            this.cmbKlub = new System.Windows.Forms.ComboBox();
            this.cmbPrikazi = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.dgvFudbaleri)).BeginInit();
            this.SuspendLayout();
            // 
            // dgvFudbaleri
            // 
            this.dgvFudbaleri.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvFudbaleri.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.Ime,
            this.Prezime,
            this.Visina,
            this.Težina,
            this.Klub,
            this.DatumRodjenja,
            this.JačaNoga});
            this.dgvFudbaleri.Location = new System.Drawing.Point(12, 52);
            this.dgvFudbaleri.Name = "dgvFudbaleri";
            this.dgvFudbaleri.ReadOnly = true;
            this.dgvFudbaleri.RowHeadersWidth = 51;
            this.dgvFudbaleri.RowTemplate.Height = 24;
            this.dgvFudbaleri.Size = new System.Drawing.Size(930, 386);
            this.dgvFudbaleri.TabIndex = 0;
            this.dgvFudbaleri.CellDoubleClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgvFudbaleri_CellDoubleClick);
            // 
            // Ime
            // 
            this.Ime.DataPropertyName = "Ime";
            this.Ime.HeaderText = "Ime";
            this.Ime.MinimumWidth = 6;
            this.Ime.Name = "Ime";
            this.Ime.ReadOnly = true;
            this.Ime.Width = 125;
            // 
            // Prezime
            // 
            this.Prezime.DataPropertyName = "Prezime";
            this.Prezime.HeaderText = "Prezime";
            this.Prezime.MinimumWidth = 6;
            this.Prezime.Name = "Prezime";
            this.Prezime.ReadOnly = true;
            this.Prezime.Width = 125;
            // 
            // Visina
            // 
            this.Visina.DataPropertyName = "Visina";
            this.Visina.HeaderText = "Visina";
            this.Visina.MinimumWidth = 6;
            this.Visina.Name = "Visina";
            this.Visina.ReadOnly = true;
            this.Visina.Width = 125;
            // 
            // Težina
            // 
            this.Težina.DataPropertyName = "Težina";
            this.Težina.HeaderText = "Težina";
            this.Težina.MinimumWidth = 6;
            this.Težina.Name = "Težina";
            this.Težina.ReadOnly = true;
            this.Težina.Width = 125;
            // 
            // Klub
            // 
            this.Klub.DataPropertyName = "Klub";
            this.Klub.HeaderText = "Klub";
            this.Klub.MinimumWidth = 6;
            this.Klub.Name = "Klub";
            this.Klub.ReadOnly = true;
            this.Klub.Width = 125;
            // 
            // DatumRodjenja
            // 
            this.DatumRodjenja.DataPropertyName = "DatumRodjenja";
            this.DatumRodjenja.HeaderText = "Datum rodjenja";
            this.DatumRodjenja.MinimumWidth = 6;
            this.DatumRodjenja.Name = "DatumRodjenja";
            this.DatumRodjenja.ReadOnly = true;
            this.DatumRodjenja.Width = 125;
            // 
            // JačaNoga
            // 
            this.JačaNoga.DataPropertyName = "JačaNoga";
            this.JačaNoga.HeaderText = "Jača noga";
            this.JačaNoga.MinimumWidth = 6;
            this.JačaNoga.Name = "JačaNoga";
            this.JačaNoga.ReadOnly = true;
            this.JačaNoga.Width = 125;
            // 
            // cmbLiga
            // 
            this.cmbLiga.Font = new System.Drawing.Font("Microsoft Sans Serif", 10.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmbLiga.FormattingEnabled = true;
            this.cmbLiga.Location = new System.Drawing.Point(12, 12);
            this.cmbLiga.Name = "cmbLiga";
            this.cmbLiga.Size = new System.Drawing.Size(139, 30);
            this.cmbLiga.TabIndex = 1;
            this.cmbLiga.SelectedIndexChanged += new System.EventHandler(this.cmbLiga_SelectedIndexChanged);
            // 
            // cmbKlub
            // 
            this.cmbKlub.Font = new System.Drawing.Font("Microsoft Sans Serif", 10.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmbKlub.FormattingEnabled = true;
            this.cmbKlub.Location = new System.Drawing.Point(203, 12);
            this.cmbKlub.Name = "cmbKlub";
            this.cmbKlub.Size = new System.Drawing.Size(139, 30);
            this.cmbKlub.TabIndex = 2;
            // 
            // cmbPrikazi
            // 
            this.cmbPrikazi.Location = new System.Drawing.Point(713, 12);
            this.cmbPrikazi.Name = "cmbPrikazi";
            this.cmbPrikazi.Size = new System.Drawing.Size(75, 30);
            this.cmbPrikazi.TabIndex = 3;
            this.cmbPrikazi.Text = "Prikazi";
            this.cmbPrikazi.UseVisualStyleBackColor = true;
            this.cmbPrikazi.Click += new System.EventHandler(this.cmbPrikazi_Click);
            // 
            // frmPrikazFudbalera
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(954, 450);
            this.Controls.Add(this.cmbPrikazi);
            this.Controls.Add(this.cmbKlub);
            this.Controls.Add(this.cmbLiga);
            this.Controls.Add(this.dgvFudbaleri);
            this.Name = "frmPrikazFudbalera";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "PrikazFudbalera";
            this.Load += new System.EventHandler(this.PrikazFudbalera_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dgvFudbaleri)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.DataGridView dgvFudbaleri;
        private System.Windows.Forms.ComboBox cmbLiga;
        private System.Windows.Forms.ComboBox cmbKlub;
        private System.Windows.Forms.Button cmbPrikazi;
        private System.Windows.Forms.DataGridViewTextBoxColumn Ime;
        private System.Windows.Forms.DataGridViewTextBoxColumn Prezime;
        private System.Windows.Forms.DataGridViewTextBoxColumn Visina;
        private System.Windows.Forms.DataGridViewTextBoxColumn Težina;
        private System.Windows.Forms.DataGridViewTextBoxColumn Klub;
        private System.Windows.Forms.DataGridViewTextBoxColumn DatumRodjenja;
        private System.Windows.Forms.DataGridViewTextBoxColumn JačaNoga;
    }
}