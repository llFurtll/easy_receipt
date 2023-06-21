abstract class Failure {
  final String message;
  
  Failure({
    required this.message
  });
}

class OperationFailure extends Failure {
  OperationFailure({required super.message});
}

class InsertFailure extends Failure {
  InsertFailure({required super.message});
}