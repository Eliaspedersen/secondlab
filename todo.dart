// lib/todo.dart

class Todo {
  final String id;
  String title;
  bool done;

  Todo({
    required this.id,
    required this.title,
    required this.done,
  });

  // Factory constructor to create a Todo object from JSON
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'] as String,
      title: json['title'] as String,
      done: json['done'] as bool,
    );
  }

  // Method to convert the Todo object to JSON (for POST/PUT requests)
  Map<String, dynamic> toJson() {
    return {
      // NOTE: Do not include 'id' for POST, but it's needed for PUT
      'title': title,
      'done': done,
    };
  }
}