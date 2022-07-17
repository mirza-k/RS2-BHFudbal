using BHFudbal.Model.Requests;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace BHFudbal.WinUI.Klub
{
    public partial class frmKlub : Form
    {
        private readonly APIService _gradService = new APIService("Grad");
        private readonly APIService _ligaService = new APIService("Liga");
        private readonly APIService _klubService = new APIService("Klub");
        public frmKlub()
        {
            InitializeComponent();
        }

        private async void frmKlub_Load(object sender, EventArgs e)
        {
            await LoadGradove();
            await LoadLige();
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

        private byte[] FromImageToByte(Image image)
        {
            ImageConverter converter = new ImageConverter();
            return (byte[])converter.ConvertTo(image, typeof(byte[]));
        }

        private async void btnDodajKlub_Click(object sender, EventArgs e)
        {
            var request = new KlubInsertRequest();
            request.GodinaOsnivanja = string.IsNullOrEmpty(txtGodinaOsnivanja.Text) || txtGodinaOsnivanja.Text is string ? 0 : Int32.Parse(txtGodinaOsnivanja.Text);
            request.GradId = int.Parse(cmbGrad.SelectedValue.ToString());
            request.LigaId = int.Parse(cmbLiga.SelectedValue.ToString());
            request.Nadimak = txtNadimak.Text;
            request.Naziv = txtNaziv.Text;
            request.Grb = FromImageToByte(imgGrb.Image);

            await _klubService.Post<Model.Klub>(request);
        }
    }
}
