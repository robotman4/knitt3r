import 'package:knitt3r/models/model.dart';

class CounterItem extends Model {

  static String table = 'counter_items';

  int id;
  String name;
  int value;

  CounterItem({ this.id, this.name, this.value });

  Map<String, dynamic> toMap() {

    Map<String, dynamic> map = {
      'name': name,
      'value': 0
    };

    if (id != null) { map['id'] = id; }
    return map;
  }

  static CounterItem fromMap(Map<String, dynamic> map) {

    return CounterItem(
        id: map['id'],
        name: map['name'],
        value: map['value']
    );
  }
}