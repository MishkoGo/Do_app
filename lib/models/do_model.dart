class DoModel{
  final String task;

  const DoModel({
    required this.task,
  });

  DoModel copyWith({
    String? task,
  }) {
    return DoModel(
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
