class Todo {
  String details;
  DateTime createDateTime, updateDateTime;
  String status;
  Todo(
      {required this.details,
      required this.createDateTime,
      required this.updateDateTime,
      this.status="panding"});
}
