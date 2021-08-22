class Address {
  late String address;

  Address.fromJson(Map<String, dynamic> json) {
    this.address =json['address'];
  }
}