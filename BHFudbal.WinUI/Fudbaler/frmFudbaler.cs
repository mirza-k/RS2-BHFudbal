using BHFudbal.Model.Enums;
using BHFudbal.Model.Requests;
using BHFudbal.WinUI.Helpers;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace BHFudbal.WinUI.Fudbaler
{
    public partial class frmFudbaler : Form
    {
        private readonly APIService _klubService = new APIService("Klub");
        private readonly APIService _fudbalerService = new APIService("FUdbaler");
        private readonly APIService _drzavaService = new APIService("Drzava");
        private int FudbalerId;
        private ActionType actionType;

        public frmFudbaler()
        {
            InitializeComponent();
        }

        public frmFudbaler(int fudbalerId, ActionType actionType)
        {
            InitializeComponent();
            if (actionType == ActionType.Update)
            {
                this.actionType = actionType;
                DisplayDetails(fudbalerId);
            }

        }
        private async void Form1_Load(object sender, EventArgs e)
        {
            if (this.actionType != ActionType.Update)
            {
                await LoadDrzave();
                await LoadKlubove();
            }
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
                MessageBoxHelper.ShowErrorMessage("Desila se greška!", "Greška");
            }
        }

        private void btnUploadSliku_Click(object sender, EventArgs e)
        {
            Uploadlmage();
        }

        private async void btnDodaj_Click(object sender, EventArgs e)
        {
            if (!isRequestValid())
            {
                MessageBoxHelper.ShowErrorMessage("Potrebno popuniti sva polja!", "Greška");
                return;
            }

            var request = new FudbalerInsertRequest();
            request.Ime = txtIme.Text;
            request.Prezime = txtPrezime.Text;
            request.Težina = txtTezina.Text;
            request.JačaNoga = txtJacaNoga.Text;
            request.KlubId = int.Parse(cmbKlub.SelectedValue.ToString());
            request.DrzavaId = int.Parse(cmbDrzava.SelectedValue.ToString());
            request.DatumRodjenja = dpDatumRodjenjanja.Value;
            request.Slika = ImageHelper.FromImageToByte(pbFudbaler.Image);

            int visina;
            if (int.TryParse(txtVisina.Text, out visina))
                request.Visina = visina.ToString();
            else
            {
                MessageBox.Show("Visina mora biti numericka vrijednost!");
                return;
            }
            
            int tezina;
            if (int.TryParse(txtTezina.Text, out tezina))
                request.Težina = tezina.ToString();
            else
            {
                MessageBox.Show("Tezina mora biti numericka vrijednost!");
                return;
            }

            var result = await _fudbalerService.Post<Model.Fudbaler>(request);

            if (result != null)
            {
                MessageBoxHelper.ShowSuccessMessage("Uspjesno dodan fudbaler.", "");
                Close();
            }
        }

        private async void DisplayDetails(int fudbalerId)
        {
            await LoadKlubove();
            await LoadDrzave();

            this.FudbalerId = fudbalerId;
            Model.Fudbaler result = await _fudbalerService.GetById<Model.Fudbaler>(fudbalerId);

            lblDodajNoviKlub.Text = "Uredi";

            txtIme.Text = result.Ime;

            txtPrezime.Text = result.Prezime;

            txtVisina.Text = result.Visina;

            txtTezina.Text = result.Težina;

            txtJacaNoga.Text = result.JačaNoga;

            cmbKlub.SelectedValue = result.KlubId;

            cmbDrzava.SelectedValue = result.DrzavaId;

            dpDatumRodjenjanja.Value = result.DatumRodjenja;

            if (result.Slika != null && result.Slika.Length > 0)
                pbFudbaler.Image = ImageHelper.FromByteToImage(result.Slika);

            btnDodaj.Visible = false;
            btnUredi.Visible = true;
        }

        private async void btnUredi_Click(object sender, EventArgs e)
        {
            if (!isRequestValid())
            {
                MessageBoxHelper.ShowErrorMessage("Potrebno popuniti sva polja!", "Greška");
                return;
            }

            var request = new FudbalerUpdateRequest();
            request.Ime = txtIme.Text;
            request.Prezime = txtPrezime.Text;
            request.Visina = txtVisina.Text;
            request.Težina = txtTezina.Text;
            request.JačaNoga = txtJacaNoga.Text;
            request.KlubId = int.Parse(cmbKlub.SelectedValue.ToString());
            request.DrzavaId = int.Parse(cmbDrzava.SelectedValue.ToString());
            request.DatumRodjenja = dpDatumRodjenjanja.Value;
            request.Slika = ImageHelper.FromImageToByte(pbFudbaler.Image);

            var result = await _fudbalerService.Update<Model.Fudbaler>(this.FudbalerId, request);

            if (result != null)
            {
                MessageBoxHelper.ShowSuccessMessage("Uspjesno uređene informacije o fudbaleru.", "");
                Close();
            }
        }

        private bool isRequestValid()
        {
            return
                cmbDrzava.SelectedValue != null &&
                cmbKlub.SelectedValue != null &&
                !string.IsNullOrEmpty(txtIme.Text) &&
                !string.IsNullOrEmpty(txtPrezime.Text) &&
                !string.IsNullOrEmpty(txtVisina.Text) &&
                !string.IsNullOrEmpty(txtTezina.Text) &&
                !string.IsNullOrEmpty(txtJacaNoga.Text) &&
                dpDatumRodjenjanja.Value != null;
        }

    }
}
