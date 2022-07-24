using BHFudbal.Model.Enums;
using BHFudbal.Model.Requests;
using BHFudbal.WinUI.Helpers;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace BHFudbal.WinUI.Klub
{
    public partial class frmKlub : Form
    {
        private readonly APIService _gradService = new APIService("Grad");
        private readonly APIService _ligaService = new APIService("Liga");
        private readonly APIService _klubService = new APIService("Klub");
        private readonly ActionType actionType;

        private int KlubId { get; set; }
        public frmKlub()
        {
            InitializeComponent();
        }

        public frmKlub(int klubId, ActionType actionType)
        {
            InitializeComponent();
            if (actionType == ActionType.Update)
            {
                this.actionType = actionType;
                DisplayDetails(klubId);
            }
        }

        private async void DisplayDetails(int klubId)
        {
            await LoadGradove();
            await LoadLige();

            this.KlubId = klubId;

            Model.Klub result = await _klubService.GetById<Model.Klub>(klubId);

            lblDodajNoviKlub.Text = "Uređivanje";

            txtGodinaOsnivanja.Text = result.GodinaOsnivanja.ToString();

            cmbGrad.SelectedValue = result.GradId;

            cmbLiga.SelectedValue = result.LigaId;

            txtNadimak.Text = result.Nadimak;

            txtNadimak.Text = result.Nadimak;

            txtNaziv.Text = result.Naziv;

            if (result.Grb != null && result.Grb.Length > 0)
                imgGrb.Image = ImageHelper.FromByteToImage(result.Grb);

            btnDodajKlub.Visible = false;
            btnUredi.Visible = true;
        }

        private async void frmKlub_Load(object sender, EventArgs e)
        {
            if (actionType != ActionType.Update)
            {
                await LoadGradove();
                await LoadLige();
            }
        }
        private void upldGrb_Click(object sender, EventArgs e)
        {
            UploadGrb();
        }

        private async Task LoadGradove()
        {
            List<Model.Grad> gradovi = await _gradService.Get<List<Model.Grad>>();
            cmbGrad.DataSource = gradovi;
            cmbGrad.DisplayMember = "Naziv";
            cmbGrad.ValueMember = "GradId";
        }

        private async Task LoadLige()
        {
            List<Model.Liga> lige = await _ligaService.Get<List<Model.Liga>>();
            cmbLiga.DataSource = lige;
            cmbLiga.DisplayMember = "Naziv";
            cmbLiga.ValueMember = "LigaId1";
        }

        private void UploadGrb()
        {
            try
            {
                OpenFileDialog dialog = new OpenFileDialog();
                dialog.Filter = "jpg filer(*.jpg)|*.jpg| PNG files(*.png)|*.png";
                if (dialog.ShowDialog() == System.Windows.Forms.DialogResult.OK)
                {
                    string imageLocation = dialog.FileName;

                    imgGrb.ImageLocation = imageLocation;
                }
            }
            catch
            {
                MessageBox.Show("An error ocurred.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private async void btnDodajKlub_Click(object sender, EventArgs e)
        {
            if (!IsRequestValid())
            {
                MessageBoxHelper.ShowErrorMessage("Potrebno popuniti sva polja!", "Greška");
                return;
            }

            var request = new KlubInsertRequest();
            request.GodinaOsnivanja = string.IsNullOrEmpty(txtNadimak.Text) || txtNadimak.Text is string ? 0 : Int32.Parse(txtNadimak.Text);
            request.GradId = int.Parse(cmbGrad.SelectedValue.ToString());
            request.LigaId = int.Parse(cmbLiga.SelectedValue.ToString());
            request.Naziv = txtNaziv.Text;
            request.Grb = ImageHelper.FromImageToByte(imgGrb.Image);

            var result = await _klubService.Post<Model.Klub>(request);

            if (result != null)
            {
                MessageBoxHelper.ShowSuccessMessage("Uspjesno dodan klub!", "");
                Close();
            }
        }

        private async void button1_Click(object sender, EventArgs e)
        {
            if (!IsRequestValid())
            {
                MessageBoxHelper.ShowErrorMessage("Potrebno popuniti sva polja!", "Greška");
                return;
            }

            var request = new KlubUpdateRequest();
            request.GradId = int.Parse(cmbGrad.SelectedValue.ToString());
            request.LigaId = int.Parse(cmbLiga.SelectedValue.ToString());
            request.Naziv = txtNaziv.Text;
            request.Grb = ImageHelper.FromImageToByte(imgGrb.Image);
            request.Nadimak = txtNadimak.Text;

            int godinaOsnivanja;
            if (int.TryParse(txtGodinaOsnivanja.Text, out godinaOsnivanja))
                request.GodinaOsnivanja = godinaOsnivanja;

            var result = await _klubService.Update<Model.Klub>(this.KlubId, request);
            if (result != null)
            {
                MessageBoxHelper.ShowSuccessMessage("Uspjesno ste uredili informacije o klubu!", "");
                Close();
            }
        }

        private bool IsRequestValid()
        {
            return
                !string.IsNullOrEmpty(txtGodinaOsnivanja.Text) &&
                !string.IsNullOrEmpty(txtNaziv.Text) &&
                !string.IsNullOrEmpty(txtNadimak.Text) &&
                cmbGrad.SelectedValue != null &&
                cmbLiga.SelectedValue != null;
        }
    }
}
