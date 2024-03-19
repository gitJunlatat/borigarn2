
import 'package:borigarn/core/manager/network.dart';
import 'package:borigarn/feature/inbox/model/inbox_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../constant/constants.dart';

part 'inbox_datasource.g.dart';

@Riverpod(keepAlive: true)
InboxDatasource inboxDatasource(InboxDatasourceRef ref) {
  return InboxDatasourceImpl(ref.watch(networkManagerProvider));
}

abstract class InboxDatasource {
  Future<List<InboxModel>> getInbox();
}

class InboxDatasourceImpl implements InboxDatasource {
  final NetworkManager networkManager;

  InboxDatasourceImpl(this.networkManager);

  final String appBaseUrl = SERVICE_BASE_URL;


  @override
  Future<List<InboxModel>> getInbox() async {
    final response = await networkManager.get('/passport/inboxes', appBaseUrl: appBaseUrl, onlyData: false);
    final listData = response['items'] as List;
    return listData.map((e) => InboxModel.fromJson(e)).toList().reversed.toList();

  }
}
