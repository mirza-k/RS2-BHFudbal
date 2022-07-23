using BHFudbal.Model.QueryObjects;
using BHFudbal.Model.Requests;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace BHFudbal.WinUI
{
    public partial class frmDodajTransfer : Form
    {
        private readonly APIService _ligaService = new APIService("Liga");
        private readonly APIService _klubService = new APIService("Klub");
        private readonly APIService _fudbalerService = new APIService("Fudbaler");
        private readonly APIService _transferService = new APIService("Transfer");

        public frmDodajTransfer()
        {
            InitializeComponent();
        }

        private async void frmDodajTransfer_Load(object sender, EventArgs e)
        {
            await LoadLige();
            await LoadNoveLige();
        }

        private async void btnZavrsi_Click(object sender, EventArgs e)
        {
            var request = new TransferInsertRequest()
            {
                FudbalerId = int.Parse(cmbFudbaler.SelectedValue.ToString()),
                KlubId = int.Parse(cmbKlubNovi.SelectedValue.ToString()),
                Cijena = int.Parse(txtCijena.Text),
                BrojGodinaUgovora = int.Parse(txtGodineUgovora.Text),
                SezonaId = 1,
                StariKlubId = int.Parse(cmbKlub.SelectedValue.ToString())
            };

            var validationResults = await IsTransferValid(request);
            if(validationResults != null)
            {
                MessageBox.Show(validationResults);
                return;
            }

            var result = await _transferService.Post<Model.Transfer>(request);

            if (result != null)
                MessageBox.Show("Uspjesno izvrsen transfer.");
        }

        private async Task<string> IsTransferValid(TransferInsertRequest request)
        {
            if (request.StariKlubId == request.KlubId)
            {
                return "Ne moze se izvrsiti transfer između istih klubova!";
            }

            var searchObject = new TransferSearchObject()
            {
                FudbalerId = request.FudbalerId,
                SezonaId = request.SezonaId
            };

            var result = await _transferService.Get<List<Model.Transfer>>(searchObject);
            if(result.Count > 0)
            {
                return "Igrač je već obavio jedan transfer za tekuću sezonu!";
            }

            return null;
        }

        private async Task LoadLige()
        {
            List<Model.Liga> lige = await _ligaService.Get<List<Model.Liga>>();
            cmbLiga.DataSource = lige;
            cmbLiga.DisplayMember = "Naziv";
            cmbLiga.ValueMember = "LigaId1";

            var ligaId = (cmbLiga.SelectedItem as Model.Liga).LigaId1;

            await LoadKlubove(ligaId);
        }

        private async Task LoadNoveLige()
        {
            List<Model.Liga> lige = await _ligaService.Get<List<Model.Liga>>();
            cmbLigaNovi.DataSource = lige;
            cmbLigaNovi.DisplayMember = "Naziv";
            cmbLigaNovi.ValueMember = "LigaId1";

            var ligaId = (cmbLiga.SelectedItem as Model.Liga).LigaId1;

            await LoadNoveKlubove(ligaId);
        }

        private async Task LoadNoveKlubove(int ligaId)
        {
            var request = new KlubSearchObject() { LigaId = ligaId };

            List<Model.Klub> klubovi = await _klubService.Get<List<Model.Klub>>(request);
            cmbKlubNovi.DataSource = klubovi;
            cmbKlubNovi.DisplayMember = "Naziv";
            cmbKlubNovi.ValueMember = "KlubId";

            if (klubovi.Count == 0)
                cmbKlubNovi.ResetText();
        }

        private async Task LoadKlubove(int ligaId)
        {
            var request = new KlubSearchObject() { LigaId = ligaId };

            List<Model.Klub> klubovi = await _klubService.Get<List<Model.Klub>>(request);
            cmbKlub.DataSource = klubovi;
            cmbKlub.DisplayMember = "Naziv";
            cmbKlub.ValueMember = "KlubId";

            var klubId = (cmbKlub.SelectedItem as Model.Klub).KlubId;

            await LoadFudbaleri(klubId);
        }

        private async Task LoadFudbaleri(int klubId)
        {
            var request = new FudbalerSearchObject()
            {
                KlubId = klubId
            };

            var fudbaleri = await _fudbalerService.Get<List<Model.Fudbaler>>(request);
            cmbFudbaler.DataSource = fudbaleri;
            cmbFudbaler.DisplayMember = "Ime";
            cmbFudbaler.ValueMember = "FudbalerId";

            if (fudbaleri.Count == 0)
                cmbFudbaler.ResetText();
        }

        private async void cmbLiga_SelectedIndexChanged(object sender, EventArgs e)
        {
            var ligaId = (cmbLiga.SelectedItem as Model.Liga).LigaId1;
            await LoadKlubove(ligaId);

            var klubId = (cmbKlub.SelectedItem as Model.Klub).KlubId;
            await LoadFudbaleri(klubId);
        }

        private async void cmbKlub_SelectedIndexChanged(object sender, EventArgs e)
        {
            var klubId = (cmbKlub.SelectedItem as Model.Klub).KlubId;
            await LoadFudbaleri(klubId);
        }

        private async void cmbLigaNovi_SelectedIndexChanged(object sender, EventArgs e)
        {
            var ligaId = (cmbLigaNovi.SelectedItem as Model.Liga).LigaId1;
            await LoadNoveKlubove(ligaId);
        }
    }
}
