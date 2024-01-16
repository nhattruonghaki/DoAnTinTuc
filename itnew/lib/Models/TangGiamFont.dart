class TangGiamFont {
  static final TangGiamFont _instance = TangGiamFont._internal();
  factory TangGiamFont() => _instance;
  TangGiamFont._internal();
  int coChu = 14;
  void updateFontSize(int newFontSize) {
    coChu = newFontSize.clamp(14, 28);
    print('Cỡ chữ đã được cập nhật: $coChu');
  }
}
