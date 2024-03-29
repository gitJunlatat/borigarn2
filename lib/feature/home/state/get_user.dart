import 'package:borigarn/core/datasource/authen_datasource.dart';
import 'package:borigarn/core/prefs/prefs.dart';
import 'package:borigarn/feature/authen/models/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_user.g.dart';

@riverpod
Future<UserModel> getUser(GetUserRef ref) async {
  if(SharedPrefs().getUserId == null) { throw 'user id not found';}
  return ref.watch(authenDatasourceProvider).getUser(SharedPrefs().getUserId!);
}
