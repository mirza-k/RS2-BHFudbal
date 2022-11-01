
namespace BHFudbal.WinUI.Izvjestaj
{
    partial class frmIzvjestaj
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
            this.btnGenerisi = new System.Windows.Forms.Button();
            this.cmbSezona = new System.Windows.Forms.ComboBox();
            this.SuspendLayout();
            // 
            // btnGenerisi
            // 
            this.btnGenerisi.Location = new System.Drawing.Point(229, 118);
            this.btnGenerisi.Name = "btnGenerisi";
            this.btnGenerisi.Size = new System.Drawing.Size(121, 37);
            this.btnGenerisi.TabIndex = 0;
            this.btnGenerisi.Text = "Generisi PDF";
            this.btnGenerisi.UseVisualStyleBackColor = true;
            this.btnGenerisi.Click += new System.EventHandler(this.btnGenerisi_Click);
            // 
            // cmbSezona
            // 
            this.cmbSezona.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmbSezona.FormattingEnabled = true;
            this.cmbSezona.Location = new System.Drawing.Point(229, 53);
            this.cmbSezona.Name = "cmbSezona";
            this.cmbSezona.Size = new System.Drawing.Size(121, 33);
            this.cmbSezona.TabIndex = 1;
            // 
            // frmIzvjestaj
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.cmbSezona);
            this.Controls.Add(this.btnGenerisi);
            this.Name = "frmIzvjestaj";
            this.Text = "frmIzvjestaj";
            this.Load += new System.EventHandler(this.frmIzvjestaj_Load);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Button btnGenerisi;
        private System.Windows.Forms.ComboBox cmbSezona;
    }
}