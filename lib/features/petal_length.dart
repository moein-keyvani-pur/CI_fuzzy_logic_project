import '../utility.dart';

class PetalLengthFeatrue {
  final double _pLength;
  PetalLengthFeatrue({
    required double pLength,
  }) : _pLength = pLength;
  double get pLength => _pLength;

  double getDegreeMembershipByPetalLengthValue(
      PetalLengthValues petalLengthValues) {
    switch (petalLengthValues) {
      case PetalLengthValues.medium:
        return _mediumMembershipPetalLength();
      case PetalLengthValues.height:
        return _heightMembershipPetalLength();
      case PetalLengthValues.veryHeigh:
        return _veryHeightMembershipPetalLength();
      case PetalLengthValues.large:
        return _largeMembershipPetalLength();
      default:
        return _veryLargeMembershipPetalLength();
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

  double _mediumMembershipPetalLength() {
    var myPLength = pLength;
    if (15 <= myPLength && myPLength < 20) {
      return 0.2 * myPLength - 3;
    }
    if (20 <= myPLength && myPLength < 40) {
      return 1;
    }
    if (40 <= myPLength && myPLength < 45) {
      return -0.2 * myPLength + 7;
    } else {
      return 0;
    }
  }

  double _heightMembershipPetalLength() {
    var myPLength = pLength;
    if (myPLength < 10) {
      return 1;
    } else if (10 <= myPLength && myPLength < 20) {
      return -0.1 * myPLength + 2;
    } else {
      return 0;
    }
  }

  double _veryHeightMembershipPetalLength() {
    var myPLength = pLength;
    if (myPLength < 10) {
      return 1;
    } else if (10 <= myPLength && myPLength < 20) {
      return -0.1 * myPLength + 2;
    } else {
      return 0;
    }
  }

  double _largeMembershipPetalLength() {
    var myPLength = pLength;
    if (40 <= myPLength && myPLength < 45) {
      return 0.2 * myPLength - 8;
    }
    if (45 <= myPLength) {
      return 1;
    } else {
      return 0;
    }
  }

  double _veryLargeMembershipPetalLength() {
    var myPLength = pLength;
    if (myPLength < 10) {
      return 1;
    } else if (10 <= myPLength && myPLength < 20) {
      return -0.1 * myPLength + 2;
    } else {
      return 0;
    }
  }
}
