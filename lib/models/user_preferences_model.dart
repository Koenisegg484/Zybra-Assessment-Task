import 'package:hive/hive.dart';


@HiveType(typeId: 1)
class UserPreferences extends HiveObject {
  @HiveField(0)
  late String username;

  @HiveField(1)
  String theme = "system"; // Default to system theme

  @HiveField(2)
  DateTime? birthdate;

  UserPreferences({
    required this.username,
    this.theme = "system",
    this.birthdate,
  });
}