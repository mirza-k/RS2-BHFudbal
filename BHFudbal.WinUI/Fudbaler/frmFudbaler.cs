using BHFudbal.Model.Requests;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace BHFudbal.WinUI.Fudbaler
{
    public partial class frmFudbaler : Form
    {
        private readonly APIService _klubService = new APIService("Klub");
        private readonly APIService _fudbalerService = new APIService("FUdbaler");
        private readonly APIService _drzavaService = new APIService("Drzava");

        public frmFudbaler()
        {
            InitializeComponent();
        }

        private async void Form1_Load(object sender, EventArgs e)
        {
           await LoadDrzave();
           await LoadKlubove();
        }

        private async Task LoadDrzave()
        {
            List<Model.Drzava> drzave = await _drzavaService.Get<List<Model.Drzava>>();
            cmbDrzava.DataSource = drzave;
            cmbDrzava.DisplayMember = "Naziv";
            cmbDrzava.ValueMember = "DržavaId";
        }

        private async Task LoadKlubove()
        {
            List<Model.Klub> klubovi = await _klubService.Get<List<Model.Klub>>();
            cmbKlub.DataSource = klubovi;
            cmbKlub.DisplayMember = "Naziv";
            cmbKlub.ValueMember = "KlubId";
        }
        private void Uploadlmage()
        {
            try
            {
                OpenFileDialog dialog = new OpenFileDialog();
                dialog.Filter = "jpg filer(*.jpg)|*.jpg| PNG files(*.png)|*.png";
                if (dialog.ShowDialog() == System.Windows.Forms.DialogResult.OK)
                {
                    string imageLocation = dialog.FileName;

                    pbFudbaler.ImageLocation = imageLocation;
                }
            }
            catch
            {
                MessageBox.Show("An error ocurred.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void btnUploadSliku_Click(object sender, EventArgs e)
        {
            Uploadlmage();
        }

        private async void btnDodaj_Click(object sender, EventArgs e)
        {
            var request = new FudbalerInsertRequest();
            request.Ime = txtIme.Text;
            request.Prezime = txtPrezime.Text;
            request.Visina = txtVisina.Text;
            request.Težina = txtTezina.Text;
            request.JačaNoga = txtJacaNoga.Text;
            request.KlubId = int.Parse(cmbKlub.SelectedValue.ToString());
            request.DrzavaId = int.Parse(cmbDrzava.SelectedValue.ToString());
            request.DatumRodjenja = dpDatumRodjenjanja.Value;

            await _fudbalerService.Post<Model.Fudbaler>(request);
        }
    }
}
