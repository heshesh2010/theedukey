class Language {
  String code;
  String englishName;
  String localName;
  String flag;
  bool selected;

  Language(this.code, this.englishName, this.localName, this.flag,
      {this.selected = false});
}

class LanguagesList {
  List<Language> _languages = [];

  LanguagesList() {
    _languages = [
      Language("en", "English", "الأنجليزية", "assets/img/united-states.png"),
      Language("ar", "Arabic", "العربية", "assets/img/saudi.png"),
    ];
  }

  List<Language> get languages => _languages;
}
