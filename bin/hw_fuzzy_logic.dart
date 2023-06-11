import 'dart:io';
import 'dart:math';

void main(List<String> arguments) {
  int _getRandomNumber(int floor) {
    return Random().nextInt(floor);
  }

  Rule _createRandomRule() {
    return Rule(
      petalLength: PetalLengthValues
          .values[_getRandomNumber(PetalLengthValues.values.length)],
      petalWidth: PetalWidthValues
          .values[_getRandomNumber(PetalWidthValues.values.length)],
      sepalLength: SepalLengthValues
          .values[_getRandomNumber(SepalLengthValues.values.length)],
      sepalWidth: SepalWidthValues
          .values[_getRandomNumber(SepalWidthValues.values.length)],
    );
  }

  var mySamples = readDataFromFile();
  List<Rule> rules = List.generate(30, (index) => _createRandomRule());

  for (var i = 0; i < rules.length; i++) {
    print('\nrule ${i + 1} ------------->>>>> ${rules[i]}\n');
    for (var j = 0; j < mySamples.length; j++) {
      mySamples[j].setCertaintyFactors(
          ruleSepalLengthValue: rules[i].sepalLengthValues,
          ruleSepalWidthValue: rules[i].sepalWidthValues,
          rulePetalLengthValue: rules[i].petalLengthValues,
          rulePetalWidthValue: rules[i].petalWidthValues);
      print('${j + 1}- ${mySamples[j]}');
    }
    List<Map<Species, double>> sumCfClass = List.generate(
        Species.values.length, (index) => {Species.values[index]: 0.0});
    for (var element in mySamples) {
      switch (element.species) {
        case Species.setosa:
          sumCfClass[0][Species.setosa] =
              sumCfClass[0][Species.setosa]! + (element.cf ?? 0.0);
          break;
        case Species.versicolor:
          sumCfClass[1][Species.versicolor] =
              sumCfClass[1][Species.versicolor]! + (element.cf ?? 0.0);
          break;
        default:
          sumCfClass[2][Species.virginica] =
              sumCfClass[2][Species.virginica]! + (element.cf ?? 0.0);
      }
    }
    var mux = sumCfClass[0].values.first;
    var sum = 0.0;
    Species selectedClass = sumCfClass[0].keys.first;
    for (var i = 0; i < sumCfClass.length; i++) {
      if (sumCfClass[i][Species.values[i]]! > mux) {
        mux = sumCfClass[i][Species.values[i]]!;
        selectedClass = sumCfClass[i].keys.first;
      }
      sum += sumCfClass[i][Species.values[i]]!;
    }
    print('$mux    $selectedClass');
    rules[i].setSpecies = selectedClass;
    var sumWithoutSelected = 0.0;
    //! calculate CF for this roule
    sumCfClass
        .takeWhile((value) => value.keys.first != selectedClass)
        .toList()
        .forEach((element) {
      sumWithoutSelected += element.values.first;
    });
    var betaBar = sumWithoutSelected / (Species.values.length - 1);
    rules[i].setCf = (mux - betaBar) / sum;
  }
}

void setCFRule() {}

List<XP> readDataFromFile() {
  File file = File("Iris.csv");

  String users = file.readAsStringSync();

  var data = csvToUsersList(users);

  return data;
}

List<XP> csvToUsersList(String data) {
  List<XP> users = [];

  List<String> _users = data.split("\n");

  for (int i = 1; i < _users.length - 1; i++) {
    List<String> user = _users[i].split(",");

    users.add(XP(
        sepalLengthFeature:
            SepalLengthFeature(sLength: double.parse(user[1].trim())),
        sepalWidthFeatrue:
            SepalWidthFeatrue(sWidth: double.parse(user[2].trim())),
        petalLengthFeatrue:
            PetalLengthFeatrue(pLength: double.parse(user[3].trim())),
        petalWidthFeatrue:
            PetalWidthFeatrue(pWidth: double.parse(user[4].trim())),
        species: Species.values
            .where((element) =>
                element.name.trim().toLowerCase() ==
                user[5].split('-')[1].trim().toLowerCase())
            .first));
  }

  return users;
}

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
      case PetalWidthValues.large:
        return _largeMembershipPetalWidth();
      default:
        return _veryLargeMembershipPetalWidth();
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

  double _largeMembershipPetalWidth() {
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

  double _veryLargeMembershipPetalWidth() {
    var myPWidth = pWidth;
    if (myPWidth < 10) {
      return 1;
    } else if (10 <= myPWidth && myPWidth < 20) {
      return -0.1 * myPWidth + 2;
    } else {
      return 0;
    }
  }
}

