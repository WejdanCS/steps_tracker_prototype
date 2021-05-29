import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';

class StepsTracker extends ChangeNotifier{

  Stream<StepCount> _stepCountStream;
  Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = 'unknown', _steps = 'unknown';
  get steps => _steps;

  Stream<StepCount> get stepCountStream =>
      _stepCountStream; //--------user steps
  void initPlatformState() {
    print("ggg");
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);
    // notifyListeners();
  }
  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    _status = event.status;
    notifyListeners();
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    _steps = 'Step Count not available';
    notifyListeners();
  }

  void onStepCount(StepCount event) {
    print(event);
    print(event.timeStamp);
    _steps = event.steps.toString();
    notifyListeners();
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    _status = 'Pedestrian Status not available';
    print(_status);
    notifyListeners();
  }

  Stream<PedestrianStatus> get pedestrianStatusStream =>
      _pedestrianStatusStream;
}
