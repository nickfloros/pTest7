import 'package:google_maps/google_maps.dart' as GoogleMaps;

import 'package:polymer/polymer.dart';
import 'dart:html';

@CustomTag('gmap-map')
class MapElement extends PolymerElement {
  GoogleMaps.GMap _map;

  GoogleMaps.Geocoder _geocoder;

  /**
   * allow global css rules to apply 
   */
  bool get applyAuthorStyles => true;
  
  MapElement.created() : super.created() {
    
    print('${window.location.href}');
    final mapOptions = new GoogleMaps.MapOptions()
      ..mapTypeId = GoogleMaps.MapTypeId.ROADMAP
      ..center = new GoogleMaps.LatLng(-34.397, 150.644)
      ..zoom=5;
   final mapView = getShadowRoot('gmap-map').querySelector("#mapView");
    _map = new GoogleMaps.GMap(mapView, mapOptions);
   _geocoder = new GoogleMaps.Geocoder();
  }

  /**
   * view has been inserted .. 
   */
  enteredView() {
    super.enteredView();
    _map.onClick.listen(_locationCallback);
    // this allow to notify the map that the size of the canvas has changed.
    // in some cases, the map behaves like it has a 0*0 size.
 //   event.trigger(map, 'resize', []);
  }
  
  /**
   * user click / tap on map ..
   */
  void _locationCallback(GoogleMaps.MouseEvent g){
    print('location callback ${g.latLng.lat}, ${g.latLng.lng}');
    
    var pos = [g.latLng.lat,g.latLng.lng,'foo'];
    
    this.fire('mapClick',detail:pos);
    
    _geocoder.geocode(new GoogleMaps.GeocoderRequest()
                      ..location = g.latLng,
                      _geocoderCallback);
  }

  /**
   * geocoder callback, get address of a lat,lng position 
   */
  void _geocoderCallback(List<GoogleMaps.GeocoderResult> results, GoogleMaps.GeocoderStatus status) {
    if (status == GoogleMaps.GeocoderStatus.OK) {
      for (var i=0; i<results.length; i++){
        print('${i} - ${results[i].formattedAddress}');
        var address = [results[i].formattedAddress];
        if (i==0)
          this.fire('mapClickAddress', detail: address);
        for (var j=0; j<results[i].addressComponents.length; j++) {
          print(' ${results[i].addressComponents[j].types[0]} - ${results[i].addressComponents[j].longName}');
        }
      }
    }
  }
  
}