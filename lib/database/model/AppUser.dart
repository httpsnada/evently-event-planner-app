class AppUser {
  String? id;
  String? name;

  String? email;

  AppUser({this.id, this.name, this.email});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'email': email};
  }

  AppUser.fromMap(Map<String, dynamic>? map) {
    this.id = map?['id'];
    this.name = map?['name'];
    this.email = map?['email'];
  }
}
