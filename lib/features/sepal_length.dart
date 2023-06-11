import '../utility.dart';

class SepalLengthFeature {
  final double _sLength;
  SepalLengthFeature({
    required double sLength,
  }) : _sLength = sLength;
  double get sLength => _sLength;

  double getDegreeMembershipBySepalLengthValue(
      SepalLengthValues sepalLengthValues) {
    switch (sepalLengthValues) {
      case SepalLengthValues.medium:
        return _mediumMembershipSepalLength();
      case SepalLengthValues.height:
        return _heightMembershipSepalLength();
      case SepalLengthValues.veryHeigh:
        return _veryHeightMembershipSepalLength();
      case SepalLengthValues.large:
        return _largeMembershipSepalLength();
      default:
        return _veryLargeMembershipSepalLength();
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

  double _mediumMembershipSepalLength() {
    var mySLength = sLength;
    if (15 <= mySLength && mySLength < 20) {
      return 0.2 * mySLength - 3;
    }
    if (20 <= mySLength && mySLength < 40) {
      return 1;
    }
    if (40 <= mySLength && mySLength < 45) {
      return -0.2 * mySLength + 7;
    } else {
      return 0;
    }
  }

  double _heightMembershipSepalLength() {
    var mySLength = sLength;
    if (mySLength < 10) {
      return 1;
    } else if (10 <= mySLength && mySLength < 20) {
      return -0.1 * mySLength + 2;
    } else {
      return 0;
    }
  }

  double _veryHeightMembershipSepalLength() {
    var mySLength = sLength;
    if (mySLength < 10) {
      return 1;
    } else if (10 <= mySLength && mySLength < 20) {
      return -0.1 * mySLength + 2;
    } else {
      return 0;
    }
  }

  double _largeMembershipSepalLength() {
    var mySLength = sLength;
    if (40 <= mySLength && mySLength < 45) {
      return 0.2 * mySLength - 8;
    }
    if (45 <= mySLength) {
      return 1;
    } else {
      return 0;
    }
  }

  double _veryLargeMembershipSepalLength() {
    var mySLength = sLength;
    if (mySLength < 10) {
      return 1;
    } else if (10 <= mySLength && mySLength < 20) {
      return -0.1 * mySLength + 2;
    } else {
      return 0;
    }
  }
}
