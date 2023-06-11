import 'dart:math';

import 'package:hw_fuzzy_logic/extention.dart';
import 'package:hw_fuzzy_logic/features/xp.dart';
import 'package:hw_fuzzy_logic/michigan.dart';
import 'package:hw_fuzzy_logic/rule.dart';
import 'package:hw_fuzzy_logic/utility.dart';

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

  var mySamples = GeneralHelper.readDataFromFile();
  List<Rule> rules =
      List.generate(kRuleGenerate, (index) => _createRandomRule());

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
    _setResultRule(rule: rules[i], mySamples: mySamples);
  }
  Michigan michigan = Michigan(rules: rules, mySamples: mySamples);
  for (var element in michigan.getBestRoules(
      selectionSurvivorsMethod: SelectionSurvivors.rouletteWheel)) {
    print(element);
  }
}

void _setResultRule({required Rule rule, required List<XP> mySamples}) {
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
  rule.setSpecies = selectedClass;
  var sumWithoutSelected = 0.0;
  //! calculate CF for this roule
  sumCfClass
      .takeWhile((value) => value.keys.first != selectedClass)
      .toList()
      .forEach((element) {
    sumWithoutSelected += element.values.first;
  });
  var betaBar = sumWithoutSelected / (Species.values.length - 1);
  rule.setCf = (mux - betaBar) / sum;
}
