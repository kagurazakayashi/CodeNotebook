//button
leading: IconButton(
  icon: Icon(_backIcon()),
  alignment: Alignment.centerLeft,
  tooltip: 'Back',
  onPressed: () {
    Navigator.pop(context);
  },
),

//
IconData _backIcon() {
  switch (Theme.of(context).platform) {
    case TargetPlatform.android:
    case TargetPlatform.fuchsia:
      return Icons.arrow_back;
    case TargetPlatform.iOS:
      return Icons.arrow_back_ios;
  }
  assert(false);
  return null;
}