class XP {
  final SepalLengthFeature _sepalLengthFeature;
  final SepalWidthFeatrue _sepalWidthFeatrue;
  final PetalLengthFeatrue _petalLengthFeatrue;
  final PetalWidthFeatrue _petalWidthFeatrue;
  double? _cf;
  Species? _species;
  XP(
      {required SepalLengthFeature sepalLengthFeature,
      required SepalWidthFeatrue sepalWidthFeatrue,
      required PetalLengthFeatrue petalLengthFeatrue,
      required PetalWidthFeatrue petalWidthFeatrue,
      Species? species})
      : _sepalLengthFeature = sepalLengthFeature,
        _sepalWidthFeatrue = sepalWidthFeatrue,
        _petalLengthFeatrue = petalLengthFeatrue,
        _species = species,
        _petalWidthFeatrue = petalWidthFeatrue;

  SepalLengthFeature get sepalLengthFeature => _sepalLengthFeature;
  SepalWidthFeatrue get sepalWidthFeatrue => _sepalWidthFeatrue;
  PetalLengthFeatrue get petalLengthFeatrue => _petalLengthFeatrue;
  PetalWidthFeatrue get petalWidthFeatrue => _petalWidthFeatrue;
  Species? get species => _species;
  double? get cf => _cf;

  set setCf(cfArg) => _cf = cfArg;
  set setSpecies(Species speciesArge) {
    _species = speciesArge;
  }

  void setCertaintyFactors(
      {required SepalLengthValues ruleSepalLengthValue,
      required SepalWidthValues ruleSepalWidthValue,
      required PetalLengthValues rulePetalLengthValue,
      required PetalWidthValues rulePetalWidthValue}) {
    var data = petalLengthFeatrue
            .getDegreeMembershipByPetalLengthValue(rulePetalLengthValue) *
        petalWidthFeatrue
            .getDegreeMembershipByPetalWidthValue(rulePetalWidthValue) *
        sepalLengthFeature
            .getDegreeMembershipBySepalLengthValue(ruleSepalLengthValue) *
        sepalWidthFeatrue
            .getDegreeMembershipBySepalWidthValue(ruleSepalWidthValue);
    setCf = data;
  }

  @override
  String toString() {
    return ' sepalLengthFeature = ${sepalLengthFeature.sLength} sepalWidthFeatrue = ${sepalWidthFeatrue.sWidth} petalLengthFeatrue = ${petalLengthFeatrue.pLength}  petalWidthFeatrue= = ${petalWidthFeatrue.pWidth}  ------------>class = ${species?.name} with  cf = $cf';
  }
}

//! if sepalLength=height and sepalWidth=medium and petalLength=large and petalWidth=medium then species = setosa with cf=0.8
class Rule {
  final SepalLengthValues _sepalLength;
  final SepalWidthValues _sepalWidth;
  final PetalLengthValues _petalLength;
  final PetalWidthValues _petalWidth;
  Species? _species;
  double? _cf;
  Rule({
    required SepalLengthValues sepalLength,
    required SepalWidthValues sepalWidth,
    required PetalLengthValues petalLength,
    required PetalWidthValues petalWidth,
  })  : _sepalLength = sepalLength,
        _sepalWidth = sepalWidth,
        _petalLength = petalLength,
        _petalWidth = petalWidth;

  SepalLengthValues get sepalLengthValues => _sepalLength;
  SepalWidthValues get sepalWidthValues => _sepalWidth;
  PetalLengthValues get petalLengthValues => _petalLength;
  PetalWidthValues get petalWidthValues => _petalWidth;

  set setCf(double cfArg) => _cf = cfArg;
  set setSpecies(Species speciesArg) => _species = speciesArg;

  @override
  String toString() {
    return 'if sepalLength = ${_sepalLength.name} and sepalWidth = ${_sepalWidth.name} and petalLength = ${_petalLength.name} and petalWidth = ${_petalWidth.name} ---> Species = ${_species?.name} with cf = $_cf ';
  }
}

enum SepalLengthValues { medium, height, veryHeigh, large, veryLarge, dontCare }

enum SepalWidthValues { medium, height, veryHeigh, large, veryLarge, dontCare }

enum PetalLengthValues { medium, height, veryHeigh, large, veryLarge, dontCare }

enum PetalWidthValues { medium, height, veryHeigh, large, veryLarge, dontCare }

enum AllValues { medium, height, veryHeigh, large, veryLarge, dontCare }

enum Species { setosa, versicolor, virginica }

class FunctionCreator {
  void lenearFunction(double deltaY, double deltaX) {
    var y = (deltaY / deltaX);
  }
}

class Michigan {
  final List<Rule> _rules;
  Michigan({
    required List<Rule> rules,
  }) : _rules = rules {
    _mapCodeToSymbol();
  }
  List<Rule> get rules => _rules;
  // each individual represent features of each rule
  late List<List<String>> _allIndividual;
  void _mapCodeToSymbol() {
    for (var element in rules) {
      List<String> item = [];
      item
        ..add(element.sepalLengthValues.name)
        ..add(element.sepalWidthValues.name)
        ..add(element.petalLengthValues.name)
        ..add(element.petalWidthValues.name);
      _allIndividual.add(item);
    }
  }

  fitnessFunction() {}
}
