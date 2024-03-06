import 'package:borigarn/core/datasource/home_datasource.dart';
import 'package:borigarn/feature/home/models/campaign_model.dart';
import 'package:borigarn/feature/home/models/service_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'get_services.g.dart';

@riverpod
Future<List<Service>> getServices(GetServicesRef ref) async {
  return ref.watch(homeDatasourceProvider).getServices();
}
