import 'package:polymer/polymer.dart';
import 'dart:html';
import 'package:core_elements/core_scaffold.dart';

/**
 * A Polymer main-app element.
 */
@CustomTag('main-app')

class MainApp extends PolymerElement {

  @observable Object route;
  @observable Object page;
  @observable Object i;

  final List<Map<String,String>> pages = toObservable([
    {'name': 'Single', 'hash': 'one', 'index': 0},
    {'name': 'page', 'hash': 'two', 'index': 1},
    {'name': 'app', 'hash': 'three', 'index': 2},
    {'name': 'using', 'hash': 'four', 'index': 3},
    {'name': 'polymer', 'hash': 'five', 'index': 4}
  ]);
  
  void menuItemSelected(Event e, var detail, Node sender) {
    if (detail['isSelected']) {
      ($['scaffold'] as CoreScaffold).closeDrawer();
    }
  }

  /// Constructor used to create instance of MainApp.
  MainApp.created() : super.created() {
      
  }

  /*
   * Optional lifecycle methods - uncomment if needed.
   *

  /// Called when an instance of main-app is inserted into the DOM.
  attached() {
    super.attached();
  }

  /// Called when an instance of main-app is removed from the DOM.
  detached() {
    super.detached();
  }

  /// Called when an attribute (such as  a class) of an instance of
  /// main-app is added, changed, or removed.
  attributeChanged(String name, String oldValue, String newValue) {
  }

  /// Called when main-app has been fully prepared (Shadow DOM created,
  /// property observers set up, event listeners attached).
  ready() {
  }
   
  */
  
}
