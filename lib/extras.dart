import 'options.dart';

class Extra {
  String name;
  String id;
  List<Options> options;

  Extra({this.name, this.id, this.options});

  Extra.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    if (json['options'] != null) {
      options = [];
      json['options'].forEach((v) {
        options.add(new Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    if (this.options != null) {
      data['options'] = this.options.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
