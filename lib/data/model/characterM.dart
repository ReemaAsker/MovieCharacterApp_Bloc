import 'character.dart';

class CharacterM {
  CharacterM({
    required this.info,
    required this.chars,
  });
  late final Info info;
  late final List<Character> chars;

  CharacterM.fromJson(Map<String, dynamic> json) {
    info = Info.fromJson(json['info']);
    chars =
        List.from(json['results']).map((e) => Character.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['info'] = info.toJson();
    _data['results'] = chars.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Info {
  Info({
    required this.count,
    required this.pages,
    required this.next,
    this.prev,
  });
  late final int count;
  late final int pages;
  late final String next;
  late final Null prev;

  Info.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    pages = json['pages'];
    next = json['next'];
    prev = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['count'] = count;
    _data['pages'] = pages;
    _data['next'] = next;
    _data['prev'] = prev;
    return _data;
  }
}
