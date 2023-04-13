class AddressEntity {
  String homeAddress;
  String city;
  String contactName;
  String contactNumber;
  String type;

  AddressEntity({
    this.homeAddress = '',
    this.city = '',
    this.contactName = '',
    this.contactNumber ='',
    this.type = ''
  });

  Map<String, dynamic> toJson() => {
    'home_address': homeAddress,
    'city': city,
    'contact_name': contactName,
    'contact_number': contactNumber,
    'type': type
  };

  factory AddressEntity.fromJson(Map<String, dynamic> json) {
    return AddressEntity(
        homeAddress: json['home_address'],
        city: json['city'],
        contactName: json['contact_name'],
        contactNumber: json['contact_number'],
        type: json['type']
    );
  }
}