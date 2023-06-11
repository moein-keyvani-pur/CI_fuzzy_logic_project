import 'dart:math';

import 'package:hw_fuzzy_logic/utility.dart';
import 'package:roulette_wheel_and_sus/roulette_wheel_and_sus.dart';

import 'features/xp.dart';
import 'rule.dart';

class Michigan {
  final List<Rule> _rules;
  final List<XP> _mySamples;
  Michigan({required List<Rule> rules, required List<XP> mySamples})
      : _rules = rules,
        _mySamples = mySamples;
  Map<int, dynamic> _individualsWithAdditionalItem = {};
  Map<int, dynamic> get individualsWithAdditionalItem =>
      _individualsWithAdditionalItem;
  set setIndividualsWithAdditionalItem(Map<int, dynamic> arg) =>
      _individualsWithAdditionalItem = arg;
  List<Rule> get rules => _rules;
  List<XP> get mySamples => _mySamples;

  List<int> _ruleToList(Rule rule) {
    List<int> item = [];
    return item
      ..add(rule.sepalLengthValues.index)
      ..add(rule.sepalWidthValues.index)
      ..add(rule.petalLengthValues.index)
      ..add(rule.petalWidthValues.index);
  }

  Rule _listToRule(List<int> item) {
    return Rule(
        sepalLength: SepalLengthValues.values[item[0]],
        sepalWidth: SepalWidthValues.values[item[1]],
        petalLength: PetalLengthValues.values[2],
        petalWidth: PetalWidthValues.values[3]);
  }

  _fitnessFunction() {
    setIndividualsWithAdditionalItem = {};
    for (var individual in rules) {
      double value = 0;
      for (var xp in mySamples) {
        if (xp.species!.name == individual.species!.name) {
          value++;
        }
      }
      individualsWithAdditionalItem.putIfAbsent(
          individual.hashCode, () => value);
    }
  }

  List<Rule> getBestRoules(
      {required SelectionSurvivors selectionSurvivorsMethod}) {
    _fitnessFunction();
    switch (selectionSurvivorsMethod) {
      case SelectionSurvivors.rouletteWheel:
        return _selectionSurvivorsByRouletteWheel();
      case SelectionSurvivors.sus:
        return _selectionSurvivorsBySus();
      default:
        return _selectionSurvivorsByTournament();
    }
  }

  List<Rule> _selectionSurvivorsByRouletteWheel() {
    List<Individual> temp = [];
    List<Rule> selectedParents = [];
    List<Rule> offspring = [];
    individualsWithAdditionalItem.forEach((key, value) {
      temp.add(Individual(id: key, fitness: value as double));
    });
    RouletteWheel rouletteWheel = RouletteWheel(individualWithFitness: temp);
    int count = kRuleGenerate ~/ 3;
    for (var i = 0; i < count; i++) {
      var idRule = rouletteWheel.spin();
      Rule rule = rules.firstWhere((element) => element.hashCode == idRule);
      print('my rule is $rule');
      selectedParents.add(rule);
    }
    //! crossOver
    for (var i = 0; i < count ~/ 2; i++) {
      var parentOne = selectedParents[Random().nextInt(selectedParents.length)];
      var parentTwo = selectedParents[Random().nextInt(selectedParents.length)];
      var p1 = _ruleToList(parentOne);
      var p2 = _ruleToList(parentTwo);
      for (var i = Random().nextInt(4); i < 4; i++) {
        var temp = p1[i];
        p1[i] = p2[i];
        p2[i] = temp;
      }
      var childOne = _listToRule(p1);
      var childTwo = _listToRule(p2);
      offspring
        ..add(childOne)
        ..add(childTwo);
    }
    //! mutation
    for (var element in offspring) {
      var mutationProbability = Random().nextInt(10) + 1;
      // probability of mutation is 0.3
      if (mutationProbability < 3) {
        var feature = Random().nextInt(4);
        var item = _ruleToList(element);
        item[feature] = AllValues.values[Random().nextInt(6)].index;
        element = _listToRule(item);
      }
    }
    return offspring;
  }

  _selectionSurvivorsBySus() {}
  _selectionSurvivorsByTournament() {}
}

class GeneticAlgorithm {}
