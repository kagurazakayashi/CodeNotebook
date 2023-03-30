class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          // 自定义主题色
          primary: const Color(0xFF627998),
          secondary: const Color(0xFF63B8B8),
        ),
      ),
      home: const MyHomePage(), // title: 'Flutter Demo Home Page'
    );
  }
}
