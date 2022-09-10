class Rate {
  int id;
  String name;
  Rate(this.id, this.name);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Rate && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
