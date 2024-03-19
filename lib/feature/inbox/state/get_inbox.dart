import 'package:borigarn/core/datasource/inbox_datasource.dart';
import 'package:borigarn/feature/inbox/model/inbox_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_inbox.g.dart';

@riverpod
Future<List<InboxModel>> getInbox(GetInboxRef ref) async {
  return ref.watch(inboxDatasourceProvider).getInbox();
}

// @riverpod
// class GetInbox extends _$GetInbox {
//   int _page = 0;
//   @override
//   FutureOr<List<int>> build() async {
//     ref.onDispose(() {
//       _page = 0;
//     });
//     // final List<int> reviews = await ref.watch(profileReviewRepositoryProvider).getReviewCompleted(page: _page);
//     return [1,2,3,4,5,6,7,8,9,0,10,11];
//   }
//
//   void checkRequestMoreData(int index) {
//     final itemPosition = index + 1;
//     final requestMoreData = itemPosition % 8 == 0 && index != 0;
//     final pageToRequest = itemPosition ~/ 8;
//
//     if (requestMoreData && pageToRequest > _page) {
//       _getMoreData();
//     }
//   }
//
//   Future<void> _getMoreData() async {
//     try {
//       ref.read(getInboxBottomIndicatorProvider.notifier).showLoading();
//       _page = _page + 1;
//       await Future.delayed(const Duration(seconds: 2));
//       if (_page >= 4) {
//         state = AsyncData([...state.value!,1,2,3,4,5]);
//       } else {
//         state = AsyncData([...state.value!,1,2,3,4,5,6,7,8]);
//       }
//       ref.read(getInboxBottomIndicatorProvider.notifier).hideLoading();
//     } catch (e) {
//       ref.read(getInboxBottomIndicatorProvider.notifier).showError(e);
//     }
//   }
// }
