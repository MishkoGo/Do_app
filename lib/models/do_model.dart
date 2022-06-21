import 'package:hive/hive.dart';
import 'do_model.g.dart';

@HiveType(typeId: 1)
class DoModel {
  @HiveField(0)
  final String task;

  DoModel({
     this.task,
  });
}
