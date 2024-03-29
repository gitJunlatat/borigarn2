import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_name_state.g.dart';

@riverpod
class UsernameState extends _$UsernameState {
  @override
   String? build() {
    return null;
  }

  void setUsername(String username) {
    state = username;
  }
}
