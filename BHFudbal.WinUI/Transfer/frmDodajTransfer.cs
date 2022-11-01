using BHFudbal.Model;
using BHFudbal.Model.QueryObjects;
using BHFudbal.Model.Requests;
using BHFudbal.WinUI.Helpers;
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
            if (!isRequestValid())
            {
                return;
            }

            var request = new TransferInsertRequest()
            {
                FudbalerId = int.Parse(cmbFudbaler.SelectedValue.ToString()),
                KlubId = int.Parse(cmbKlubNovi.SelectedValue.ToString()),
                SezonaId = 4,
                StariKlubId = int.Parse(cmbKlub.SelectedValue.ToString())
            };

            int cijena;
            if (int.TryParse(txtCijena.Text, out cijena))
                request.Cijena = cijena;

            int brojGodinaUgovora;
            if (int.TryParse(txtGodineUgovora.Text, out brojGodinaUgovora))
                request.BrojGodinaUgovora = brojGodinaUgovora;

            var validationResults = await IsTransferValid(request);
            if (validationResults != null)
            {
                MessageBox.Show(validationResults);
                return;
            }

            var result = await _transferService.Post<Model.Transfer>(request);

            if (result != null)
            {
                await UpdatePlayerAfterCompleteTransfer(request);
                await LoadLige();
                await LoadNoveLige();
                MessageBox.Show("Uspješno izvršen transfer.");
            }
        }

        private bool isRequestValid()
        {
            return
                cmbFudbaler.SelectedValue != null &&
                cmbKlub.SelectedValue != null &&
                cmbKlubNovi.SelectedValue != null &&
                cmbLiga.SelectedValue != null &&
                cmbLigaNovi != null;
        }

        private async Task<string> IsTransferValid(TransferInsertRequest request)
        {
            if (request.StariKlubId == request.KlubId)
            {
                return "Ne moze se izvršiti transfer između istih klubova!";
            }

            var searchObject = new TransferSearchObject()
            {
                FudbalerId = request.FudbalerId,
                SezonaId = request.SezonaId
            };

            var result = await _transferService.Get<List<Model.Transfer>>(searchObject);
            if (result.Count > 0)
            {
                return "Fudbaler je već obavio jedan transfer za tekuću sezonu!";
            }

            return null;
        }

        private async Task LoadLige()
        {
            await ServiceHelper<LigaSearchObject, Liga>.Load("Liga", cmbLiga, "Naziv", "LigaId1", null);
            var ligaId = (cmbLiga.SelectedItem as Model.Liga).LigaId1;
            await LoadKlubove(ligaId);
        }

        private async Task LoadNoveLige()
        {
            await ServiceHelper<LigaSearchObject, Model.Liga>.Load("Liga", cmbLigaNovi, "Naziv", "LigaId1", null);
            var ligaId = (cmbLiga.SelectedItem as Model.Liga).LigaId1;
            await LoadNoveKlubove(ligaId);
        }

        private async Task LoadNoveKlubove(int ligaId)
        {
            var request = new KlubSearchObject() { LigaId = ligaId };
            var models = await ServiceHelper<KlubSearchObject, Model.Klub>.Load("Klub", cmbKlubNovi, "Naziv", "KlubId", request);
            if (models.Count == 0)
                cmbKlubNovi.ResetText();
        }

        private async Task LoadKlubove(int ligaId)
        {
            var request = new KlubSearchObject() { LigaId = ligaId };
            await ServiceHelper<KlubSearchObject, Model.Klub>.Load("Klub", cmbKlub, "Naziv", "KlubId", request);
            var klubId = (cmbKlub.SelectedItem as Model.Klub).KlubId;
            await LoadFudbaleri(klubId);
        }

        private async Task LoadFudbaleri(int klubId)
        {
            var request = new FudbalerSearchObject() { KlubId = klubId };
            var models = await ServiceHelper<FudbalerSearchObject, Model.Fudbaler>.Load("Fudbaler", cmbFudbaler, "Ime", "FudbalerId", request);
            if (models.Count == 0)
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

        private async Task UpdatePlayerAfterCompleteTransfer(TransferInsertRequest request)
        {
            var fudbaler = await _fudbalerService.GetById<Model.Fudbaler>(request.FudbalerId);
            fudbaler.KlubId = request.KlubId;
            await _fudbalerService.Update<Model.Fudbaler>(fudbaler.FudbalerId, fudbaler);
        }
    }
}
