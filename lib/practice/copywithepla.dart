


void main(){

  Map<String,dynamic>userdata = {"username":"Talha Afridi","password":"09876","email":"kabara@gmail.com"};
  var p1 = Profile.fromJson(userdata);
  var p2 = Profile.fromMap(userdata);
  var p3 = p2.copyWith(email: "talhashah@gmail.com");
  print(p1.email);
  print(p3.email);
  print(p2.password);
  p3  = p3.copyWith(email: "ptiti@gmaic.com");
  print(p3.email);
  p3.email = "Talhaafridi@mgsil.com";
  print(p3.email);
}

class Profile {
 final String username;
   String email;
final  String password;
  Profile({
    required this.email,
    required this.username ,
    required this.password,
  });

  Profile.fromJson(Map<String,dynamic>json):
    username = json["username"]??"",
    email =json["email"]??"",
    password = json["password"]??"";


  Profile copyWith({
    String?username,
    String?email,
    String?password
}){
    return Profile(
        email: email??this.email,
        username: username??this.username,
        password: password??this.password
    );
}

Profile.fromMap(Map<String,dynamic>map):
      username= map["username"],
  email = map["email"],
  password = map["password"];

  Map<String,dynamic>toMap(){
    return {
      "username":username,
      "password":password,
      "email":email
    };
  }


}