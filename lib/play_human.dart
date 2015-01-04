import 'package:polymer/polymer.dart';

/**
 * A Polymer play-human element.
 */
@CustomTag('play-human')

class PlayHuman extends PolymerElement {

  @observable bool phoneScreen = false;

  /// Constructor used to create instance of PlayHuman.
  PlayHuman.created() : super.created() {
  }

  /*
   * Optional lifecycle methods - uncomment if needed.
   *

  /// Called when an instance of play-human is inserted into the DOM.
  attached() {
    super.attached();
  }

  /// Called when an instance of play-human is removed from the DOM.
  detached() {
    super.detached();
  }

  /// Called when an attribute (such as  a class) of an instance of
  /// play-human is added, changed, or removed.
  attributeChanged(String name, String oldValue, String newValue) {
  }

  /// Called when play-human has been fully prepared (Shadow DOM created,
  /// property observers set up, event listeners attached).
  ready() {
  }
   
  */
  
}
