import '../utility.dart';
import 'petal_length.dart';
import 'petal_width.dart';
import 'sepal_length.dart';
import 'sepal_width.dart';

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
