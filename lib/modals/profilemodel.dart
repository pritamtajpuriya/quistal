class UserDetail {
  UserDetail(
      {this.city, this.address, this.zip_code, this.profilePic, this.email});

  String city;
  String address;
  String zip_code;
  String profilePic;
  String email;

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
        city: json["city"],
        address: json["address"],
        zip_code: json["zip_code"],
        profilePic: json["profile_pic"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "city": city,
        "address": address,
        "zip_code": zip_code,
        "profile_pic": profilePic,
      };
}
