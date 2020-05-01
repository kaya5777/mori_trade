import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TabBloc {
  List<String> _items = [];
  final String kind;

  final BehaviorSubject<List<String>> _itemController = BehaviorSubject<List<String>>.seeded([]);

  Sink<List<String>> get _inItem => _itemController.sink;

  Stream<List<String>> get outItem => _itemController.stream;

  void dispose() {
    _itemController.close();
  }

  TabBloc({this.kind}) {
    _loadItems();
  }

  void _loadItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String itemStr = prefs.getString("ITEM_$kind");

    if(itemStr != null) {
      _items = itemStr.split(',');
      _inItem.add(_items);
    }
  }

  void _saveItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String value;
    if(_items.length == 0) {
      value = null;
    } else if(_items.length == 1) {
      value = _items[0];
    } else {
      value = _items.join(',');
    }
    prefs.setString("ITEM_$kind", value);
  }

  void addItem(String item) {
    if(_items.contains(item)) return;
    _items.insert(0, item);
    _inItem.add(_items);
    _saveItems();
  }

  void deleteItem(String item) {
    int index = _items.indexOf(item);
    if(index > -1) {
      _items.removeAt(index);
      _inItem.add(_items);
      _saveItems();
    }
  }

  String createMessage() {
    String value = "";
    _items.forEach((item) {
      value += "$item\n";
    });
    if(value == "") value = "なし\n";
    return value;
  }
}