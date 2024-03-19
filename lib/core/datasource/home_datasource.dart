import 'dart:convert';

import 'package:borigarn/core/manager/network.dart';
import 'package:borigarn/feature/home/models/campaign_model.dart';
import 'package:borigarn/feature/home/models/service_model.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../constant/constants.dart';

part 'home_datasource.g.dart';

@Riverpod(keepAlive: true)
HomeDatasource homeDatasource(HomeDatasourceRef ref) {
  return HomeDatasourceImpl(ref.watch(networkManagerProvider));
}

abstract class HomeDatasource {

  Future<List<CampaignModel>> getCampaign();
  Future<List<Service>> getServices();

}

class HomeDatasourceImpl implements HomeDatasource {
  final NetworkManager networkManager;

  HomeDatasourceImpl(this.networkManager);

  final String appBaseUrl = CAMPAIGN_BASE_URL;
  final String serviceBaseUrl = SERVICE_BASE_URL;

  @override
  Future<List<CampaignModel>> getCampaign() async {
    final response = await networkManager.get('/passport/campaigns',
        appBaseUrl: appBaseUrl,
        onlyData: false);
    final listData = response['items'] as List;
    return listData.map((e) => CampaignModel.fromJson(e)).toList();
  }

  @override
  Future<List<Service>> getServices() async {
    final response = await networkManager.get('/passport/service/list',
        appBaseUrl: serviceBaseUrl,
        onlyData: false);
    final listData = response['items'] as List;
    return listData.map((e) => Service.fromJson(e)).toList();
    //
    //   var data = await rootBundle.loadString("assets/local/service.json");
    //   final listData = jsonDecode(data)['items'] as List;
    //   final  List<Service> asas =  listData.map((e) => Service.fromJson(e)).toList();
    //   log.e(asas);
    //   return asas;
    }

}
