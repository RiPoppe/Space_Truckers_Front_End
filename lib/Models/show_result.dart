import 'package:space_truckers/Widgets/planet_button.dart';

class ShowResult {
  static List<PlanetButton> pbuttons = <PlanetButton>[];
  static List<Function> updateFunctions = <Function>[];
  static List<String> result = <String>[];

  static callFunctions(bool showRoute) {
    for (var i = 2; i < result.length - 1; i++) {
      int index = pbuttons.indexWhere((element) => element.name == result[i]);
      updateFunctions[index](showRoute);
    }
  }

  static updateFunction(String name, Function onRoute) {
    if (pbuttons.length != updateFunctions.length) {
      updateFunctions.add(onRoute);
    } else {
      int index = pbuttons.indexWhere((element) => element.name == name);
      updateFunctions[index] = onRoute;
    }
  }
}
