import '../utility.dart';

class SepalWidthFeatrue {
  final double _sWidth;
  SepalWidthFeatrue({
    required double sWidth,
  }) : _sWidth = sWidth;
  double get sWidth => _sWidth;

  double get maxValue => _maxValue;
  double get minValue => _minValue;
  set setMaxValue(double maxValueArg) => _maxValue = maxValueArg;
  set setMinValue(double minValueArg) => _minValue = minValueArg;
  double _maxValue = 4.4;
  double _minValue = 2.0;
  var _volum = 0.0;
  var _eachBoundary = 0.0;
  var _eachPart = 0.0;
  var _slope = 0.0;

  _init() {
    _volum = maxValue - minValue; // 2.4
    _eachBoundary = _volum / SepalWidthValues.values.length; // 0.48
    _eachPart = _eachBoundary / 2; //0.24 ---> 2 is custom
    _slope = double.parse((1 / _eachPart).toStringAsFixed(2));
  }

  double getDegreeMembershipBySepalWidthValue(
      SepalWidthValues sepalWidthValues) {
    _init();
    switch (sepalWidthValues) {
      case SepalWidthValues.veryLow:
        return _veryLowMembershipSepalWidth();
      case SepalWidthValues.low:
        return _lowMembershipSepalWidth();
      case SepalWidthValues.medium:
        return _mediumMembershipSepalLength();
      case SepalWidthValues.hight:
        return _hightMembershipSepalWidth();
      case SepalWidthValues.veryHigh:
        return _veryhightMembershipSepalWidth();
      default:
        return 1.0;
    }
  }

  double _veryLowMembershipSepalWidth() {
    var lastPoint = minValue + _eachBoundary * 0;
    var peak = lastPoint + _eachPart;
    var mySWidth = sWidth;
    if (lastPoint <= mySWidth && mySWidth < peak) {
      return _slope * mySWidth - 8.33;
    }
    if (mySWidth == peak) {
      return 1;
    }
    if (lastPoint + peak < sWidth && sWidth <= lastPoint + _eachBoundary) {
      return -_slope * mySWidth + 10.33;
    } else {
      return 0.0;
    }
  }

  double _lowMembershipSepalWidth() {
    var lastPoint = minValue + _eachBoundary * 1;
    var peak = lastPoint + _eachPart;
    var mySWidth = sWidth;
    if (lastPoint <= mySWidth && mySWidth < peak) {
      return _slope * mySWidth - 10.33;
    }
    if (mySWidth == peak) {
      return 1;
    }
    if (lastPoint + peak < sWidth && sWidth <= lastPoint + _eachBoundary) {
      return -_slope * mySWidth + 12.33;
    } else {
      return 0.0;
    }
  }

  double _mediumMembershipSepalLength() {
    var lastPoint = minValue + _eachBoundary * 2;
    var peak = lastPoint + _eachPart;
    var mySWidth = sWidth;
    if (lastPoint <= mySWidth && mySWidth < peak) {
      return _slope * mySWidth - 12.33;
    }
    if (mySWidth == peak) {
      return 1;
    }
    if (lastPoint + peak < sWidth && sWidth <= lastPoint + _eachBoundary) {
      return -_slope * mySWidth + 14.33;
    } else {
      return 0.0;
    }
  }

  double _hightMembershipSepalWidth() {
    var lastPoint = minValue + _eachBoundary * 3;
    var peak = lastPoint + _eachPart;
    var mySWidth = sWidth;
    if (lastPoint <= mySWidth && mySWidth < peak) {
      return _slope * mySWidth - 14.33;
    }
    if (mySWidth == peak) {
      return 1;
    }
    if (lastPoint + peak < sWidth && sWidth <= lastPoint + _eachBoundary) {
      return -_slope * mySWidth + 16.33;
    } else {
      return 0.0;
    }
  }

  double _veryhightMembershipSepalWidth() {
    var lastPoint = minValue + _eachBoundary * 4;
    var peak = lastPoint + _eachPart;
    var mySWidth = sWidth;
    if (lastPoint <= mySWidth && mySWidth < peak) {
      return _slope * mySWidth - 16.33;
    }
    if (mySWidth == peak) {
      return 1;
    }
    if (lastPoint + peak < sWidth && sWidth <= lastPoint + _eachBoundary) {
      return -_slope * mySWidth + 18.33;
    } else {
      return 0.0;
    }
  }
}
