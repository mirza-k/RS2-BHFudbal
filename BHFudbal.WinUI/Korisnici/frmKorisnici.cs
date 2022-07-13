using BHFudbal.Model.QueryObjects;
using System;
using System.Collections.Generic;
using System.Windows.Forms;

namespace BHFudbal.WinUI.Korisnici
{
    public partial class frmKorisnici : Form
    {
        public APIService _apiService = new APIService("Grad");
        public frmKorisnici()
        {
            InitializeComponent();
        }

        private async void btnPrikazi_Click(object sender, EventArgs e)
        {
            var search = new GradSearchObject()
            {
                Naziv = txtPretraga.Text
            };

            var result = await _apiService.Get<List<Model.Grad>>(search);
            dgvKorisnici.DataSource = result;
        }
    }
}
