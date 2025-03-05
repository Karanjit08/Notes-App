class NotesModel {
  int? id;
  String? title;
  String? subtitle;
  NotesModel({this.id,required this.title,required this.subtitle});

  // Convert a Note object into a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
    };
  }

  // Create a Note object from a Map
  factory NotesModel.fromMap(Map<String, dynamic> map) {
    return NotesModel(
      id: map['id'],
      title: map['title'],
      subtitle: map['subtitle'],
    );
  }
}