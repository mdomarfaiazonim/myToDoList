class TODO{
  int id;
  String title;
  String desc;

  TODO({required this.id,required this.title, required this.desc});

  Map<String,dynamic> toMap(){
    return {
      'id': id,
      'title': title,
      'desc': desc,
    };
  }
}