import '../utility.dart';

class SepalLengthFeature {
  final double _sLength;
  SepalLengthFeature({
    required double sLength,
  }) : _sLength = sLength;
  double get sLength => _sLength;
  double get maxValue => _maxValue;
  double get minValue => _minValue;
  set setMaxValue(double maxValueArg) => _maxValue = maxValueArg;
  set setMinValue(double minValueArg) => _minValue = minValueArg;
  double _maxValue = 7.9;
  double _minValue = 4.3;
  var _volum = 0.0;
  var _eachBoundary = 0.0;
  var _eachPart = 0.0;
  var _slope = 0.0;

  _init() {
    _volum = maxValue - minValue; // 3.6
    _eachBoundary = _volum / SepalLengthValues.values.length; // 0.72
    _eachPart = _eachBoundary / 2; //0.36 ---> 2 is custom
    _slope = double.parse((1 / _eachPart).toStringAsFixed(2));
  }

  double getDegreeMembershipBySepalLengthValue(
      SepalLengthValues sepalLengthValues) {
    _init();
    switch (sepalLengthValues) {
      case SepalLengthValues.veryLow:
        return _veryLowMembershipSepalLength();
      case SepalLengthValues.low:
        return _lowMembershipSepalLength();
      case SepalLengthValues.medium:
        return _mediumMembershipSepalLength();
      case SepalLengthValues.hight:
        return _hightMembershipSepalLength();
      case SepalLengthValues.veryHigh:
        return _veryhightMembershipSepalLength();
      default:
        return 1.0;
    }
  }

  double _veryLowMembershipSepalLength() {
    var lastPoint = minValue + _eachBoundary * 0;
    var peak = lastPoint + _eachPart;
    var mySLength = sLength;
    if (lastPoint <= mySLength && mySLength < peak) {
      return _slope * mySLength - 12;
    }
    if (mySLength == peak) {
      return 1;
    }
    if (lastPoint + peak < sLength && sLength <= lastPoint + _eachBoundary) {
      return -_slope * mySLength + 14;
    } else {
      return 0.0;
    }
  }

  double _lowMembershipSepalLength() {
    var lastPoint = minValue + _eachBoundary * 1;
    var peak = lastPoint + _eachPart;
    var mySLength = sLength;
    if (lastPoint <= mySLength && mySLength < peak) {
      return _slope * mySLength - 14;
    }
    if (mySLength == peak) {
      return 1;
    }
    if (lastPoint + peak < sLength && sLength <= lastPoint + _eachBoundary) {
      return -_slope * mySLength + 16;
    } else {
      return 0.0;
    }
  }

  double _mediumMembershipSepalLength() {
    var lastPoint = minValue + _eachBoundary * 2;
    var peak = lastPoint + _eachPart;
    var mySLength = sLength;
    if (lastPoint <= mySLength && mySLength < peak) {
      return _slope * mySLength - 16;
    }
    if (mySLength == peak) {
      return 1;
    }
    if (lastPoint + peak < sLength && sLength <= lastPoint + _eachBoundary) {
      return -_slope * mySLength + 18;
    } else {
      return 0.0;
    }
  }

  double _hightMembershipSepalLength() {
    var lastPoint = minValue + _eachBoundary * 3;
    var peak = lastPoint + _eachPart;
    var mySLength = sLength;
    if (lastPoint <= mySLength && mySLength < peak) {
      return _slope * mySLength - 18;
    }
    if (mySLength == peak) {
      return 1;
    }
    if (lastPoint + peak < sLength && sLength <= lastPoint + _eachBoundary) {
      return -_slope * mySLength + 20;
    } else {
      return 0.0;
    }
  }

  double _veryhightMembershipSepalLength() {
    var lastPoint = minValue + _eachBoundary * 4;
    var peak = lastPoint + _eachPart;
    var mySLength = sLength;
    if (lastPoint <= mySLength && mySLength < peak) {
      return _slope * mySLength - 20;
    }
    if (mySLength == peak) {
      return 1;
    }
    if (lastPoint + peak < sLength && sLength <= lastPoint + _eachBoundary) {
      return -_slope * mySLength + 22;
    } else {
      return 0.0;
    }
  }
}
