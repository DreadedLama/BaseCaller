class Email {
  late String? email;
  late String? uri;

  Email.fromJson(Map<String, dynamic>? json) {
    if(json != null) {
      this.email = json['email'];
      this.uri = json['uri'];
    } else {
      this.email = 'Not registered';
    }
  }
}