using BHFudbal.WinUI.Fudbaler;
using BHFudbal.WinUI.Izvjestaj;
using BHFudbal.WinUI.Klub;
using BHFudbal.WinUI.Korisnici;
using BHFudbal.WinUI.Match;
using BHFudbal.WinUI.Transfer;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace BHFudbal.WinUI.MDIHome
{
    public partial class MDIHomeFrm : Form
    {
        public MDIHomeFrm()
        {
            InitializeComponent();
        }

        private void korisniciToolStripMenuItem_Click(object sender, EventArgs e)
        {
            ShowForm(new frmKorisnici());
        }

        private void kluboviToolStripMenuItem_Click(object sender, EventArgs e)
        {
            ShowForm(new frmKlub());

        }

        private void ShowForm(Form frm)
        {
            if (MdiChildren.FirstOrDefault() != null)
                MdiChildren.First().Close();

            frm.MdiParent = this;
            frm.Show();
        }

        private void fudbaleriToolStripMenuItem_Click(object sender, EventArgs e)
        {
            ShowForm(new frmFudbaler());
        }

        private void transferiToolStripMenuItem_Click(object sender, EventArgs e)
        {
            ShowForm(new frmFudbaler());
        }

        private void logoutToolStripMenuItem_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void izvjestajToolStripMenuItem_Click(object sender, EventArgs e)
        {
            ShowForm(new frmIzvjestaj());
        }

        private void matchToolStripMenuItem_Click(object sender, EventArgs e)
        {
            ShowForm(new frmPrikazMatch());
        }

        private void prikazKlubovaToolStripMenuItem_Click(object sender, EventArgs e)
        {
            ShowForm(new frmPrikazKlubova());
        }

        private void dodajNoviKlubToolStripMenuItem_Click(object sender, EventArgs e)
        {
            ShowForm(new frmKlub());
        }

        private void prikaziFudbalereToolStripMenuItem_Click(object sender, EventArgs e)
        {
            ShowForm(new frmPrikazFudbalera());
        }

        private void dodajNovogFudbaleraToolStripMenuItem_Click(object sender, EventArgs e)
        {
            ShowForm(new frmFudbaler());
        }

        private void prikazTransferaToolStripMenuItem_Click(object sender, EventArgs e)
        {
            ShowForm(new frmPrikazTransfera());
        }

        private void izvršiTransferToolStripMenuItem_Click(object sender, EventArgs e)
        {
            ShowForm(new frmDodajTransfer());
        }
    }
}
