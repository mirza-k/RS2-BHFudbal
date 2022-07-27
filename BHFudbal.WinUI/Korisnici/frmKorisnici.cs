using BHFudbal.Model.QueryObjects;
using System;
using System.Collections.Generic;
using System.Windows.Forms;

namespace BHFudbal.WinUI.Korisnici
{
    public partial class frmKorisnici : Form
    {
        public APIService _korisnikService = new APIService("Korisnik");
        public frmKorisnici()
        {
            InitializeComponent();
        }

        private async void btnPrikazi_Click(object sender, EventArgs e)
        {
            var search = new KorisnikSearchObject()
            {
                Ime = txtPretraga.Text
            };

            var result = await _korisnikService.Get<List<Model.Korisnik>>(search);
            dgvKorisnici.DataSource = result;
        }

        private void frmKorisnici_Load(object sender, EventArgs e)
        {
            dgvKorisnici.AutoGenerateColumns = false;
        }
    }
}
