import 'package:borigarn/feature/authen/models/payload/sso_credential.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'sso_payload.g.dart';
@Riverpod(keepAlive: true)
class SSOPayload extends _$SSOPayload {
  @override
  SSOCredential? build() {
    return null;
  }

  void setPayload(SSOCredential sso) {
    state = sso;
  }


}
