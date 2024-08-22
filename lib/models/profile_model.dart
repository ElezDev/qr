class ProfileModel {
  Profile profile;
  String accessToken;

  ProfileModel({
    required this.profile,
    required this.accessToken,
  });

  ProfileModel.fromJsonMap(Map<String, dynamic> json)
      : profile = Profile.fromJsonMap(json['profile']),
        accessToken = json['access_token'];
}

class Profile {
  String id;
  String login;
  String nombre;

  Profile({
    required this.id,
    required this.login,
    required this.nombre
  });

  Profile.fromJsonMap(Map<String, dynamic> json)
      : id = json['id'],
        login = json['login'],
        nombre = json['nombre'];
}
