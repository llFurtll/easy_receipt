class InsertException implements Exception {
  final String message;

  const InsertException(this.message); 
}

class OperationException implements Exception {
  final String message;

  const OperationException(this.message); 
}