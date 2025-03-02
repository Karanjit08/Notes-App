class NotesModel {
  String? title;
  String? subtitle;
  NotesModel({required this.title,required this.subtitle});

  // Convert a Note object into a Map
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subtitle': subtitle,
    };
  }

  // Create a Note object from a Map
  factory NotesModel.fromMap(Map<String, dynamic> map) {
    return NotesModel(
      title: map['title'],
      subtitle: map['subtitle'],
    );
  }
}