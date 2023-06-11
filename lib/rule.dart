import 'utility.dart';

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
  Species? get species => _species;
  set setCf(double cfArg) => _cf = cfArg;
  set setSpecies(Species speciesArg) => _species = speciesArg;

  @override
  String toString() {
    return 'if sepalLength = ${_sepalLength.name} and sepalWidth = ${_sepalWidth.name} and petalLength = ${_petalLength.name} and petalWidth = ${_petalWidth.name} ---> Species = ${_species?.name} with cf = $_cf ';
  }
}
