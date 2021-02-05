extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

double getSizeFromWidth(width) {
  const double _sizeBasis = 24.0;
  const double _sizeStep = 8.0;
  if (width > 1200) return _sizeStep * 3 + _sizeBasis;
  if (width > 900) return _sizeStep * 2 + _sizeBasis;
  if (width > 600) return _sizeStep + _sizeBasis;
  return _sizeBasis;
}

String getStringDate(DateTime date) => '${date.day}.${date.month}.${date.year}';

class UiServiceSizing {
  // App constants
  static const double navbar = 80.0;
  static const double drawer = 200.0;
  // Size to change scale
  static const double size_xl = 1200.0;
  static const double size_l = 1000.0;
  static const double size_m = 900.0;
  static const double size_s = 600.0;
  // Default text basis size for scale
  static const double _text_xl = 18.0;
  static const double _text_l = 16.0;
  static const double _text_m = 14.0;
  static const double _text_s = 12.0;
  static const double _text_vs = 10.0;

  static double scale(double width) {
    if (width > size_xl) return 2.6;
    if (width > size_l) return 2.2;
    if (width > size_m) return 1.8;
    if (width > size_s) return 1.4;
    return 1.0;
  }

  UiTextSizing text(double width) => UiTextSizing(this._textFromWidth(width));

  double _textFromWidth(double width) {
    double _scale = scale(width);
    if (_scale == 5) return _text_xl;
    if (_scale == 4) return _text_l;
    if (_scale == 3) return _text_m;
    if (_scale == 2) return _text_s;
    return _text_vs;
  }
}

class UiTextSizing {
  double _xl;
  double _l;
  double _m;
  double _s;
  double _vs;
  double get xl => this._xl;
  double get l => this._l;
  double get m => this._m;
  double get s => this._s;
  double get vs => this._vs;

  UiTextSizing(double basis) {
    this._setSizes(basis);
  }

  void _setSizes(double basis) {
    double _step = (basis / 3).roundToDouble();
    this._xl = this._round(_step * 5);
    this._l = this._round(_step * 4);
    this._m = this._round(_step * 3);
    this._s = this._round(_step * 2);
    this._vs = this._round(_step * 1);
  }

  double _round(double number) => number.roundToDouble();
}
