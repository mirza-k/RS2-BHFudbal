using BHFudbal.Model.Requests;
using BHFudbal.WinUI.MDIHome;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace BHFudbal.WinUI.Login
{
    public partial class frmLogin : Form
    {

        private APIService _apiService;
        public frmLogin()
        {
            InitializeComponent();
        }

        private async void btnLogin_Click(object sender, EventArgs e)
        {
            var username = txt_Username.Text;
            var password = txt_Password.Text;

            APIService.Username = username;
            APIService.Password = password;

            try
            {
                var request = new KorisnikInsertRequest()
                {
                    Username = username,
                    Password = password
                };

                _apiService = new APIService("korisnik/login");
                var result = await _apiService.Login(request);

                if (result)
                {
                    this.Hide();
                    MDIHomeFrm frm = new MDIHomeFrm();
                    frm.ShowDialog();
                    this.Close();
                }
                else
                {
                    MessageBox.Show("Wrong username or password");
                }
            }
            catch
            {
                MessageBox.Show("Desio se error..");
            }
        }
    }
}
