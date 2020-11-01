class Todo{
  String title;
  bool completed;
  bool isEditable;

  Todo({
    this.title,
    this.completed = false,
    this.isEditable = false,
  });

  Todo.fromMap(Map<String, dynamic> map) :
    title = map['title'],
    completed = map['completed'],
    isEditable = map['isEditable'];

  updateTitle(title){
    this.title = title;
  }
  updateEdit(bool isEditable){
    this.isEditable = isEditable;
  }

  Map toMap(){
    return {
      'title': title,
      'completed': completed,
      'isEditable': isEditable,
    };
  }
}