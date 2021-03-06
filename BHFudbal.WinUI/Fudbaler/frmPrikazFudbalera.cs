using BHFudbal.Model.Enums;
using BHFudbal.Model.QueryObjects;
using BHFudbal.Model.Requests;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace BHFudbal.WinUI.Fudbaler
{
    public partial class frmPrikazFudbalera : Form
    {
        private readonly APIService _ligaService = new APIService("Liga");
        private readonly APIService _klubService = new APIService("Klub");
        private readonly APIService _fudbalerService = new APIService("Fudbaler");
        public frmPrikazFudbalera()
        {
            InitializeComponent();
        }

        private async void PrikazFudbalera_Load(object sender, EventArgs e)
        {
            dgvFudbaleri.AutoGenerateColumns = false;
            await LoadLige();
        }

        private async void cmbPrikazi_Click(object sender, EventArgs e)
        {
            await RefreshGrid();
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

        private async Task LoadKlubove(int id)
        {
            var request = new KlubSearchObject() { LigaId = id };

            List<Model.Klub> klubovi = await _klubService.Get<List<Model.Klub>>(request);
            cmbKlub.DataSource = klubovi;
            cmbKlub.DisplayMember = "Naziv";
            cmbKlub.ValueMember = "KlubId";
        }

        private void dgvFudbaleri_CellDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            if (dgvFudbaleri.SelectedRows.Count > 0)
            {
                var f = dgvFudbaleri.SelectedRows[0].DataBoundItem as Model.Fudbaler;

                if (f != null)
                {
                    frmFudbaler frm = new frmFudbaler(f.FudbalerId, ActionType.Update);
                    frm.FormClosed += new FormClosedEventHandler(frmFudbaler_Closed);
                    frm.ShowDialog();
                }
            }
        }

        async void frmFudbaler_Closed(object sender, EventArgs e)
        {
            await RefreshGrid();
        }

        private async void cmbLiga_SelectedIndexChanged(object sender, EventArgs e)
        {
            var ligaId = (cmbLiga.SelectedItem as Model.Liga).LigaId1;
            await LoadKlubove(ligaId);
        }

        private async Task RefreshGrid()
        {
            var request = new FudbalerSearchObject() { KlubId = int.Parse(cmbKlub.SelectedValue.ToString()) };

            var result = await _fudbalerService.Get<List<Model.Fudbaler>>(request);
            dgvFudbaleri.DataSource = result;
        }

    }
}
