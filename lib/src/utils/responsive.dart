import 'package:flutter/cupertino.dart';
import 'dart:math' as math;

class Responsive {
  double _width; // saber el ancho
  double _heigth; // saber el alto
  double _diagonal; // saber a los costados
// metodos get y set
  double get width => this._width;
  set width(double width) => this._width = width;
  double get heigth => this._heigth;
  set heigth(double heigth) => this._heigth = heigth;
  get diagonal => this._diagonal;
  set diagonal(value) => this._diagonal = value;

  // constructor
  Responsive(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    this._width = size.width;
    this._heigth = size.height;
    this._diagonal = math.sqrt(math.pow(_width, 2) + math.pow(_heigth, 2));
  }
  // manejar distancias por porcentaje
  double altop(double porcent) => _width * porcent / 100;
  double anchop(double porcent) => _heigth * porcent / 100;
  double diagonalp(double porcent) => _diagonal * porcent / 100;

// variable de retorno
  static Responsive of(BuildContext context) => Responsive(context);
}
