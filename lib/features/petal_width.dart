import '../utility.dart';

class PetalWidthFeatrue {
  final double _pWidth;
  PetalWidthFeatrue({
    required double pWidth,
  }) : _pWidth = pWidth;
  double get pWidth => _pWidth;

  double getDegreeMembershipByPetalWidthValue(
      PetalWidthValues petalWidthValues) {
    switch (petalWidthValues) {
      case PetalWidthValues.medium:
        return _mediumMembershipPetalWidth();
      case PetalWidthValues.height:
        return _heightMembershipPetalWidth();
      case PetalWidthValues.veryHeigh:
        return _veryHeightMembershipPetalWidth();
      case PetalWidthValues.low:
        return _lowMembershipPetalWidth();
      default:
        return _veryLowMembershipPetalWidth();
    }
  }

  double _veryLowMembershipPetalWidth() {
    var myPWidth = pWidth;
    if (myPWidth < 10) {
      return 1;
    } else if (10 <= myPWidth && myPWidth < 20) {
      return -0.1 * myPWidth + 2;
    } else {
      return 0;
    }
  }

  double _lowMembershipPetalWidth() {
    var myPWidth = pWidth;
    if (40 <= myPWidth && myPWidth < 45) {
      return 0.2 * myPWidth - 8;
    }
    if (45 <= myPWidth) {
      return 1;
    } else {
      return 0;
    }
  }

  double _mediumMembershipPetalWidth() {
    var myPWidth = pWidth;
    if (15 <= myPWidth && myPWidth < 20) {
      return 0.2 * myPWidth - 3;
    }
    if (20 <= myPWidth && myPWidth < 40) {
      return 1;
    }
    if (40 <= myPWidth && myPWidth < 45) {
      return -0.2 * myPWidth + 7;
    } else {
      return 0;
    }
  }

  double _heightMembershipPetalWidth() {
    var myPWidth = pWidth;
    if (myPWidth < 10) {
      return 1;
    } else if (10 <= myPWidth && myPWidth < 20) {
      return -0.1 * myPWidth + 2;
    } else {
      return 0;
    }
  }

  double _veryHeightMembershipPetalWidth() {
    var myPWith = pWidth;
    if (myPWith < 10) {
      return 1;
    } else if (10 <= myPWith && myPWith < 20) {
      return -0.1 * myPWith + 2;
    } else {
      return 0;
    }
  }
}
