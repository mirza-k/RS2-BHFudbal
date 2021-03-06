
namespace BHFudbal.WinUI.Klub
{
    partial class frmKlub
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
            this.txtNaziv = new System.Windows.Forms.TextBox();
            this.txtGodinaOsnivanja = new System.Windows.Forms.TextBox();
            this.txtNadimak = new System.Windows.Forms.TextBox();
            this.cmbGrad = new System.Windows.Forms.ComboBox();
            this.lblDodajNoviKlub = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.label6 = new System.Windows.Forms.Label();
            this.imgGrb = new System.Windows.Forms.PictureBox();
            this.btnDodajKlub = new System.Windows.Forms.Button();
            this.label7 = new System.Windows.Forms.Label();
            this.cmbLiga = new System.Windows.Forms.ComboBox();
            this.upldGrb = new System.Windows.Forms.Button();
            this.btnUredi = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.imgGrb)).BeginInit();
            this.SuspendLayout();
            // 
            // txtNaziv
            // 
            this.txtNaziv.Font = new System.Drawing.Font("Microsoft Sans Serif", 10.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtNaziv.Location = new System.Drawing.Point(51, 123);
            this.txtNaziv.Name = "txtNaziv";
            this.txtNaziv.Size = new System.Drawing.Size(209, 24);
            this.txtNaziv.TabIndex = 0;
            // 
            // txtGodinaOsnivanja
            // 
            this.txtGodinaOsnivanja.Font = new System.Drawing.Font("Microsoft Sans Serif", 10.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtGodinaOsnivanja.Location = new System.Drawing.Point(51, 275);
            this.txtGodinaOsnivanja.Name = "txtGodinaOsnivanja";
            this.txtGodinaOsnivanja.Size = new System.Drawing.Size(209, 24);
            this.txtGodinaOsnivanja.TabIndex = 1;
            // 
            // txtNadimak
            // 
            this.txtNadimak.AcceptsReturn = true;
            this.txtNadimak.Font = new System.Drawing.Font("Microsoft Sans Serif", 10.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtNadimak.Location = new System.Drawing.Point(51, 197);
            this.txtNadimak.Name = "txtNadimak";
            this.txtNadimak.Size = new System.Drawing.Size(209, 24);
            this.txtNadimak.TabIndex = 3;
            // 
            // cmbGrad
            // 
            this.cmbGrad.Font = new System.Drawing.Font("Microsoft Sans Serif", 10.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmbGrad.FormattingEnabled = true;
            this.cmbGrad.Location = new System.Drawing.Point(513, 121);
            this.cmbGrad.Name = "cmbGrad";
            this.cmbGrad.Size = new System.Drawing.Size(199, 25);
            this.cmbGrad.TabIndex = 4;
            // 
            // lblDodajNoviKlub
            // 
            this.lblDodajNoviKlub.AutoSize = true;
            this.lblDodajNoviKlub.Font = new System.Drawing.Font("Microsoft Sans Serif", 22.2F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblDodajNoviKlub.Location = new System.Drawing.Point(253, 25);
            this.lblDodajNoviKlub.Name = "lblDodajNoviKlub";
            this.lblDodajNoviKlub.Size = new System.Drawing.Size(221, 36);
            this.lblDodajNoviKlub.TabIndex = 6;
            this.lblDodajNoviKlub.Text = "Dodaj novi klub";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 13.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(46, 91);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(56, 24);
            this.label1.TabIndex = 7;
            this.label1.Text = "Naziv";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 13.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(46, 243);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(155, 24);
            this.label2.TabIndex = 8;
            this.label2.Text = "Godina osnivanja";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Microsoft Sans Serif", 13.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.Location = new System.Drawing.Point(46, 165);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(84, 24);
            this.label3.TabIndex = 9;
            this.label3.Text = "Nadimak";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Font = new System.Drawing.Font("Microsoft Sans Serif", 13.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label5.Location = new System.Drawing.Point(508, 91);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(51, 24);
            this.label5.TabIndex = 11;
            this.label5.Text = "Grad";
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Font = new System.Drawing.Font("Microsoft Sans Serif", 13.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label6.Location = new System.Drawing.Point(508, 162);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(41, 24);
            this.label6.TabIndex = 12;
            this.label6.Text = "Grb";
            // 
            // imgGrb
            // 
            this.imgGrb.Location = new System.Drawing.Point(513, 197);
            this.imgGrb.Name = "imgGrb";
            this.imgGrb.Size = new System.Drawing.Size(199, 139);
            this.imgGrb.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.imgGrb.TabIndex = 14;
            this.imgGrb.TabStop = false;
            // 
            // btnDodajKlub
            // 
            this.btnDodajKlub.Location = new System.Drawing.Point(341, 409);
            this.btnDodajKlub.Name = "btnDodajKlub";
            this.btnDodajKlub.Size = new System.Drawing.Size(103, 33);
            this.btnDodajKlub.TabIndex = 15;
            this.btnDodajKlub.Text = "Dodaj";
            this.btnDodajKlub.UseVisualStyleBackColor = true;
            this.btnDodajKlub.Click += new System.EventHandler(this.btnDodajKlub_Click);
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Font = new System.Drawing.Font("Microsoft Sans Serif", 13.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label7.Location = new System.Drawing.Point(46, 317);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(45, 24);
            this.label7.TabIndex = 16;
            this.label7.Text = "Liga";
            // 
            // cmbLiga
            // 
            this.cmbLiga.Font = new System.Drawing.Font("Microsoft Sans Serif", 10.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmbLiga.FormattingEnabled = true;
            this.cmbLiga.Location = new System.Drawing.Point(51, 349);
            this.cmbLiga.Name = "cmbLiga";
            this.cmbLiga.Size = new System.Drawing.Size(209, 25);
            this.cmbLiga.TabIndex = 17;
            // 
            // upldGrb
            // 
            this.upldGrb.Location = new System.Drawing.Point(637, 165);
            this.upldGrb.Name = "upldGrb";
            this.upldGrb.Size = new System.Drawing.Size(75, 26);
            this.upldGrb.TabIndex = 18;
            this.upldGrb.Text = "Upload";
            this.upldGrb.UseVisualStyleBackColor = true;
            this.upldGrb.Click += new System.EventHandler(this.upldGrb_Click);
            // 
            // btnUredi
            // 
            this.btnUredi.Location = new System.Drawing.Point(341, 370);
            this.btnUredi.Name = "btnUredi";
            this.btnUredi.Size = new System.Drawing.Size(103, 33);
            this.btnUredi.TabIndex = 19;
            this.btnUredi.Text = "Uredi";
            this.btnUredi.UseVisualStyleBackColor = true;
            this.btnUredi.Visible = false;
            this.btnUredi.Click += new System.EventHandler(this.button1_Click);
            // 
            // frmKlub
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(751, 454);
            this.Controls.Add(this.btnUredi);
            this.Controls.Add(this.upldGrb);
            this.Controls.Add(this.cmbLiga);
            this.Controls.Add(this.label7);
            this.Controls.Add(this.btnDodajKlub);
            this.Controls.Add(this.imgGrb);
            this.Controls.Add(this.label6);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.lblDodajNoviKlub);
            this.Controls.Add(this.cmbGrad);
            this.Controls.Add(this.txtNadimak);
            this.Controls.Add(this.txtGodinaOsnivanja);
            this.Controls.Add(this.txtNaziv);
            this.Name = "frmKlub";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Load += new System.EventHandler(this.frmKlub_Load);
            ((System.ComponentModel.ISupportInitialize)(this.imgGrb)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.TextBox txtNaziv;
        private System.Windows.Forms.TextBox txtGodinaOsnivanja;
        private System.Windows.Forms.TextBox txtNadimak;
        private System.Windows.Forms.ComboBox cmbGrad;
        private System.Windows.Forms.Label lblDodajNoviKlub;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.PictureBox imgGrb;
        private System.Windows.Forms.Button btnDodajKlub;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.ComboBox cmbLiga;
        private System.Windows.Forms.Button upldGrb;
        private System.Windows.Forms.Button btnUredi;
    }
}