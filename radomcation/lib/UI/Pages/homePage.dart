import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:radomcation/Services/Core/core.dart';

import '../Other/mapUtils.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {

  double _dimen = 200;
  AnimationController _dotController;
  double _sliderValue = 1;

  void initState(){
    _dotController = AnimationController(vsync: this, lowerBound: 200, upperBound: 300, duration: Duration(milliseconds: 800));
    _dotController.addListener(() {
      setState(() {
        _dimen = _dotController.value;
      });
    });
    super.initState();
  }

  void _onTap() async {
    _dotController.forward().then((s) {
       _dotController.repeat(reverse: true);
    });
    Location location = new Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    Coordinates coordinates = await  getRandomCoordinates(location, _sliderValue);
    MapUtils.openMap(coordinates.lat, coordinates.long);
    _dotController.stop();
  }

  @override
  Widget build(BuildContext context) {
    var dot = GestureDetector(
          onTap: _onTap,
          child: Container(
            height: _dimen,
            width: _dimen,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(500)),
              color: Colors.tealAccent
            ),
          ),
        );
    var slider = Container(
      margin: EdgeInsets.all(20),
      child: Slider(
        inactiveColor: Colors.grey[500],
        activeColor: Colors.grey[800],
        min: 0,
        max: 10,
        value: _sliderValue,
        onChanged: (newValue) {
          setState(() {
          _sliderValue = newValue; 
          });
        },
        divisions: 10,
        label: "${_sliderValue.floor()}",
      ),
    );
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        alignment: Alignment.center,
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            dot,
            slider,
          ],
        )
      ),
    );
  }
}