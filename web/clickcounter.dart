import 'package:polymer/polymer.dart';
import 'dart:html';

/**
 * A Polymer click counter element.
 */
@CustomTag('click-counter')
class ClickCounter extends PolymerElement {
  @published int count = 0;
  
  ClickCounter.created() : super.created() {
    
  }

  void increment() {
    count++;
  }
  
  void add() {
    querySelector('#add-here').children.add(new Element.tag('my-element'));
  }
}

