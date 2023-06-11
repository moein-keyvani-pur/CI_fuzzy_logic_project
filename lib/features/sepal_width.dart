import '../utility.dart';

class SepalWidthFeatrue {
  final double _sWidth;
  SepalWidthFeatrue({
    required double sWidth,
  }) : _sWidth = sWidth;
  double get sWidth => _sWidth;

  double getDegreeMembershipBySepalWidthValue(
      SepalWidthValues sepalWidthValues) {
    switch (sepalWidthValues) {
      case SepalWidthValues.medium:
        return _mediumMembershipSepalWidth();
      case SepalWidthValues.height:
        return _heightMembershipSepalWidth();
      case SepalWidthValues.veryHeigh:
        return _veryHeightMembershipSepalWidth();
      case SepalWidthValues.large:
        return _largeMembershipSepalWidth();
      default:
        return _veryLargeMembershipSepalWidth();
    }
  }

  // double _smallMembershipSepalLength() {
  //   var mySLength = sLength;
  //   if (mySLength < 10) {
  //     return 1;
  //   } else if (10 <= mySLength && mySLength < 20) {
  //     return -0.1 * mySLength + 2;
  //   } else {
  //     return 0;
  //   }
  // }

  double _mediumMembershipSepalWidth() {
    var mysWidth = sWidth;
    if (15 <= mysWidth && mysWidth < 20) {
      return 0.2 * mysWidth - 3;
    }
    if (20 <= mysWidth && mysWidth < 40) {
      return 1;
    }
    if (40 <= mysWidth && mysWidth < 45) {
      return -0.2 * mysWidth + 7;
    } else {
      return 0;
    }
  }

  double _heightMembershipSepalWidth() {
    var mySWidth = sWidth;
    if (mySWidth < 10) {
      return 1;
    } else if (10 <= mySWidth && mySWidth < 20) {
      return -0.1 * mySWidth + 2;
    } else {
      return 0;
    }
  }

  double _veryHeightMembershipSepalWidth() {
    var mySWith = sWidth;
    if (mySWith < 10) {
      return 1;
    } else if (10 <= mySWith && mySWith < 20) {
      return -0.1 * mySWith + 2;
    } else {
      return 0;
    }
  }

  double _largeMembershipSepalWidth() {
    var mySWidth = sWidth;
    if (40 <= mySWidth && mySWidth < 45) {
      return 0.2 * mySWidth - 8;
    }
    if (45 <= mySWidth) {
      return 1;
    } else {
      return 0;
    }
  }

  double _veryLargeMembershipSepalWidth() {
    var mySWidth = sWidth;
    if (mySWidth < 10) {
      return 1;
    } else if (10 <= mySWidth && mySWidth < 20) {
      return -0.1 * mySWidth + 2;
    } else {
      return 0;
    }
  }
}
