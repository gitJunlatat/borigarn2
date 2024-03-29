import 'dart:async';

import 'package:borigarn/core/models/location_model.dart';
import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:borigarn/core/widgets/AppTextField.dart';
import 'package:borigarn/core/widgets/ButtonWidget.dart';
import 'package:borigarn/core/widgets/main_app_bar.dart';
import 'package:borigarn/feature/location/controller/location_controller.dart';
import 'package:borigarn/feature/location/models/payload/select_location.dart';
import 'package:borigarn/feature/location/widget/switch_view.dart';
import 'package:borigarn/gen/assets.gen.dart';
import 'package:borigarn/global/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:gap/gap.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:map_picker/map_picker.dart';

class EditLocationScreen extends StatefulHookConsumerWidget {
  final LocationModel? currentLocation;

  const EditLocationScreen({super.key, required this.currentLocation});

  @override
  ConsumerState<EditLocationScreen> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<EditLocationScreen> {
  final _controller = Completer<GoogleMapController>();
  MapPickerController mapPickerController = MapPickerController();
  var placeNameController = TextEditingController();
  var addressController = TextEditingController();
  var landMarkController = TextEditingController();

  final FocusNode _placeNameFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();
  final FocusNode _landmarkFocus = FocusNode();

  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(13.72917, 100.52389),
    zoom: 14,
  );

  @override
  void initState() {
    super.initState();

    if (widget.currentLocation != null) {
      placeNameController.text = widget.currentLocation?.name ?? '';
      addressController.text = widget.currentLocation?.address ?? '';
      landMarkController.text = widget.currentLocation?.customerData ?? '';
    }
    if (widget.currentLocation != null) {
      cameraPosition = CameraPosition(
        target: LatLng(double.parse(widget.currentLocation?.latitude ?? '13.72917'), double.parse(widget.currentLocation?.longitude ?? '100.52389')),
        zoom: 14,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final _isFocus = useState<bool>(false);

    _placeNameFocus.addListener(() {
      if (_placeNameFocus.hasFocus) {
        _isFocus.value = true;
      } else {
        _isFocus.value = false;
      }
    });
    _addressFocus.addListener(() {
      if (_addressFocus.hasFocus) {
        _isFocus.value = true;
      } else {
        _isFocus.value = false;
      }
    });
    _landmarkFocus.addListener(() {
      if (_landmarkFocus.hasFocus) {
        _isFocus.value = true;
      } else {
        _isFocus.value = false;
      }
    });

    var selectLocation = useState<SelectLocation?>(null);

    return Container(
      color: context.appColors.light,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: context.appColors.light,
          resizeToAvoidBottomInset: true,
          bottomNavigationBar: Container(
            padding: const EdgeInsets.only(bottom: 20, top: 10, left: 16, right: 16),
            child: ButtonWidget(
              onPressed: () {
                final data = selectLocation.value;
                data?.address = addressController.text;
                data?.placeName = placeNameController.text;
                data?.landmark = landMarkController.text;
                if(widget.currentLocation == null) {
                  ref.read(locationControllerProvider).createLocation(data!);
                }else {
                  ref.read(locationControllerProvider).updateLocation(widget.currentLocation, data!);
                }
              },
              text: context.tr(LocaleKeys.confirm),
              height: 50,
              radius: 12,
              backgroundColor: context.appColors.primary,
              textColor: Colors.white,
            ),
          ),
          appBar: MainAppBar(
            isCenterTitle: true,
            title: context.tr(LocaleKeys.location),
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: 0.5.sh,
                    ),
                    Container(
                      color: Colors.white,
                      child: ListView.custom(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          childrenDelegate: SliverChildListDelegate([
                            const Gap(12),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                      child: Text(
                                    context.tr(LocaleKeys.setDefault),
                                    style: context.textTheme.bodyMedium?.apply(color: context.appColors.title),
                                  )),
                                  SwitchView(
                                    value: selectLocation.value?.isDefault ?? false,
                                    onChanged: (bool value) {
                                      selectLocation.value?.isDefault = value;
                                    },
                                  )
                                ],
                              ),
                            ),
                            const Gap(12),
                            Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: AppTextField(
                                  focusNode: _placeNameFocus,
                                  controller: placeNameController,
                                  hintText: context.tr(LocaleKeys.placeName),
                                  maxLine: 1,
                                )),
                            const Gap(20),
                            Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: AppTextField(
                                  focusNode: _addressFocus,
                                  controller: addressController,
                                  hintText: context.tr(LocaleKeys.address),
                                  maxLine: 1,
                                )),
                            const Gap(20),
                            Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: AppTextField(
                                  focusNode: _landmarkFocus,
                                  controller: landMarkController,
                                  hintText: context.tr(LocaleKeys.landmark),
                                  maxLine: 1,
                                )),
                            const Gap(20),
                          ])),
                    )
                  ],
                ),
              ),
              HookConsumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  final isFocus = useListenable(_isFocus).value;
                  return SizedBox(
                    height: isFocus ? 0.3.sh : 0.5.sh,
                    width: 1.0.sw,
                    child: MapPicker(
                      // pass icon widget
                      iconWidget: MyAssets.booking.locationIcon.svg(width: 40, height: 40),
                      //add map picker controller
                      mapPickerController: mapPickerController,
                      child: GoogleMap(
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        zoomControlsEnabled: true,
                        mapType: MapType.normal,
                        //  camera position
                        initialCameraPosition: cameraPosition,
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                        onCameraMoveStarted: () {
                          // notify map is moving
                          mapPickerController.mapMoving!();
                          // textController.text = "checking ...";
                        },
                        onCameraMove: (cameraPosition) {
                          this.cameraPosition = cameraPosition;
                        },
                        onCameraIdle: () async {
                          // notify map stopped moving
                          mapPickerController.mapFinishedMoving!();
                          //get address name from camera position
                          List<Placemark> placemarks = await placemarkFromCoordinates(
                            cameraPosition.target.latitude,
                            cameraPosition.target.longitude,
                          );

                          final lat = cameraPosition.target.latitude;
                          final long = cameraPosition.target.longitude;

                          final placemark = placemarks.first;
                          final address = '${placemark.name}, ${placemark.administrativeArea}, ${placemark.country}';
                          addressController.text = address;
                          selectLocation.value =
                              SelectLocation(lat: lat, long: long, placeName: '', address: address, administrativeArea: placemark.administrativeArea ?? '', isDefault: true);
                        },
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );

    // SingleChildScrollView(
    //   child: Column(
    //     children: [
    //       SizedBox(
    //         width: 1.sw, height: 1.sh,
    //         child: TestMap(),
    //       ),

    //     ],
    //   ),
    // ),
  }
}
