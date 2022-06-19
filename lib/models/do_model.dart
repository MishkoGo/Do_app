import 'package:hive/hive.dart';
import 'do_model.g.dart';

@HiveType(typeId: 0)
class DoModel extends HiveObject{
  @HiveField(1)
  String task;

  DoModel({
     this.task = '',
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
    task,
  ];

  static List<DoModel> todos = [
    DoModel(task: 'task',),
  ];
}
