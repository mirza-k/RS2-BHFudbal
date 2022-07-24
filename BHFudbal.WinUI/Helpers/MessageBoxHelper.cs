using System.Windows.Forms;

namespace BHFudbal.WinUI.Helpers
{
    public static class MessageBoxHelper
    {
        public static DialogResult ShowSuccessMessage(string text, string title)
        {
            return MessageBox.Show(text, title, MessageBoxButtons.OK, MessageBoxIcon.Information);
        }

        public static DialogResult ShowErrorMessage(string text, string title)
        {
            return MessageBox.Show(text, title, MessageBoxButtons.OK, MessageBoxIcon.Error);
        }
    }
}
