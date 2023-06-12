import '../utility.dart';

class PetalWidthFeatrue {
  final double _pWidth;
  PetalWidthFeatrue({
    required double pWidth,
  }) : _pWidth = pWidth;
  double get pWidth => _pWidth;

  double get maxValue => _maxValue;
  double get minValue => _minValue;
  set setMaxValue(double maxValueArg) => _maxValue = maxValueArg;
  set setMinValue(double minValueArg) => _minValue = minValueArg;
  double _maxValue = 2.5;
  double _minValue = 0.1;
  var _volum = 0.0;
  var _eachBoundary = 0.0;
  var _eachPart = 0.0;
  var _slope = 0.0;

  _init() {
    _volum = maxValue - minValue; // 2.4
    _eachBoundary = _volum / PetalWidthValues.values.length; // 0.48
    _eachPart = _eachBoundary / 2; //0.24 ---> 2 is custom
    _slope = double.parse((1 / _eachPart).toStringAsFixed(2));
  }

  double getDegreeMembershipByPetalWidthValue(
      PetalWidthValues petalWidthValues) {
    _init();
    switch (petalWidthValues) {
      case PetalWidthValues.veryLow:
        return _veryLowMembershipPetalWidth();
      case PetalWidthValues.low:
        return _lowMembershipPetalWidth();
      case PetalWidthValues.medium:
        return _mediumMembershipPetalWidth();
      case PetalWidthValues.hight:
        return _hightMembershipPetalWidth();
      case PetalWidthValues.veryHigh:
        return _veryhightMembershipPetalWidth();
      default:
        return 1.0;
    }
  }

  double _veryLowMembershipPetalWidth() {
    var lastPoint = minValue + _eachBoundary * 0;
    var peak = lastPoint + _eachPart;
    var myPWidth = pWidth;
    if (lastPoint <= myPWidth && myPWidth < peak) {
      return _slope * myPWidth - 0.42;
    }
    if (myPWidth == peak) {
      return 1;
    }
    if (lastPoint + peak < myPWidth && myPWidth <= lastPoint + _eachBoundary) {
      return -_slope * myPWidth + 2.42;
    } else {
      return 0.0;
    }
  }

  double _lowMembershipPetalWidth() {
    var lastPoint = minValue + _eachBoundary * 1;
    var peak = lastPoint + _eachPart;
    var myPWidth = pWidth;
    if (lastPoint <= myPWidth && myPWidth < peak) {
      return _slope * myPWidth - 2.42;
    }
    if (myPWidth == peak) {
      return 1;
    }
    if (lastPoint + peak < myPWidth && myPWidth <= lastPoint + _eachBoundary) {
      return -_slope * myPWidth + 4.42;
    } else {
      return 0.0;
    }
  }

  double _mediumMembershipPetalWidth() {
    var lastPoint = minValue + _eachBoundary * 2;
    var peak = lastPoint + _eachPart;
    var myPWidth = pWidth;
    if (lastPoint <= myPWidth && myPWidth < peak) {
      return _slope * myPWidth - 4.42;
    }
    if (myPWidth == peak) {
      return 1;
    }
    if (lastPoint + peak < myPWidth && myPWidth <= lastPoint + _eachBoundary) {
      return -_slope * myPWidth + 6.42;
    } else {
      return 0.0;
    }
  }

  double _hightMembershipPetalWidth() {
    var lastPoint = minValue + _eachBoundary * 3;
    var peak = lastPoint + _eachPart;
    var myPWidth = pWidth;
    if (lastPoint <= myPWidth && myPWidth < peak) {
      return _slope * myPWidth - 6.42;
    }
    if (myPWidth == peak) {
      return 1;
    }
    if (lastPoint + peak < myPWidth && myPWidth <= lastPoint + _eachBoundary) {
      return -_slope * myPWidth + 8.42;
    } else {
      return 0.0;
    }
  }

  double _veryhightMembershipPetalWidth() {
    var lastPoint = minValue + _eachBoundary * 4;
    var peak = lastPoint + _eachPart;
    var myPWidth = pWidth;
    if (lastPoint <= myPWidth && myPWidth < peak) {
      return _slope * myPWidth - 8.42;
    }
    if (myPWidth == peak) {
      return 1;
    }
    if (lastPoint + peak < myPWidth && myPWidth <= lastPoint + _eachBoundary) {
      return -_slope * myPWidth + 10.42;
    } else {
      return 0.0;
    }
  }
}
