namespace BHFudbal.Helpers
{
    public static class ImageValidator
    {
        public static bool IsJpeg(byte[] bytes)
        {
            return IsFileOfType(bytes, new byte[] { 0xFF, 0xD8, 0xFF });
        }

        public static bool IsPng(byte[] bytes)
        {
            return IsFileOfType(bytes, new byte[] { 0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A });
        }

        private static bool IsFileOfType(byte[] bytes, byte[] signature)
        {
            if (bytes.Length < signature.Length)
            {
                return false;
            }

            for (int i = 0; i < signature.Length; i++)
            {
                if (bytes[i] != signature[i])
                {
                    return false;
                }
            }

            return true;
        }
    }

}
