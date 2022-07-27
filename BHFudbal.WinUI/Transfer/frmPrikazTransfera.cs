using BHFudbal.Model.QueryObjects;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace BHFudbal.WinUI.Transfer
{
    public partial class frmPrikazTransfera : Form
    {

        private readonly APIService _sezonaService = new APIService("sezona");
        private readonly APIService _transferService = new APIService("transfer");

        public frmPrikazTransfera()
        {
            InitializeComponent();
        }

        private async void frmPrikazTransfera_Load(object sender, EventArgs e)
        {
            dgvTransferi.AutoGenerateColumns = false;
            await LoadSezone();
        }

        private async Task LoadSezone()
        {
            var sezone = await _sezonaService.Get<List<Model.Sezona>>();

            cmbSezona.DataSource = sezone;
            cmbSezona.DisplayMember = "Naziv";
            cmbSezona.ValueMember = "SezonaId";
        }

        private async void btnPrikazi_Click(object sender, EventArgs e)
        {
            var sezonaId = (cmbSezona.SelectedItem as Model.Sezona).SezonaId;
            var request = new TransferSearchObject() { SezonaId = sezonaId };

            var transferi = await _transferService.Get<List<Model.Transfer>>(request);
            dgvTransferi.DataSource = transferi;
        }
    }
}
