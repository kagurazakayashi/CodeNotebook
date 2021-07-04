ipcMain.on("copy",(event, arg) => {
    const imagePath = path.join(appPath, `page/images/copyImg${arg.name}`);
    this.download(arg.url, imagePath, () => {
        const image = nativeImage.createFromPath(imagePath);
        const { width, height } = image.getSize();
        clipboard.writeImage(image, 'image');
    });
});