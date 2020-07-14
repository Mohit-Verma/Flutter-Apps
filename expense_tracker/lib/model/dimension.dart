import 'package:flutter/material.dart';

class Dimension {
  final BuildContext context;
  final EdgeInsets statusBarDimension;
  final Size appBarDimension;

  double _availableHeight;
  double _availableWidth;
  bool _isLandscape;
  bool _isPortrait;
  Orientation _oreintation;

  Dimension({
    @required this.context,
    @required this.appBarDimension,
    @required this.statusBarDimension,
  }) {
    _availableHeight = MediaQuery.of(context).size.height -
        (statusBarDimension.top + appBarDimension.height);
    _availableWidth = MediaQuery.of(context).size.width;
    _oreintation = MediaQuery.of(context).orientation;
    _isLandscape = _oreintation == Orientation.landscape;
    _isPortrait = !_isLandscape;
  }

  double getAvailableHeight() => _availableHeight;
  double getAvailableWidth() => _availableWidth;
  bool isPortraitMode() => _isPortrait;
  bool isLandscapeMode() => _isLandscape;
  Orientation gtOrientation() => _oreintation;
}
