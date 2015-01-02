import 'package:polymer/polymer.dart';
import 'dart:html';
import 'package:core_elements/core_scaffold.dart';
import 'package:paper_elements/paper_shadow.dart';
import 'package:GotitPolymerDart/page_model.dart';



/**
 * A Polymer main-app element.
 */
@CustomTag('main-app')

class MainApp extends PolymerElement {

  @observable dynamic route;

  /*
   * It should be possible to observe getters directly, but it isn't SFAIK.
   */
  @observable dynamic routeTitle = "foo";
  void setRouteTitle(int i) {
    route = i;
    routeTitle = pages[i].name;
  }
  
  @observable Object subRoute = 0;

/* These do not need to be observable */  
//  @observable Object page;
//  @observable Object i;

//  Element page1Content;
  
  List<PageModel> ipages = [];
  
  List<PageModel> pages;

  List<Map<String,dynamic>> menus = toObservable([
    { 'name': 'Single player', 
      'icon':'social:person', 
      'hash': 'G1',
      'content':'play-computer',
      'subContent': [
        { 'name': 'Level 1',
          'icon':'social:person', 
          'hash': 'G1-L1',
          'content':'play-computer'
        },
        { 'name': 'Level 2',
          'icon':'social:person', 
          'hash': 'G1-L2',
          'content':'play-computer'
        }
      ],
    },
    { 'name': 'Two player',
      'icon':'social:people',
      'hash': 'G2',
      'content':'play-human',
      'subContent': [
        { 'name': 'Two player',
          'icon':'social:people',
          'hash': 'G2-L1',
          'content':'play-human'
        },
        { 'name': 'Two player',
          'icon':'social:people',
          'hash': 'G2-L2',
          'content':'play-human'
        }
      ]
    }
  ]);

  void init() {

    PageModel g1L1 = new PageModel(
        'Level 1', 'social:person', 'G1L1', 'game1-level1', []
        );
    PageModel g1L2 = new PageModel(
        'Level 2', 'social:person', 'G1L2', 'game1-level2', []
        );
    PageModel g1L3 = new PageModel(
        'Play Blockly', 'social:person', 'G1L3', 'play-blockly', []
        );
    ipages.add(new PageModel(
      'Single player', 'social:person', 'G1', 'play-computer', [g1L1, g1L2, g1L3]
      ));
    
    PageModel g2L1 = new PageModel(
        'Level 1', 'social:people', 'G2L1', 'game2-level1', []
        );
    PageModel g2L2 = new PageModel(
        'Level 2', 'social:people', 'G2L2', 'game2-level2', []
        );
    ipages.add(new PageModel(
      'Two player', 'social:people', 'G2', 'play-human', [g2L1, g2L2]
      ));
    
    PageModel g3L1 = new PageModel(
        'Editor', 'social:people', 'G3L1', 'game3-level1', []
        );
    ipages.add(new PageModel(
      'Code Blockly', 'account-balance-wallet', 'G3', 'code-blockly', [g3L1]
      ));
    
    pages = toObservable(ipages);

  }

  void menuItemSelected(Event e, var detail, Node sender) {
    setRouteTitle(route);
    if(detail['isSelected']) {
      String itemId = (detail['item']).id;
      List<String> ids = itemId.split('-');
      print(ids);
      if(ids.length > 1) {
        print("closing");   
        closeDrawer();        
      }
//      window.location.assign('http://cmep.maths.org');
    }
  }

  void closeDrawer() {
    ($['scaffold'] as CoreScaffold).closeDrawer();
  }
  
  /* TODO: insert a proper router. This will do for a demo. */ 
  void routeToLocation(Event e) {
    print('hashChange');
    String hash = window.location.hash;
    if(hash.length > 2) {
      setRouteTitle(int.parse(window.location.hash.substring(2,3)) - 1);
    }
    if(hash.length > 4) {
      subRoute = int.parse(window.location.hash.substring(4,5)) - 1;
    }
    print(subRoute);
  }
  
  /// Constructor used to create instance of MainApp.
  MainApp.created() : super.created() {
    print('created');
    
    for(var page in pages) {
      String elName = page.content;
      dynamic ps = this.$[page.hash] as PaperShadow;
      if(ps == null)
        print("Page container missing hash="+page.hash);
      else { 
        while (ps.childNodes.length > 0) ps.firstChild.remove();
        var el = (new Element.tag(elName));
        el.setAttribute('foo', 'bar');
        ps.append(el);
      }
    }
    
  }

  /// Called when an instance of main-app is inserted into the DOM.
  attached() {
    super.attached();
    

//    for(var page in pages) {
//      String elName = page['content'];
//      PaperShadow ps = this.$[page['hash']] as PaperShadow;
//      if(ps == null)
//        print("Page container missing");
//      else { 
//        while (ps.childNodes.length > 0) ps.firstChild.remove();
//        var el = (new Element.tag(elName));
//        el.setAttribute('foo', 'bar');
//        ps.append(el);
//      }
//    }
//    
        // quick and dirty initial routing from hash
    //routeToLocation(null);
    
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

    print('attached');
    
    init();
    
  } 
  
}
