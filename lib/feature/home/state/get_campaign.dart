import 'package:borigarn/core/datasource/home_datasource.dart';
import 'package:borigarn/feature/home/models/campaign_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'get_campaign.g.dart';

@riverpod
Future<List<CampaignModel>> getCampaigns(GetCampaignsRef ref) async {
  return ref.watch(homeDatasourceProvider).getCampaign();
}
