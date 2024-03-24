import 'package:borigarn/core/manager/network.dart';
import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:borigarn/core/widgets/app_safe_area.dart';
import 'package:borigarn/core/widgets/main_app_bar.dart';
import 'package:borigarn/core/widgets/shimmer_list_loading.dart';
import 'package:borigarn/feature/home/models/service_model.dart';
import 'package:borigarn/feature/home/state/get_service_detail.dart';
import 'package:borigarn/feature/home/views/app_webview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:html/parser.dart' as htmlparser;
import 'package:html/dom.dart' as dom;

class BookingInfoScreen extends ConsumerWidget {
  final Service service;
  const BookingInfoScreen({super.key, required this.service});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
   return ref.watch(getServiceDetailProvider("${service.id ?? 1}")).when(data: (data){
     dom.Document document = htmlparser.parse(data);

     return AppSafeArea(
        widget: Scaffold(
          backgroundColor: context.appColors.light,
          appBar: MainAppBar(title: service.nameEn ?? '', isCenterTitle: true,),
          body: WebViewExample(content: document.outerHtml),
        ),
      );
    }, error: (error, stack) {
      return Scaffold(
        appBar: MainAppBar(title: service.nameEn ?? '', isCenterTitle: true,),
        body: const ShimmerListLoading(count: 1,),
      );
    }, loading: () {
      return Scaffold(
        appBar: MainAppBar(title: service.nameEn ?? '', isCenterTitle: true,),
        body: const ShimmerListLoading(count: 1,),
      );
    });
  }
}


