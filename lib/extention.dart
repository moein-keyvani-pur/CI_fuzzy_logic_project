import 'dart:io';

import 'features/petal_length.dart';
import 'features/petal_width.dart';
import 'features/sepal_length.dart';
import 'features/sepal_width.dart';
import 'features/xp.dart';
import 'utility.dart';

class FunctionCreator {
  void lenearFunction(double deltaY, double deltaX) {
    var y = (deltaY / deltaX);
  }
}

class GeneralHelper {
  static List<XP> readDataFromFile() {
    File file = File("Iris.csv");

    String users = file.readAsStringSync();

    var data = _csvToUsersList(users);

    return data;
  }

  static List<XP> _csvToUsersList(String data) {
    List<XP> users = [];

    List<String> usersFromFile = data.split("\n");

    for (int i = 1; i < usersFromFile.length - 1; i++) {
      List<String> user = usersFromFile[i].split(",");

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
}
