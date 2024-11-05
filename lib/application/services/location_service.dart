import 'package:map_launcher/map_launcher.dart';
import 'package:myapp/domain/services/i_map_service.dart';

class LocationService implements IMapService {
  @override
  Future<void> openMap() async {
    if (await MapLauncher.isMapAvailable(MapType.google) ?? false) {
      await MapLauncher.showMarker(
        mapType: MapType.google,
        coords: Coords(9.03, 38.74),
        title: "Addis Ababa",
        description: "Capital city of Ethiopia",
      );
    } else {
      throw 'Google Maps is not available!';
    }
  }
}
