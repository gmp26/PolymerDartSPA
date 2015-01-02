library pageModel;

class PageModel {
  
  String name;
  String icon;
  String hash;
  String content;
  List<PageModel> subContent = [];
  
  PageModel(this.name, this.icon, this.hash, this.content, this.subContent);
  
}
