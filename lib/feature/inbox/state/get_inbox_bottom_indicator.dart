import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_inbox_bottom_indicator.g.dart';

@riverpod
class GetInboxBottomIndicator extends _$GetInboxBottomIndicator{
  @override
  AsyncValue build() {
    return const AsyncData(null);
  }

  void showLoading() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      state = const AsyncLoading();
    });
  }

  void showError(dynamic error) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      state = AsyncError(error, StackTrace.empty);
    });

  }

  void hideLoading() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      state = const AsyncData(null);
    });
  }
}
