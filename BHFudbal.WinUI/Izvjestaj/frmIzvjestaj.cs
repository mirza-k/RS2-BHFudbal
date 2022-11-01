using BHFudbal.Model.QueryObjects;
using BHFudbal.WinUI.Helpers;
using PdfSharp.Drawing;
using PdfSharp.Pdf;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace BHFudbal.WinUI.Izvjestaj
{
    public partial class frmIzvjestaj : Form
    {
        private APIService _transferReportService;
        public frmIzvjestaj()
        {
            InitializeComponent();
        }

        private async Task LoadSezona()
        {
            await ServiceHelper<SezonaSearchObject, Model.Sezona>.Load("Sezona", cmbSezona, "Naziv", "SezonaId", null);

        }
        private async void frmIzvjestaj_Load(object sender, EventArgs e)
        {
            await LoadSezona();
        }

        private async void btnGenerisi_Click(object sender, EventArgs e)
        {
            using (SaveFileDialog sfd = new SaveFileDialog())
            {
                sfd.Filter = "pdf files (*.pdf)|*.pdf|All files (*.*)|*.*";
                //sfd.DefaultExt = "pdf";
                if (sfd.ShowDialog() == DialogResult.OK)
                {
                    var report = await GetReport();

                    PdfDocument pdfDocument = new PdfDocument();
                    pdfDocument.Info.Title = "Izvještaj o transferima klubova";

                    PdfPage page = pdfDocument.AddPage();
                    XGraphics gfx = XGraphics.FromPdfPage(page);
                    XFont font = new XFont("Arial", 20);
                    gfx.DrawString("Izvjestaj o transferima", font, XBrushes.DarkRed, new XPoint(200, 70));
                    gfx.DrawLine(new XPen(XColor.FromArgb(50, 30, 200)), new XPoint(100, 100), new XPoint(500, 100));

                    gfx.DrawString("Klub", font, XBrushes.Black, new XPoint(100, 280));
                    gfx.DrawString("Broj transfera", font, XBrushes.Black, new XPoint(200, 280));
                    gfx.DrawString("Potrošeno novca", font, XBrushes.Black, new XPoint(380, 280));

                    gfx.DrawLine(new XPen(XColor.FromArgb(50, 30, 200)), new XPoint(100, 290), new XPoint(530, 290));


                    int current_Y_value = 310;
                    //int current_Y_line = 320;

                    foreach (Model.Report r in report)
                    {
                        gfx.DrawString(r.ImeKluba, font, XBrushes.Black, new XPoint(100, current_Y_value));
                        gfx.DrawString(r.UkupnoIzvrsenihTransfera.ToString(), font, XBrushes.Black, new XPoint(250, current_Y_value));
                        gfx.DrawString(r.UkupnoPotrosenogNovca.ToString(), font, XBrushes.Black, new XPoint(450, current_Y_value));
                        gfx.DrawLine(new XPen(XColor.FromArgb(50, 30, 200)), new XPoint(100, current_Y_value + 15), new XPoint(530, current_Y_value + 15));

                        current_Y_value += 35;
                        //current_Y_line += 20;
                    }

                    pdfDocument.Save(sfd.FileName);
                }
            }
        }

        private async Task<List<Model.Report>> GetReport()
        {
            var sezonaId = (cmbSezona.SelectedItem as Model.Sezona).SezonaId;
            var url = "Transfer/Report?sezonaId=" + sezonaId.ToString();
            _transferReportService = new APIService(url);
            return await _transferReportService.Get<List<Model.Report>>();
        }

    }
}
