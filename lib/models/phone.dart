class Phone {
  late String number;
  late String info;

  Phone.fromJson(Map<String, dynamic> json) {
    this.number =json['number'];
    this.info =json['info'];
  }
}