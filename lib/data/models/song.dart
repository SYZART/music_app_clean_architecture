class Song {
  final String id;
  final String title;
  final String performer;
  Song({
    required this.id,
    required this.title,
    required this.performer,
  });

  factory Song.fromJson(Map<String, dynamic> json) => Song(
        id: json["id"],
        title: json["title"],
        performer: json["performer"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "performer": performer,
      };
}
