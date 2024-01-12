class TangGiamFont {
  static final TangGiamFont _instance = TangGiamFont._internal();
  factory TangGiamFont() => _instance;
  TangGiamFont._internal();
  int coChu = 18;
  void updateFontSize(int newFontSize) {
    coChu = newFontSize.clamp(18, 28);
    print('Cỡ chữ đã được cập nhật: $coChu');
  }
}
