class SocialUserModel {
  late String name, email, phone, uId,image,bio,cover;
  late bool isEmailVerified;
  
  SocialUserModel({
    required this.name, required this.email, required this.phone,required this.bio,
    required this.uId, required this.isEmailVerified,required this.image,required this.cover
});

  
  SocialUserModel.fromJson(Map<String, dynamic> json)
  {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    isEmailVerified = json['isEmailVerified'];
    image = json['image'];
    bio = json['bio'];
    cover = json['cover'];
  }


  Map<String, dynamic> toMap()
  {
    return {
      'name':name,
      'email':email,
      'phone':phone,
      'isEmailVerified':isEmailVerified,
      'image':image,
      'bio':bio,
      'cover':cover,
    };
  }
}