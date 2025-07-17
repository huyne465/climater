import 'package:climater/core/error/failures.dart';

abstract class UseCase<Type, Params> {
  ResultFuture<Type> call(Params params);
}

abstract class UseCaseWithoutParams<Type> {
  ResultFuture<Type> call();
}

class NoParams {
  const NoParams();
}
