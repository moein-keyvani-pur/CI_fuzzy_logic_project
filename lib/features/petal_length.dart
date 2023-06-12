import '../utility.dart';

class PetalLengthFeatrue {
  final double _pLength;
  PetalLengthFeatrue({
    required double pLength,
  }) : _pLength = pLength;
  double get pLength => _pLength;

  double get maxValue => _maxValue;
  double get minValue => _minValue;
  set setMaxValue(double maxValueArg) => _maxValue = maxValueArg;
  set setMinValue(double minValueArg) => _minValue = minValueArg;
  double _maxValue = 6.9;
  double _minValue = 1.0;
  var _volum = 0.0;
  var _eachBoundary = 0.0;
  var _eachPart = 0.0;
  var _slope = 0.0;

  _init() {
    _volum = maxValue - minValue; // 5.9
    _eachBoundary = _volum / SepalLengthValues.values.length; // 1.18
    _eachPart = _eachBoundary / 2; //0.59 ---> 2 is custom
    _slope = double.parse((1 / _eachPart).toStringAsFixed(2));
  }

  double getDegreeMembershipByPetalLengthValue(
      PetalLengthValues petalLengthValues) {
    switch (petalLengthValues) {
      case PetalLengthValues.veryLow:
        return _veryLowMembershipPetalLength();
      case PetalLengthValues.low:
        return _lowMembershipPetalLength();
      case PetalLengthValues.medium:
        return _mediumMembershipPetalLength();
      case PetalLengthValues.hight:
        return _hightMembershipPetalLength();
      case PetalLengthValues.veryHigh:
        return _veryhightMembershipPetalLength();
      default:
        return 1.0;
    }
  }

  double _veryLowMembershipPetalLength() {
    var lastPoint = minValue + _eachBoundary * 0;
    var peak = lastPoint + _eachPart;
    var myPLength = pLength;
    if (lastPoint <= myPLength && myPLength < peak) {
      return _slope * myPLength - 1.7;
    }
    if (myPLength == peak) {
      return 1;
    }
    if (lastPoint + peak < myPLength &&
        myPLength <= lastPoint + _eachBoundary) {
      return -_slope * myPLength + 3.7;
    } else {
      return 0.0;
    }
  }

  double _lowMembershipPetalLength() {
    var lastPoint = minValue + _eachBoundary * 1;
    var peak = lastPoint + _eachPart;
    var myPLength = pLength;
    if (lastPoint <= myPLength && myPLength < peak) {
      return _slope * myPLength - 3.7;
    }
    if (myPLength == peak) {
      return 1;
    }
    if (lastPoint + peak < myPLength &&
        myPLength <= lastPoint + _eachBoundary) {
      return -_slope * myPLength + 5.7;
    } else {
      return 0.0;
    }
  }

  double _mediumMembershipPetalLength() {
    var lastPoint = minValue + _eachBoundary * 2;
    var peak = lastPoint + _eachPart;
    var myPLength = pLength;
    if (lastPoint <= myPLength && myPLength < peak) {
      return _slope * myPLength - 5.7;
    }
    if (myPLength == peak) {
      return 1;
    }
    if (lastPoint + peak < myPLength &&
        myPLength <= lastPoint + _eachBoundary) {
      return -_slope * myPLength + 7.7;
    } else {
      return 0.0;
    }
  }

  double _hightMembershipPetalLength() {
    var lastPoint = minValue + _eachBoundary * 3;
    var peak = lastPoint + _eachPart;
    var myPLength = pLength;
    if (lastPoint <= myPLength && myPLength < peak) {
      return _slope * myPLength - 7.7;
    }
    if (myPLength == peak) {
      return 1;
    }
    if (lastPoint + peak < myPLength &&
        myPLength <= lastPoint + _eachBoundary) {
      return -_slope * myPLength + 9.7;
    } else {
      return 0.0;
    }
  }

  double _veryhightMembershipPetalLength() {
    var lastPoint = minValue + _eachBoundary * 4;
    var peak = lastPoint + _eachPart;
    var myPLength = pLength;
    if (lastPoint <= myPLength && myPLength < peak) {
      return _slope * myPLength - 9.7;
    }
    if (myPLength == peak) {
      return 1;
    }
    if (lastPoint + peak < myPLength &&
        myPLength <= lastPoint + _eachBoundary) {
      return -_slope * myPLength + 11.7;
    } else {
      return 0.0;
    }
  }
}
