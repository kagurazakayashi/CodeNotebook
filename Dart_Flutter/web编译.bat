#采用canvaskit编译体积大，运行效率高
flutter build web --web-renderer canvaskit --release

#体积小，运行效率低
flutter build web --web-renderer html --release