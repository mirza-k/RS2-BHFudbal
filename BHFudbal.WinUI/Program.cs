using BHFudbal.WinUI.Fudbaler;
using BHFudbal.WinUI.Klub;
using BHFudbal.WinUI.Login;
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
            Application.Run(new frmFudbaler());
        }
    }
}
