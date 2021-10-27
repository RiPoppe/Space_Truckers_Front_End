import 'package:space_truckers/Widgets/connection_button.dart';
import 'package:space_truckers/Widgets/planet_button.dart';

class GlobalFunctions {
  // ignore: prefer_function_declarations_over_variables
  static Function refreshUI = () {};
  static List<PlanetButton> planetButtons = <PlanetButton>[];
  static List<ConnectionButton> connectionButtons = <ConnectionButton>[];
  static List<Function> updateFunctionsPlanets = <Function>[];
  static List<Function> updateFunctionsConnections = <Function>[];
  static List<String> result = <String>[];

  static callFunctions(bool showRoute) {
    for (var i = 2; i < result.length - 1; i++) {
      int index =
          planetButtons.indexWhere((element) => element.name == result[i]);
      updateFunctionsPlanets[index](showRoute);
    }
  }

  static updateFunction(String name, Function onRoute) {
    if (planetButtons.length != updateFunctionsPlanets.length) {
      updateFunctionsPlanets.add(onRoute);
    } else {
      int index = planetButtons.indexWhere((element) => element.name == name);
      updateFunctionsPlanets[index] = onRoute;
    }
  }
}
