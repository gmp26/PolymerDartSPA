import 'package:polymer/polymer.dart';
import 'dart:html';

/**
 * A Polymer play-computer element.
 */
@CustomTag('play-computer')

class PlayComputer extends PolymerElement {

  @observable bool phoneScreen = false;
  @observable String small;
  
  void play(event, detail, target) {
    window.location.href="#G1L1";
  }
  
  
  /// Constructor used to create instance of PlayComputer.
  PlayComputer.created() : super.created() {
  }

  /*
   * Optional lifecycle methods - uncomment if needed.
   *

  /// Called when an instance of play-computer is inserted into the DOM.
  attached() {
    super.attached();
  }

  /// Called when an instance of play-computer is removed from the DOM.
  detached() {
    super.detached();
  }

  /// Called when an attribute (such as  a class) of an instance of
  /// play-computer is added, changed, or removed.
  attributeChanged(String name, String oldValue, String newValue) {
  }

  /// Called when play-computer has been fully prepared (Shadow DOM created,
  /// property observers set up, event listeners attached).
  ready() {
  }
   
  */
  
}
