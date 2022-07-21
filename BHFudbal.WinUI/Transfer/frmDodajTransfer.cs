using BHFudbal.Model.QueryObjects;
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

        public frmDodajTransfer()
        {
            InitializeComponent();
        }

        private async void frmDodajTransfer_Load(object sender, EventArgs e)
        {
            await LoadLige();
            await LoadNoveLige();
        }

        private void btnZavrsi_Click(object sender, EventArgs e)
        {

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
