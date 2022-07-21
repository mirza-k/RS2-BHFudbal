
namespace BHFudbal.WinUI
{
    partial class frmDodajTransfer
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(frmDodajTransfer));
            this.label1 = new System.Windows.Forms.Label();
            this.cmbLiga = new System.Windows.Forms.ComboBox();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.cmbKlub = new System.Windows.Forms.ComboBox();
            this.label6 = new System.Windows.Forms.Label();
            this.cmbFudbaler = new System.Windows.Forms.ComboBox();
            this.txtCijena = new System.Windows.Forms.TextBox();
            this.label7 = new System.Windows.Forms.Label();
            this.label8 = new System.Windows.Forms.Label();
            this.txtGodineUgovora = new System.Windows.Forms.TextBox();
            this.label9 = new System.Windows.Forms.Label();
            this.cmbKlubNovi = new System.Windows.Forms.ComboBox();
            this.label10 = new System.Windows.Forms.Label();
            this.cmbLigaNovi = new System.Windows.Forms.ComboBox();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.btnZavrsi = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 22.2F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(240, 19);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(276, 44);
            this.label1.TabIndex = 0;
            this.label1.Text = "Transfer igrača";
            // 
            // cmbLiga
            // 
            this.cmbLiga.Font = new System.Drawing.Font("Microsoft Sans Serif", 10.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmbLiga.FormattingEnabled = true;
            this.cmbLiga.Location = new System.Drawing.Point(12, 130);
            this.cmbLiga.Name = "cmbLiga";
            this.cmbLiga.Size = new System.Drawing.Size(157, 30);
            this.cmbLiga.TabIndex = 1;
            this.cmbLiga.SelectedIndexChanged += new System.EventHandler(this.cmbLiga_SelectedIndexChanged);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(0, 0);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(46, 17);
            this.label2.TabIndex = 2;
            this.label2.Text = "label2";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(0, 0);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(46, 17);
            this.label3.TabIndex = 3;
            this.label3.Text = "label3";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label4.Location = new System.Drawing.Point(12, 102);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(49, 25);
            this.label4.TabIndex = 4;
            this.label4.Text = "Liga";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label5.Location = new System.Drawing.Point(12, 186);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(52, 25);
            this.label5.TabIndex = 6;
            this.label5.Text = "Klub";
            // 
            // cmbKlub
            // 
            this.cmbKlub.Font = new System.Drawing.Font("Microsoft Sans Serif", 10.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmbKlub.FormattingEnabled = true;
            this.cmbKlub.Location = new System.Drawing.Point(12, 214);
            this.cmbKlub.Name = "cmbKlub";
            this.cmbKlub.Size = new System.Drawing.Size(157, 30);
            this.cmbKlub.TabIndex = 5;
            this.cmbKlub.SelectedIndexChanged += new System.EventHandler(this.cmbKlub_SelectedIndexChanged);
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label6.Location = new System.Drawing.Point(12, 276);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(89, 25);
            this.label6.TabIndex = 8;
            this.label6.Text = "Fudbaler";
            // 
            // cmbFudbaler
            // 
            this.cmbFudbaler.Font = new System.Drawing.Font("Microsoft Sans Serif", 10.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmbFudbaler.FormattingEnabled = true;
            this.cmbFudbaler.Location = new System.Drawing.Point(12, 304);
            this.cmbFudbaler.Name = "cmbFudbaler";
            this.cmbFudbaler.Size = new System.Drawing.Size(157, 30);
            this.cmbFudbaler.TabIndex = 7;
            // 
            // txtCijena
            // 
            this.txtCijena.Font = new System.Drawing.Font("Microsoft Sans Serif", 10.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtCijena.Location = new System.Drawing.Point(219, 193);
            this.txtCijena.Name = "txtCijena";
            this.txtCijena.Size = new System.Drawing.Size(143, 28);
            this.txtCijena.TabIndex = 9;
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label7.Location = new System.Drawing.Point(214, 164);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(68, 25);
            this.label7.TabIndex = 10;
            this.label7.Text = "Cijena";
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label8.Location = new System.Drawing.Point(214, 246);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(149, 25);
            this.label8.TabIndex = 12;
            this.label8.Text = "GodineUgovora";
            // 
            // txtGodineUgovora
            // 
            this.txtGodineUgovora.Font = new System.Drawing.Font("Microsoft Sans Serif", 10.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtGodineUgovora.Location = new System.Drawing.Point(219, 275);
            this.txtGodineUgovora.Name = "txtGodineUgovora";
            this.txtGodineUgovora.Size = new System.Drawing.Size(143, 28);
            this.txtGodineUgovora.TabIndex = 11;
            // 
            // label9
            // 
            this.label9.AutoSize = true;
            this.label9.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label9.Location = new System.Drawing.Point(613, 186);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(52, 25);
            this.label9.TabIndex = 16;
            this.label9.Text = "Klub";
            // 
            // cmbKlubNovi
            // 
            this.cmbKlubNovi.Font = new System.Drawing.Font("Microsoft Sans Serif", 10.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmbKlubNovi.FormattingEnabled = true;
            this.cmbKlubNovi.Location = new System.Drawing.Point(613, 214);
            this.cmbKlubNovi.Name = "cmbKlubNovi";
            this.cmbKlubNovi.Size = new System.Drawing.Size(157, 30);
            this.cmbKlubNovi.TabIndex = 15;
            // 
            // label10
            // 
            this.label10.AutoSize = true;
            this.label10.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label10.Location = new System.Drawing.Point(613, 102);
            this.label10.Name = "label10";
            this.label10.Size = new System.Drawing.Size(49, 25);
            this.label10.TabIndex = 14;
            this.label10.Text = "Liga";
            // 
            // cmbLigaNovi
            // 
            this.cmbLigaNovi.Font = new System.Drawing.Font("Microsoft Sans Serif", 10.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmbLigaNovi.FormattingEnabled = true;
            this.cmbLigaNovi.Location = new System.Drawing.Point(613, 130);
            this.cmbLigaNovi.Name = "cmbLigaNovi";
            this.cmbLigaNovi.Size = new System.Drawing.Size(157, 30);
            this.cmbLigaNovi.TabIndex = 13;
            this.cmbLigaNovi.SelectedIndexChanged += new System.EventHandler(this.cmbLigaNovi_SelectedIndexChanged);
            // 
            // pictureBox1
            // 
            this.pictureBox1.Image = ((System.Drawing.Image)(resources.GetObject("pictureBox1.Image")));
            this.pictureBox1.Location = new System.Drawing.Point(416, 139);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(115, 82);
            this.pictureBox1.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.pictureBox1.TabIndex = 17;
            this.pictureBox1.TabStop = false;
            // 
            // btnZavrsi
            // 
            this.btnZavrsi.Location = new System.Drawing.Point(613, 265);
            this.btnZavrsi.Name = "btnZavrsi";
            this.btnZavrsi.Size = new System.Drawing.Size(93, 38);
            this.btnZavrsi.TabIndex = 18;
            this.btnZavrsi.Text = "Zavrsi";
            this.btnZavrsi.UseVisualStyleBackColor = true;
            this.btnZavrsi.Click += new System.EventHandler(this.btnZavrsi_Click);
            // 
            // frmDodajTransfer
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.btnZavrsi);
            this.Controls.Add(this.pictureBox1);
            this.Controls.Add(this.label9);
            this.Controls.Add(this.cmbKlubNovi);
            this.Controls.Add(this.label10);
            this.Controls.Add(this.cmbLigaNovi);
            this.Controls.Add(this.label8);
            this.Controls.Add(this.txtGodineUgovora);
            this.Controls.Add(this.label7);
            this.Controls.Add(this.txtCijena);
            this.Controls.Add(this.label6);
            this.Controls.Add(this.cmbFudbaler);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.cmbKlub);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.cmbLiga);
            this.Controls.Add(this.label1);
            this.Name = "frmDodajTransfer";
            this.Text = "frmDodajTransfer";
            this.Load += new System.EventHandler(this.frmDodajTransfer_Load);
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.ComboBox cmbLiga;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.ComboBox cmbKlub;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.ComboBox cmbFudbaler;
        private System.Windows.Forms.TextBox txtCijena;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.TextBox txtGodineUgovora;
        private System.Windows.Forms.Label label9;
        private System.Windows.Forms.ComboBox cmbKlubNovi;
        private System.Windows.Forms.Label label10;
        private System.Windows.Forms.ComboBox cmbLigaNovi;
        private System.Windows.Forms.PictureBox pictureBox1;
        private System.Windows.Forms.Button btnZavrsi;
    }
}