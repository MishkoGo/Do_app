class DoModel{
  //final String id;
  final String task;

  const DoModel({
   // required this.id,
    required this.task,
  });

  DoModel copyWith({
    String? task,
   // String? id,
  }) {
    return DoModel(
        //id: id ?? this.id,
        task: task ?? this.task,
    );
  }

  @override
  List<Object> get props => [
    task
  ];

  static List<DoModel> todos = [
    DoModel(task: 'task'),
  ];
}
