using BHFudbal.Model.QueryObjects;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace BHFudbal.WinUI.Klub
{
    public partial class frmPrikazKlubova : Form
    {
        private readonly APIService _klubService = new APIService("Klub");
        private readonly APIService _ligaService = new APIService("Liga");
        public frmPrikazKlubova()
        {
            InitializeComponent();
        }

        private async void frmPrikazKlubova_Load(object sender, EventArgs e)
        {
            await LoadLige();
            dgvKlub.AutoGenerateColumns = false;
        }

        private async Task LoadLige()
        {
            List<Model.Liga> lige = await _ligaService.Get<List<Model.Liga>>();
            cmbLiga.DataSource = lige;
            cmbLiga.DisplayMember = "Naziv";
            cmbLiga.ValueMember = "LigaId1";
        }

        private async void button1_Click(object sender, EventArgs e)
        {
            await RefreshGrid();
        }

        private void dgvKlub_CellDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            if (dgvKlub.SelectedRows.Count > 0)
            {
                var k = dgvKlub.SelectedRows[0].DataBoundItem as Model.Klub;

                if (k != null)
                {
                    frmKlub frm = new frmKlub(k.KlubId, Model.Enums.ActionType.Update);
                    frm.FormClosed += new FormClosedEventHandler(frmKlub_ClosedEvent);
                    frm.ShowDialog();
                }
            }
        }

        public async void frmKlub_ClosedEvent(object sender, EventArgs e)
        {
            await RefreshGrid();
        }

        private async Task RefreshGrid()
        {
            var currentLigeId = int.Parse(cmbLiga.SelectedValue.ToString());
            var request = new KlubSearchObject() { LigaId = currentLigeId };
            var result = await _klubService.Get<List<Model.Klub>>(request);
            dgvKlub.DataSource = result;
        }
    }
}
