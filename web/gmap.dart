import 'package:google_maps/google_maps.dart' as GoogleMaps;
import 'package:polymer/polymer.dart';

@CustomTag('gmap-map')
class MapElement extends PolymerElement {
  GoogleMaps.GMap _map;
  
  MapElement.created() : super.created() {
    final mapOptions = new GoogleMaps.MapOptions()
      ..mapTypeId = GoogleMaps.MapTypeId.ROADMAP
      ..center = new GoogleMaps.LatLng(-34.397, 150.644)
      ..zoom=5;
   final mapView = getShadowRoot('gmap-map').querySelector("#mapView");
    _map = new GoogleMaps.GMap(mapView, mapOptions);
  }

  enteredView() {
    super.enteredView();
    _map.onClick.listen(_locationCallback);
    // this allow to notify the map that the size of the canvas has changed.
    // in some cases, the map behaves like it has a 0*0 size.
 //   event.trigger(map, 'resize', []);
  }
  
  void _locationCallback(GoogleMaps.MouseEvent g){
    print('location callback ${g.latLng.lat}, ${g.latLng.lng}');
  }
}