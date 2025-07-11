class Note {
  final int id;
  final String title;
  final String content;
  final DateTime createdAT;
  final DateTime updatedAT;
  final int userID;
  final bool isDeleted;

  const Note({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAT,
    required this.updatedAT,
    required this.userID,
    required this.isDeleted,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      createdAT: DateTime.parse(json['created_at']),
      updatedAT: DateTime.parse(json['updated_at']),
      userID: json['user_id'],
      isDeleted: json['is_deleted'] == true || json['is_deleted'] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'created_at': createdAT.toIso8601String(),
      'updated_at': updatedAT.toIso8601String(),
      'user_id': userID,
      'is_deleted': isDeleted,
    };
  }
}