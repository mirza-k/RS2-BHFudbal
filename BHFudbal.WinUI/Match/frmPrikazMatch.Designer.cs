
namespace BHFudbal.WinUI.Match
{
    partial class frmPrikazMatch
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
            this.cmbSezona = new System.Windows.Forms.ComboBox();
            this.cmbLiga = new System.Windows.Forms.ComboBox();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.btnPrikazi = new System.Windows.Forms.Button();
            this.lbMatches = new System.Windows.Forms.ListBox();
            this.SuspendLayout();
            // 
            // cmbSezona
            // 
            this.cmbSezona.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cmbSezona.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmbSezona.FormattingEnabled = true;
            this.cmbSezona.Location = new System.Drawing.Point(12, 38);
            this.cmbSezona.Name = "cmbSezona";
            this.cmbSezona.Size = new System.Drawing.Size(163, 33);
            this.cmbSezona.TabIndex = 0;
            this.cmbSezona.SelectedIndexChanged += new System.EventHandler(this.cmbSezona_SelectedIndexChanged);
            // 
            // cmbLiga
            // 
            this.cmbLiga.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cmbLiga.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmbLiga.FormattingEnabled = true;
            this.cmbLiga.Location = new System.Drawing.Point(260, 38);
            this.cmbLiga.Name = "cmbLiga";
            this.cmbLiga.Size = new System.Drawing.Size(163, 33);
            this.cmbLiga.TabIndex = 1;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(255, 10);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(49, 25);
            this.label1.TabIndex = 2;
            this.label1.Text = "Liga";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(7, 10);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(80, 25);
            this.label2.TabIndex = 3;
            this.label2.Text = "Sezona";
            // 
            // btnPrikazi
            // 
            this.btnPrikazi.Location = new System.Drawing.Point(491, 38);
            this.btnPrikazi.Name = "btnPrikazi";
            this.btnPrikazi.Size = new System.Drawing.Size(90, 33);
            this.btnPrikazi.TabIndex = 4;
            this.btnPrikazi.Text = "Prikaži";
            this.btnPrikazi.UseVisualStyleBackColor = true;
            this.btnPrikazi.Click += new System.EventHandler(this.btnPrikazi_Click);
            // 
            // lbMatches
            // 
            this.lbMatches.Font = new System.Drawing.Font("Microsoft Sans Serif", 13.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbMatches.FormattingEnabled = true;
            this.lbMatches.ItemHeight = 29;
            this.lbMatches.Location = new System.Drawing.Point(12, 99);
            this.lbMatches.Name = "lbMatches";
            this.lbMatches.Size = new System.Drawing.Size(569, 265);
            this.lbMatches.TabIndex = 7;
            // 
            // frmPrikazMatch
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(598, 382);
            this.Controls.Add(this.lbMatches);
            this.Controls.Add(this.btnPrikazi);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.cmbLiga);
            this.Controls.Add(this.cmbSezona);
            this.Name = "frmPrikazMatch";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "frmPrikazMatch";
            this.Load += new System.EventHandler(this.frmPrikazMatch_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.ComboBox cmbSezona;
        private System.Windows.Forms.ComboBox cmbLiga;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Button btnPrikazi;
        private System.Windows.Forms.ListBox lbMatches;
    }
}