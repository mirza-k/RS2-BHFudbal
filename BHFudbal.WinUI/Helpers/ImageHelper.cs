using System.Drawing;
using System.IO;

namespace BHFudbal.WinUI.Helpers
{
    public static class ImageHelper
    {
        public static Image FromByteToImage(byte[] image)
        {
            return Image.FromStream(new MemoryStream(image));
        }

        public static byte[] FromImageToByte(Image image)
        {
            ImageConverter converter = new ImageConverter();
            return (byte[])converter.ConvertTo(image, typeof(byte[]));
        }

    }
}
