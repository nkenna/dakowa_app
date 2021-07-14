class Bank {
  String? name;
  String? slug;
  String? code;
  String? country;
  String? currency;
  String? type;
  int? id;

  Bank(
      {this.name,
        this.slug,
        this.code,
        this.country,
        this.currency,
        this.type,
        this.id});

  Bank.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    slug = json['slug'];
    code = json['code'];
    country = json['country'];
    currency = json['currency'];
    type = json['type'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['code'] = this.code;
    data['country'] = this.country;
    data['currency'] = this.currency;
    data['type'] = this.type;
    data['id'] = this.id;
    return data;
  }
}


