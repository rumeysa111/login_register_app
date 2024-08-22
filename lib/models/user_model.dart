class UserModel {
  String? uid;
  String? firstName;
  String? lastName;
  String? email;

  UserModel({this.uid, this.firstName, this.lastName, this.email});

  // Firebase'den veri çekerken kullanılacak yöntem
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
    );
  }

  // Firebase'e veri eklerken kullanılacak yöntem
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
    };
  }
}
