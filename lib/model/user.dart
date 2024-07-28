import 'gender.dart';

class User {
  final String name;
  final Gender? gender;
  final DateTime? birthday;
  final String? country;
  final String? state;

  User({
    required this.name,
    this.gender,
    this.birthday,
    this.country,
    this.state,
  });

  @override
  String toString() =>
      'User(name: $name, gender: $gender, birthday: $birthday, country: $country, state: $state)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          gender == other.gender &&
          birthday == other.birthday &&
          country == other.country &&
          state == other.state;

  @override
  int get hashCode =>
      name.hashCode ^
      gender.hashCode ^
      birthday.hashCode ^
      country.hashCode ^
      state.hashCode;
}
