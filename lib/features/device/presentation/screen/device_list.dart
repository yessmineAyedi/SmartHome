import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:turkeysh_smart_home/core/resource/data_state.dart';
import 'package:turkeysh_smart_home/core/widget/question_dialog.dart';
import 'package:turkeysh_smart_home/features/device/presentation/controller/device_controller.dart';
import 'package:turkeysh_smart_home/features/home/domain/entity/room_entity.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/images.dart';
import '../../../../core/constants/routes.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/constants/utils.dart';
import '../../../../core/widget/custom_app_bar.dart';
import '../../../device/presentation/screen/one_time_devices.dart';
import '../widget/devices/relay_one_time.dart';
import '../widget/devices/sensors_widget.dart';

class DeviceListScreen extends StatelessWidget {
  DeviceListScreen({required this.room, Key? key}) : super(key: key);

  final RoomEntity room;
  final _controller = Get.find<DeviceController>();
  final offlineMode = GetStorage().read(AppUtils.offlineMode) ?? false;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      floatingActionButton: !offlineMode ? FloatingActionButton(
        onPressed: () {
          Get.toNamed(PagesRoutes.createDevice);
        },
        backgroundColor: CustomColors.foregroundColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ) : const SizedBox(),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: CustomAppBar(
        height: width > 600 ? 150 : 150,
        titleWidget: Text(
          room.name ?? '',
          style: AppStyles.appbarTitleStyle,
        ),
      ),
      body: SafeArea(child: Obx(() {
        return _controller.isDeviceLoading.value
            ? Center(
                child: LoadingAnimationWidget.beat(color: CustomColors.foregroundColor, size: 35),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Center(
                  child: _controller.deviceList.isEmpty
                      ? Lottie.asset(Images.empty, width: MediaQuery.sizeOf(context).width / 2)
                      : CustomScrollView(slivers: [
                          SliverToBoxAdapter(
                              child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: TextButton(
                                onPressed: () {
                                  _controller.filterDevicesBasedOnOneTime();
                                  Get.to(OneTimeDeviceScreen());
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.grid_view_outlined,
                                      color: CustomColors.foregroundColor,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    const Text(
                                      'مشاهده کلید ها',
                                      style: TextStyle(fontSize: 16),
                                    )
                                  ],
                                )),
                          )),
                          SliverList.builder(
                              itemBuilder: (BuildContext context, int index) {
                                if (_controller.deviceList[index].deviceType == '0') {
                                  return RelayOneTimeWidget(
                                    nodeId: _controller.deviceList[index].nodeProject?.uniqueId,
                                    boardUniqueId: _controller.deviceList[index].projectBoard?.uniqueId,
                                    title: _controller.deviceList[index].name,
                                    onLongPress: () {
                                      questionDialog(
                                          title: 'Delete equipment',
                                          question: 'Do you want to delete this equipment?',
                                          onYesClicked: () {
                                            _controller.deleteDevice(_controller.deviceList[index].id!).then((value) {
                                              if (value is DataSuccess) {
                                                Get.back();
                                                const CustomSnackBar.success(message: 'Equipment successfully deleted!');
                                              } else {
                                                const CustomSnackBar.error(message: 'Error in sending data');
                                              }
                                            });
                                          });
                                    },
                                  );
                                } else {
                                  return SensorWidget(
                                    title: _controller.deviceList[index].name,
                                    type: _controller.deviceList[index].deviceType.toString(),
                                    onLongPress: () {
                                      questionDialog(
                                          title: 'Delete equipment',
                                          question: 'Do you want to delete this equipment?',
                                          onYesClicked: () {
                                            _controller.deleteDevice(_controller.deviceList[index].id!).then((value) {
                                              if (value is DataSuccess) {
                                                Get.back();
                                                const CustomSnackBar.success(message: 'Equipment successfully deleted!');
                                              } else {
                                                const CustomSnackBar.error(message: 'Error in sending data');
                                              }
                                            });
                                          });
                                    },
                                  );
                                }
                              },
                              itemCount: _controller.deviceList.length),
                        ]),
                ),
              );
      })),
    );
  }
}
