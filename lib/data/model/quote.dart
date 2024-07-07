class Quote {
  String? quote;
  String? author;

  Quote({this.quote, this.author});

  Quote.fromJson(Map<String, dynamic> json) {
    quote = json['quote'];
    author = json['author'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quote'] = this.quote;
    data['author'] = this.author;
    return data;
  }
}
