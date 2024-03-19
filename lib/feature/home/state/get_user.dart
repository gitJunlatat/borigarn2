import 'package:borigarn/core/datasource/authen_datasource.dart';
import 'package:borigarn/feature/authen/models/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_user.g.dart';

@riverpod
Future<UserModel> getUser(GetUserRef ref) async {
  return ref.watch(authenDatasourceProvider).getUser('244');
}
