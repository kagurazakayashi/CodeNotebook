// Bitmap水平翻转
using System;
using System.Drawing;

class Program
{
    static void Main()
    {
        // 加载 Bitmap 图像
        Bitmap bitmap = new Bitmap("your-image-path.jpg");
        
        // 水平翻转图像
        bitmap.RotateFlip(RotateFlipType.RotateNoneFlipX);

        // 保存翻转后的图像
        bitmap.Save("flipped-image.jpg");

        Console.WriteLine("图像已水平翻转并保存。");

        // 将 Bitmap 转换为 Icon
        Icon icon = ConvertBitmapToIcon(bitmap);
    }
}
