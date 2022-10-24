using BHFudbal.Model.QueryObjects;
using BHFudbal.WinUI.Helpers;
using System;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace BHFudbal.WinUI.Match
{
    public partial class frmPrikazMatch : Form
    {
        public frmPrikazMatch()
        {
            InitializeComponent();
        }

        private void frmPrikazMatch_Load(object sender, EventArgs e)
        {
            LoadSezone();
        }

        private async void LoadSezone()
        {
            await ServiceHelper<SezonaSearchObject, Model.Sezona>.Load("Sezona", cmbSezona, "Naziv", "SezonaId", null);
            var sezonaId = (cmbSezona.SelectedItem as Model.Sezona).SezonaId;
            await LoadLige(sezonaId);
        }

        private async Task LoadLige(int sezonaId)
        {
            var request = new LigaSearchObject() { SezonaId = sezonaId };
            await ServiceHelper<LigaSearchObject, Model.Liga>.Load("Liga", cmbLiga, "Naziv", "LigaId1", request);
        }

        private async void cmbSezona_SelectedIndexChanged(object sender, EventArgs e)
        {
            var sezonaId = (cmbSezona.SelectedItem as Model.Sezona).SezonaId;
            await LoadLige(sezonaId);
        }

        private async void btnPrikazi_Click(object sender, EventArgs e)
        {
            MatchSearchObject request = new MatchSearchObject() { LigaId = (cmbLiga.SelectedItem as Model.Liga).LigaId1 };
            await ServiceHelper<MatchSearchObject, Model.Match>.Load("Match", lbMatches, "Prikaz", "MatchId", request);
        }
    }
}
