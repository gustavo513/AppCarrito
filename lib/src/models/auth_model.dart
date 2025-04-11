class AuthModel{
  String? correo;
  String? username;
  String? password;

  AuthModel(String correo, String username, String password){
    this.correo = correo;
    this.username = username;
    this.password = password;
  }
}