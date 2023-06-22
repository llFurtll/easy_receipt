import '../error/failures.dart';

abstract class UseCase<R, P> {
  Future<(Failure?, R)> call(P params);
}