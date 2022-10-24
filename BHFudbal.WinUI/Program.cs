using BHFudbal.WinUI.Korisnici;
using BHFudbal.WinUI.Match;
using BHFudbal.WinUI.Transfer;
using System;
using System.Windows.Forms;

namespace BHFudbal.WinUI
{
    static class Program
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new frmPrikazMatch());
        }
    }
}
