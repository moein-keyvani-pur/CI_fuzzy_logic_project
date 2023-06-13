import 'dart:math';
import 'package:hw_fuzzy_logic/utility.dart';
import 'package:roulette_wheel_and_sus/roulette_wheel_and_sus.dart';

import 'features/xp.dart';
import 'rule.dart';

class Michigan extends GeneticAlgorithm {
  List<Rule> _rules;
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
  set setRules(List<Rule> ruleArg) => _rules = ruleArg;
  List<XP> get mySamples => _mySamples;

  List<int> _ruleToList(Rule rule) {
    List<int> item = [];
    return item
      ..add(rule.sepalLengthValues.index)
      ..add(rule.sepalWidthValues.index)
      ..add(rule.petalLengthValues.index)
      ..add(rule.petalWidthValues.index)
      ..add(rule.species!.index);
  }

  Rule _listToRule(List<int> item) {
    return Rule(
      sepalLength: SepalLengthValues.values[item[0]],
      sepalWidth: SepalWidthValues.values[item[1]],
      petalLength: PetalLengthValues.values[item[2]],
      petalWidth: PetalWidthValues.values[item[3]],
    )..setSpecies = Species.values[item[4]];
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
      // individual.setCf = value;
      individualsWithAdditionalItem[individual.hashCode] = value;
    }
  }

  List<Rule> getBestRoules(
      {required SelectionSurvivors selectionSurvivorsMethod}) {
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
    var repat = kRuleGenerate;
    while (repat > 0) {
      repat--;
      _fitnessFunction();
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
        selectedParents.add(rule);
      }
      //! crossOver
      for (var i = 0; i < count ~/ 2; i++) {
        var parentOne =
            selectedParents[Random().nextInt(selectedParents.length)];
        var parentTwo =
            selectedParents[Random().nextInt(selectedParents.length)];
        var p1 = _ruleToList(parentOne);
        var p2 = _ruleToList(parentTwo);
        // crossover<int>(parentOne: p1, parentTwo: p2);
        for (var i = Random().nextInt(p1.length); i < p1.length; i++) {
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
        var mutationProbability = Random().nextDouble();
        // probability of mutation is 0.3
        if (mutationProbability < 0.3) {
          var feature = Random().nextInt(4);
          var item = _ruleToList(element);
          item[feature] = AllValues.values[Random().nextInt(6)].index;
          element = _listToRule(item);
        }
      }
      var newAndOldRules = rules + offspring;
      List<Rule> tempRule = [];
      for (var i = 0; i < kRuleGenerate; i++) {
        var item = newAndOldRules[Random().nextInt(newAndOldRules.length)];
        tempRule.add(item);
      }
      rules.clear();
      setRules = List.of(tempRule);
    }
    return rules;
  }

  List<Rule> _selectionSurvivorsBySus() {
    var repat = kRuleGenerate;
    while (repat > 0) {
      repat--;
      _fitnessFunction();
      List<Individual> temp = [];
      List<Rule> selectedParents = [];
      List<Rule> offspring = [];
      individualsWithAdditionalItem.forEach((key, value) {
        temp.add(Individual(id: key, fitness: value as double));
      });
      Sus sus = Sus(individualWithFitness: temp);
      int count = kRuleGenerate ~/ 3;
      var idsRule = sus.spin(itemSelect: count);
      for (var id in idsRule) {
        for (var r in rules) {
          if (id == r.hashCode) {
            selectedParents.add(r);
            break;
          }
        }
      }
      //! crossOver
      for (var i = 0; i < count ~/ 2; i++) {
        var parentOne =
            selectedParents[Random().nextInt(selectedParents.length)];
        var parentTwo =
            selectedParents[Random().nextInt(selectedParents.length)];
        var p1 = _ruleToList(parentOne);
        var p2 = _ruleToList(parentTwo);
        // crossover<int>(parentOne: p1, parentTwo: p2);
        for (var i = Random().nextInt(p1.length); i < p1.length; i++) {
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
        var mutationProbability = Random().nextDouble();
        // probability of mutation is 0.3
        if (mutationProbability < 0.3) {
          var feature = Random().nextInt(4);
          var item = _ruleToList(element);
          item[feature] = AllValues.values[Random().nextInt(6)].index;
          element = _listToRule(item);
        }
      }
      var newAndOldRules = rules + offspring;
      List<Rule> tempRule = [];
      for (var i = 0; i < kRuleGenerate; i++) {
        var item = newAndOldRules[Random().nextInt(newAndOldRules.length)];
        tempRule.add(item);
      }
      rules.clear();
      setRules = List.of(tempRule);
    }
    return rules;
  }

  _selectionSurvivorsByTournament() {}
}

class GeneticAlgorithm {
  void crossover<E>({required List<E> parentOne, required List<E> parentTwo}) {
    var length = parentOne.length;
    for (var i = Random().nextInt(length); i < length; i++) {
      var temp = parentOne[i];
      parentOne[i] = parentTwo[i];
      parentTwo[i] = temp;
    }
  }
  // void mutation<E>({required List<E> individual,int mutationProbability=1}){
  //    var randomNumber = Random().nextDouble() ;
  //     if (randomNumber < mutationProbability) {
  //       var feature = Random().nextInt(individual.length);
  //       var item = _ruleToList(element);
  //       item[feature] = AllValues.values[Random().nextInt(6)].index;
  //       element = _listToRule(item);
  //     }
  // }
}
