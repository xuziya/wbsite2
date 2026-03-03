using System;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using Gma.QrCodeNet.Encoding;
using Gma.QrCodeNet.Encoding.Windows.Render;

namespace harry.Tools
{
    /// <summary>二维码类</summary>
    public class QRCode
    {
        /// <summary>生成二维码并保存</summary>
        /// <param name="str"></param>
        /// <param name="savePath"></param>
        /// <returns></returns>
        public static bool Create(string str, string savePath)
        {
            bool result = false;
            try
            {
                QrEncoder qrEncoder = new QrEncoder(ErrorCorrectionLevel.M);
                QrCode qrCode = qrEncoder.Encode(str);
                //保存文件
                GraphicsRenderer render = new GraphicsRenderer(new FixedModuleSize(8, QuietZoneModules.Two), Brushes.Black, Brushes.White);
                using (FileStream stream = new FileStream(savePath, FileMode.Create))
                {
                    render.WriteToStream(qrCode.Matrix, ImageFormat.Png, stream);
                }
                result = true;
            }
            catch (Exception ex) { throw ex; }
            return result;
        }

        /// <summary>生成二维码并保存</summary>
        /// <param name="str"></param>
        /// <param name="savePath"></param>
        /// <returns></returns>
        public static Image Create(string str, int width, int height)
        {
            Bitmap bitmap = new Bitmap(width, height);
            Graphics grab = Graphics.FromImage(bitmap);
            try
            {
                QrEncoder qrEncoder = new QrEncoder(ErrorCorrectionLevel.M);
                QrCode qrCode = qrEncoder.Encode(str);
                //保存文件
                GraphicsRenderer render = new GraphicsRenderer(new FixedModuleSize(8, QuietZoneModules.Two), Brushes.Black, Brushes.White);
                render.Draw(grab, qrCode.Matrix);
            }
            catch (Exception ex) { throw ex; }
            return bitmap;
        }
    }
}