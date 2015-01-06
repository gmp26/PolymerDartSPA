import 'package:polymer/polymer.dart';
import 'dart:html';
import 'package:core_elements/core_scaffold.dart';


/**
 * A Polymer main-app element.
 */
@CustomTag('main-app')

class MainApp extends PolymerElement {
  
  /// Constructor used to create instance of MainApp.
  MainApp.created() : super.created() {
    print('created');
  }

  List<Map<String,dynamic>> pages = toObservable([
    { 'name': 'Single player', 
      'icon':'social:person', 
      'hash': 'G1',
      'content':'play-computer',
      'subContent': [
        { 'name': 'Level 1',
          'icon':'social:person', 
          'hash': 'G1L1',
          'content':'game1-level1'
        },
        { 'name': 'Level 2',
          'icon':'social:person', 
          'hash': 'G1L2',
          'content':'game1-level2'
        },
        { 'name': 'Code Blockly',
          'icon':'social:person', 
          'hash': 'G1L3',
          'content':'code-blockly'
        },
        { 'name': 'Play Blockly',
          'icon':'social:person', 
          'hash': 'G1L4',
          'content':'play-blockly'
        }
      ],
    },
    { 'name': 'Two player',
      'icon':'social:people',
      'hash': 'G2',
      'content':'play-human',
      'subContent': [
        { 'name': 'Level1',
          'icon':'social:people',
          'hash': 'G2L1',
          'content':'game2-level1'
        },
        { 'name': 'Level2',
          'icon':'social:people',
          'hash': 'G2L2',
          'content':'game2-level2'
        }
      ]
    }
  ]);

  
  int indexContent(List<Map<String, dynamic>> content, int x) {
    for(Map<String, dynamic> item in content) {
      print(item['hash'] + ' $x' );
      item['pageIndex'] = x++;
      List<Map<String, dynamic>> subContent = item['subContent'];
      if(subContent != null && subContent.length > 0) 
        x = indexContent(subContent, x);
    }
    return x;
  }
  
  @observable dynamic route;
  @observable dynamic subRoute = 0;
  @observable dynamic routeTitle = "foo";
  @observable dynamic subRouteTitle = "bar";
  @observable dynamic pageIndex = 0;

  /*
   * Unfortunately it's not possible to make getters observable by polymer expressions.
   * It really should be.
   */
  void setRoute(Iterable<int> selection) {
    int len = selection.length;
    if(len >= 1) {
      route = selection.elementAt(0) - 1;
      Map<String,dynamic> page = pages[route];
      routeTitle = page['name'];
      pageIndex = page['pageIndex'];
      subRoute = 1;
      if(len >= 2) {
        /* selecting subRoute from location is failing, so subRoute is not used */
        subRoute = selection.elementAt(1) - 1;
        Map<String,dynamic> p = page['subContent'][subRoute];
        subRouteTitle = p['name'];
        pageIndex = p['pageIndex'];
      }
    }
    else pageIndex = 0;
  }
  

  void printMenuHash(Iterable<int> matches) {
    print("menu selection = [" + matches.fold("", (s,i) => s + ",$i").substring(1) + "]");
  }
  
  Iterable<int> parseMenuHash(String hash) {
    if(hash == null || hash == "") hash = "G1";
    RegExp re = new RegExp(r"(\D+)?(\d+)"); 
    return re.allMatches(hash).map((m) => int.parse(m.group(2).toString()));
  }
  
  void menuItemSelected(Event e, var detail, Node sender) {
    if(detail['isSelected']) {
      String hash = (detail['item']).id;
      
      Iterable<int> selection = parseMenuHash(hash);

      print("menu routing");    
      setRoute(selection);
      printMenuHash(selection);
      print("route = $route, subRoute = $subRoute");
    }
  }

  
  void closeDrawer() {
    ($['scaffold'] as CoreScaffold).closeDrawer();
  }

  void installPage(page) {
    String elName = page['content'];
    dynamic ps = $[page['hash']];
    if(ps == null)
      print("Page container missing hash="+page['hash']);
    else { 
      while (ps.childNodes.length > 0) ps.firstChild.remove();
      var el = (new Element.tag(elName));
      el.setAttribute('foo', 'bar');
      ps.append(el);
    }
    if(page['subContent'] != null)
      for(var p in page['subContent']) {
        installPage(p);
      }
  }
  
  /* TODO: insert a proper router. This will do for a demo. */ 
  void routeToLocation(Event e) {
    print('hashChange');
    String hash = window.location.hash;
    
    print("location routing");    
    Iterable<int> selection = parseMenuHash(hash);
    setRoute(selection);
    printMenuHash(selection);
    
    for(var page in pages) {
      this.installPage(page);
    }
  }
  
  /// Called when an instance of main-app is inserted into the DOM.
  attached() {
    super.attached();
    
    print("attached");

    indexContent(pages, 0);
    
    // quick and dirty initial routing
    routeToLocation(null);
    
    window.onHashChange.listen(routeToLocation);

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
    print('ready');
  } 
  
}
