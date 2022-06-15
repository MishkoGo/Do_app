class DoModel{
  final int ?id;
  final String task;

  const DoModel({
    required this.id,
    required this.task,
  });

  DoModel copyWith({
    String? task,
    int? id,
  }) {
    return DoModel(
        id: id ?? this.id,
        task: task ?? this.task,
    );
  }

  @override
  List<Object> get props => [
    task,
  ];

  static List<DoModel> todos = [
    DoModel(task: 'task', id: null),
  ];
}
