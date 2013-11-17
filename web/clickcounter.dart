import 'package:polymer/polymer.dart';
import 'dart:html';

/**
 * A Polymer click counter element.
 */
@CustomTag('click-counter')
class ClickCounter extends PolymerElement {
  @published int count = 0;
  @published num lat = 0;
  @published num lng = 0;

  ClickCounter.created() : super.created() {
    _init();
  }
  
  void _init() {
    window.on['mapClick'].listen((CustomEvent onData) {
      print('map event');
      lat=onData.detail[0];
      lng = onData.detail[1];
      
    });
  }  
  void increment() {
    count++;
  }
  
  void add() {
    querySelector('#add-here').children.add(new Element.tag('my-element'));
  }
}

