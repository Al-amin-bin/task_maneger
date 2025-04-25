class UserModel{


  late String id;
  late String email;
  late String firstName;
  late String lastName;
  late String mobile;
  late String createdDate;
  late String photo;

  // named constructor

  UserModel.fromJson(Map<String, dynamic> jsonData){
    id = jsonData["_id"]?? " ";
    email = jsonData["email"]?? " ";
    firstName = jsonData["firstName"]?? " ";
    lastName = jsonData["lastName"]?? " ";
    mobile = jsonData["mobile"]?? " ";
    createdDate = jsonData["createdDate"]?? '';
    photo = jsonData["photo"]?? '';
  }

  Map<String, dynamic>toJson(){
    return{
      '_id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'mobile': mobile,
      'createdDate': createdDate,


    };
}
String get fullName{
    return '$firstName $lastName';
}

}