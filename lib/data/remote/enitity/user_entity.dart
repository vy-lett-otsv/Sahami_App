class UserEntity {
  String userId;
  String userName;
  String contact;
  String email;
  String dob;
  String gender;
  String role;
  String image;
  String address;

  UserEntity({
    this.userId = '',
    required this.userName,
    required this.contact,
    required this.email,
    this.dob = '',
    this.gender = '',
    this.role = 'user',
    this.image = '',
    this.address = ''
  });

  Map<String, dynamic> toJson() => {
    'id': userId,
    'name': userName,
    'contact': contact,
    'email': email,
    'dob': dob,
    'gender': gender,
    'role':role,
    'image': image,
    'address': address
  };

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      userId: json['id'],
      userName: json['name'],
      contact: json['contact'],
      email: json['email'],
      dob: json['dob'],
      gender: json['gender'],
      role: json['role'],
      image: json['image'],
      address: json['address']
    );
  }
}