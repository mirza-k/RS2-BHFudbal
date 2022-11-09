
namespace BHFudbal.WinUI.MDIHome
{
    partial class MDIHomeFrm
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
            this.menuStrip1 = new System.Windows.Forms.MenuStrip();
            this.korisniciToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.kluboviToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.fudbaleriToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.transferiToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.logoutToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.izvjestajToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.matchToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.prikazKlubovaToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.dodajNoviKlubToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.prikaziFudbalereToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.dodajNovogFudbaleraToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.prikazTransferaToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.izvršiTransferToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.menuStrip1.SuspendLayout();
            this.SuspendLayout();
            // 
            // menuStrip1
            // 
            this.menuStrip1.ImageScalingSize = new System.Drawing.Size(20, 20);
            this.menuStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.korisniciToolStripMenuItem,
            this.kluboviToolStripMenuItem,
            this.fudbaleriToolStripMenuItem,
            this.transferiToolStripMenuItem,
            this.izvjestajToolStripMenuItem,
            this.matchToolStripMenuItem,
            this.logoutToolStripMenuItem});
            this.menuStrip1.Location = new System.Drawing.Point(0, 0);
            this.menuStrip1.Name = "menuStrip1";
            this.menuStrip1.Size = new System.Drawing.Size(1169, 28);
            this.menuStrip1.TabIndex = 0;
            this.menuStrip1.Text = "menuStrip1";
            // 
            // korisniciToolStripMenuItem
            // 
            this.korisniciToolStripMenuItem.Name = "korisniciToolStripMenuItem";
            this.korisniciToolStripMenuItem.Size = new System.Drawing.Size(79, 24);
            this.korisniciToolStripMenuItem.Text = "Korisnici";
            this.korisniciToolStripMenuItem.Click += new System.EventHandler(this.korisniciToolStripMenuItem_Click);
            // 
            // kluboviToolStripMenuItem
            // 
            this.kluboviToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.prikazKlubovaToolStripMenuItem,
            this.dodajNoviKlubToolStripMenuItem});
            this.kluboviToolStripMenuItem.Name = "kluboviToolStripMenuItem";
            this.kluboviToolStripMenuItem.Size = new System.Drawing.Size(73, 24);
            this.kluboviToolStripMenuItem.Text = "Klubovi";
            // 
            // fudbaleriToolStripMenuItem
            // 
            this.fudbaleriToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.prikaziFudbalereToolStripMenuItem,
            this.dodajNovogFudbaleraToolStripMenuItem});
            this.fudbaleriToolStripMenuItem.Name = "fudbaleriToolStripMenuItem";
            this.fudbaleriToolStripMenuItem.Size = new System.Drawing.Size(85, 24);
            this.fudbaleriToolStripMenuItem.Text = "Fudbaleri";
            // 
            // transferiToolStripMenuItem
            // 
            this.transferiToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.prikazTransferaToolStripMenuItem,
            this.izvršiTransferToolStripMenuItem});
            this.transferiToolStripMenuItem.Name = "transferiToolStripMenuItem";
            this.transferiToolStripMenuItem.Size = new System.Drawing.Size(79, 24);
            this.transferiToolStripMenuItem.Text = "Transferi";
            // 
            // logoutToolStripMenuItem
            // 
            this.logoutToolStripMenuItem.Name = "logoutToolStripMenuItem";
            this.logoutToolStripMenuItem.Size = new System.Drawing.Size(70, 24);
            this.logoutToolStripMenuItem.Text = "Logout";
            this.logoutToolStripMenuItem.Click += new System.EventHandler(this.logoutToolStripMenuItem_Click);
            // 
            // izvjestajToolStripMenuItem
            // 
            this.izvjestajToolStripMenuItem.Name = "izvjestajToolStripMenuItem";
            this.izvjestajToolStripMenuItem.Size = new System.Drawing.Size(76, 24);
            this.izvjestajToolStripMenuItem.Text = "Izvjestaj";
            this.izvjestajToolStripMenuItem.Click += new System.EventHandler(this.izvjestajToolStripMenuItem_Click);
            // 
            // matchToolStripMenuItem
            // 
            this.matchToolStripMenuItem.Name = "matchToolStripMenuItem";
            this.matchToolStripMenuItem.Size = new System.Drawing.Size(64, 24);
            this.matchToolStripMenuItem.Text = "Match";
            this.matchToolStripMenuItem.Click += new System.EventHandler(this.matchToolStripMenuItem_Click);
            // 
            // prikazKlubovaToolStripMenuItem
            // 
            this.prikazKlubovaToolStripMenuItem.Name = "prikazKlubovaToolStripMenuItem";
            this.prikazKlubovaToolStripMenuItem.Size = new System.Drawing.Size(224, 26);
            this.prikazKlubovaToolStripMenuItem.Text = "Prikaz klubova";
            this.prikazKlubovaToolStripMenuItem.Click += new System.EventHandler(this.prikazKlubovaToolStripMenuItem_Click);
            // 
            // dodajNoviKlubToolStripMenuItem
            // 
            this.dodajNoviKlubToolStripMenuItem.Name = "dodajNoviKlubToolStripMenuItem";
            this.dodajNoviKlubToolStripMenuItem.Size = new System.Drawing.Size(224, 26);
            this.dodajNoviKlubToolStripMenuItem.Text = "Dodaj novi klub";
            this.dodajNoviKlubToolStripMenuItem.Click += new System.EventHandler(this.dodajNoviKlubToolStripMenuItem_Click);
            // 
            // prikaziFudbalereToolStripMenuItem
            // 
            this.prikaziFudbalereToolStripMenuItem.Name = "prikaziFudbalereToolStripMenuItem";
            this.prikaziFudbalereToolStripMenuItem.Size = new System.Drawing.Size(247, 26);
            this.prikaziFudbalereToolStripMenuItem.Text = "Prikazi fudbalere";
            this.prikaziFudbalereToolStripMenuItem.Click += new System.EventHandler(this.prikaziFudbalereToolStripMenuItem_Click);
            // 
            // dodajNovogFudbaleraToolStripMenuItem
            // 
            this.dodajNovogFudbaleraToolStripMenuItem.Name = "dodajNovogFudbaleraToolStripMenuItem";
            this.dodajNovogFudbaleraToolStripMenuItem.Size = new System.Drawing.Size(247, 26);
            this.dodajNovogFudbaleraToolStripMenuItem.Text = "Dodaj novog fudbalera";
            this.dodajNovogFudbaleraToolStripMenuItem.Click += new System.EventHandler(this.dodajNovogFudbaleraToolStripMenuItem_Click);
            // 
            // prikazTransferaToolStripMenuItem
            // 
            this.prikazTransferaToolStripMenuItem.Name = "prikazTransferaToolStripMenuItem";
            this.prikazTransferaToolStripMenuItem.Size = new System.Drawing.Size(224, 26);
            this.prikazTransferaToolStripMenuItem.Text = "Prikaz transfera";
            this.prikazTransferaToolStripMenuItem.Click += new System.EventHandler(this.prikazTransferaToolStripMenuItem_Click);
            // 
            // izvršiTransferToolStripMenuItem
            // 
            this.izvršiTransferToolStripMenuItem.Name = "izvršiTransferToolStripMenuItem";
            this.izvršiTransferToolStripMenuItem.Size = new System.Drawing.Size(224, 26);
            this.izvršiTransferToolStripMenuItem.Text = "Izvrši transfer";
            this.izvršiTransferToolStripMenuItem.Click += new System.EventHandler(this.izvršiTransferToolStripMenuItem_Click);
            // 
            // MDIHomeFrm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1169, 597);
            this.Controls.Add(this.menuStrip1);
            this.IsMdiContainer = true;
            this.MainMenuStrip = this.menuStrip1;
            this.Name = "MDIHomeFrm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "MDIHomeFrm";
            this.menuStrip1.ResumeLayout(false);
            this.menuStrip1.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.MenuStrip menuStrip1;
        private System.Windows.Forms.ToolStripMenuItem korisniciToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem kluboviToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem fudbaleriToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem transferiToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem logoutToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem izvjestajToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem matchToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem prikazKlubovaToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem dodajNoviKlubToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem prikaziFudbalereToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem dodajNovogFudbaleraToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem prikazTransferaToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem izvršiTransferToolStripMenuItem;
    }
}