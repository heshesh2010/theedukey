class Settings {
  final int? id;
  final String? appName;
  final String? appNameEn;
  final String? darkLogo;
  final String? lightLogo;
  final String? mobileVerification;
  final String? createdAt;
  final String? updatedAt;

  Settings({
    this.id,
    this.appName,
    this.appNameEn,
    this.darkLogo,
    this.lightLogo,
    this.mobileVerification,
    this.createdAt,
    this.updatedAt,
  });

  Settings.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        appName = json['app_name'] as String?,
        appNameEn = json['app_name_en'] as String?,
        darkLogo = json['dark_logo'] as String?,
        lightLogo = json['light_logo'] as String?,
        mobileVerification = json['mobile_verification'] as String?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'app_name': appName,
        'app_name_en': appNameEn,
        'dark_logo': darkLogo,
        'light_logo': lightLogo,
        'mobile_verification': mobileVerification,
        'created_at': createdAt,
        'updated_at': updatedAt
      };
}
