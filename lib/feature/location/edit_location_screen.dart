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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:map_picker/map_picker.dart';

class EditLocationScreen extends StatefulHookConsumerWidget {
  final LocationModel? currentLocation;

  const EditLocationScreen({super.key, this.currentLocation});

  @override
  ConsumerState<EditLocationScreen> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<EditLocationScreen> {
  final _controller = Completer<GoogleMapController>();
  MapPickerController mapPickerController = MapPickerController();

  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(13.72917, 100.52389),
    zoom: 14,
  );

  @override
  Widget build(BuildContext context) {
    var placeNameController = useTextEditingController();
    var addressController = useTextEditingController();
    var landMarkController = useTextEditingController();

    final _isFocus = useState<bool>(false);

    final FocusNode _placeNameFocus = useFocusNode();
    final FocusNode _addressFocus = useFocusNode();
    final FocusNode _landmarkFocus = useFocusNode();

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

    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 20, top: 10, left: 16, right: 16),
        child: ButtonWidget(
          onPressed: () {
            // SelectLocation(lat: null, long: null, placeName: '', address: '', isDefault: null)
            // if currentLocation
            final data = selectLocation.value;
            data?.address = addressController.text;
            data?.placeName = placeNameController.text;
            data?.landmark = landMarkController.text;
            ref.read(locationControllerProvider).createLocation(data!);
          },
          text: 'CONFIRM',
          height: 50,
          radius: 12,
          backgroundColor: context.appColors.primary,
          textColor: Colors.white,
        ),
      ),
      appBar: MainAppBar(
        isCenterTitle: true,
        title: 'Location',
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
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      childrenDelegate: SliverChildListDelegate([
                        const Gap(12),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                  child: Text(
                                'Use default value.',
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
                              hintText: "Place's name",
                              maxLine: 1,
                            )),
                        const Gap(20),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: AppTextField(
                              focusNode: _addressFocus,
                              controller: addressController,
                              hintText: "Address",
                              maxLine: 1,
                            )),
                        const Gap(20),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: AppTextField(
                              focusNode: _landmarkFocus,
                              controller: landMarkController,
                              hintText: "Landmark",
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
                      selectLocation.value = SelectLocation(lat: lat, long: long, placeName: '', address: address, administrativeArea: placemark.administrativeArea ?? '', isDefault: true);
                      // update the ui with the address
                      // textController.text = '${placemarks.first.name}, ${placemarks.first.administrativeArea}, ${placemarks.first.country}';
                    },
                  ),
                ),
              );
            },
          ),
        ],
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
