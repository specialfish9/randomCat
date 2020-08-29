import 'package:location/location.dart';
import 'package:radomcation/Services/Network/network.dart';

String _url = "https://qrng.anu.edu.au/API/jsonI.php?length=1&type=uint8&size=6";
const double _FACTOR_MIN = 10;
const double _FACTOR_MAX = 100000;

Future<Coordinates> getRandomCoordinates(Location location, double distanceRatio) async {
  LocationData locationData = await location.getLocation();
  return Coordinates(
    locationData.latitude + await askForRandomNumber(distanceRatio),
    locationData.longitude + await askForRandomNumber(distanceRatio),
    locationData.altitude //+ await askForRandomNumber(),
  );
}

Future<double> askForRandomNumber(double distanceRatio) async{
  var response = await getRandom(_url);
  return (response.esit)? _normalize(response.data.data[0], distanceRatio) : 0;
}

double _normalize(int x, double distanceRatio){
  double delta = _FACTOR_MAX - _FACTOR_MIN;
  double increment = (distanceRatio * delta) / 10;
  double newFactor = _FACTOR_MAX - increment;
  print("[INFO] newFactor = $newFactor");
  double res = x / newFactor;
  return x % 2 == 0 ? -res : res; 
}

class Coordinates {
  double lat, long, alt;

  Coordinates(this.lat, this.long, this.alt);
}