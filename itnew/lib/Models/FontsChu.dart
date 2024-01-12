class FontsChu {
  static final FontsChu _fontsChu = FontsChu._internal();
  factory FontsChu() => _fontsChu;
  FontsChu._internal();
  String fontInter = 'Inter';
  void updateFontsChu(String newFont) {
    fontInter = newFont;
    print('font chữ được cập nhật $fontInter');
  }
}
