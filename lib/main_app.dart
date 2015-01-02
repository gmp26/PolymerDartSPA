import 'package:polymer/polymer.dart';
import 'dart:html';
import 'package:core_elements/core_scaffold.dart';
import 'package:paper_elements/paper_shadow.dart';

/**
 * A Polymer main-app element.
 */
@CustomTag('main-app')

class MainApp extends PolymerElement {

  @observable Object route = 0;
  @observable Object subroute = 0;
  @observable String title;

/* These do not need to be observable */  
//  @observable Object page;
//  @observable Object i;

  Element page1Content;
  
  List<Map<String,String>> pages = toObservable([
    { 'name': 'Single player', 
      'icon':'social:person', 
      'hash': 'G1', 
      'content':'play-computer'
    },
    { 'name': 'Two player',
      'icon':'social:people',
      'hash': 'G2',
      'content':'play-human'
    },
  ]);
  
  
  
//  void menuItemSelected(Event e, var detail, Node sender) {
//    if (detail['isSelected']) {
//      ($['scaffold'] as CoreScaffold)
//      .closeDrawer();
//    }
//  }
//
  
  void submenuItemSelected(Event e, var detail, Node sender) {
    if (detail['isSelected']) {
      ($['scaffold'] as CoreScaffold)
      .closeDrawer();
    }
  }

  /* TODO: insert a proper router. This will do for a demo. */ 
  void routeToLocation(Event e) {
    print('hashChange');
    String hash = window.location.hash;
    if(hash.length > 2)
      route = int.parse(window.location.hash.substring(2,3)) - 1;
    if(hash.length > 4)
      subroute = int.parse(window.location.hash.substring(4,5)) - 1;
    print(subroute);
  }
  
  /// Constructor used to create instance of MainApp.
  MainApp.created() : super.created() {
  }

  /// Called when an instance of main-app is inserted into the DOM.
  attached() {
    super.attached();
  }

  /*
   * Optional lifecycle methods - uncomment if needed.
   *

  /// Called when an instance of main-app is removed from the DOM.
  detached() {
    super.detached();
  }

  /// Called when an attribute (such as  a class) of an instance of
  /// main-app is added, changed, or removed.
  attributeChanged(String name, String oldValue, String newValue) {
  }
  */

  /// Called when main-app has been fully prepared (Shadow DOM created,
  /// property observers set up, event listeners attached).
  ready() {
    title = 'goo';
    for(var page in pages) {
      String elName = page['content'];
      PaperShadow ps = this.$[page['hash']] as PaperShadow;
      if(ps == null)
        print("Page container missing");
      else { 
        while (ps.childNodes.length > 0) ps.firstChild.remove();
        var el = (new Element.tag(elName));
        el.setAttribute('foo', 'bar');
        ps.append(el);
      }
    }
    
    // quick and dirty initial routing from hash
    routeToLocation(null);
    
    window.onHashChange.listen(routeToLocation);
  } 
  
}
