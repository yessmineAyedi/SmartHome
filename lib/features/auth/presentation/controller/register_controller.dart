import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:turkeysh_smart_home/core/constants/routes.dart';
import 'package:turkeysh_smart_home/core/resource/error_handler.dart';
import '../../../../core/constants/utils.dart';
import '../../../../core/resource/internet_controller.dart';
import '../../../../core/resource/data_state.dart';
import '../../domain/entity/user_entity.dart';
import '../../domain/usecase/auth_usecase.dart';


class RegisterController extends GetxController {
  var isLoading = false.obs;
  var isRegisterLoading = false.obs;
  late TextEditingController username;
  late TextEditingController password;
  late TextEditingController confirmPassword;
  late TextEditingController mobileNumber;
  late TextEditingController email;
  late TextEditingController birthDate;
  late TextEditingController loginUsername;
  late TextEditingController loginPassword;

  final AuthUseCase _usecase;

  RegisterController(this._usecase);

  @override
  onInit(){
    super.onInit();
    username = TextEditingController();
    password = TextEditingController();
    confirmPassword = TextEditingController();
    mobileNumber = TextEditingController();
    email = TextEditingController();
    birthDate = TextEditingController();
    loginUsername = TextEditingController();
    loginPassword = TextEditingController();
  }

  Future<DataState<String>> signUpUser() async {
    isRegisterLoading.value = true;
    if (Get.find<InternetController>().isConnected.value) {
      if (username.text.isEmpty ||
          password.text.isEmpty ||
          confirmPassword.text.isEmpty ||
          mobileNumber.text.isEmpty) {
        isRegisterLoading.value = false;
        return const DataFailed('Please enter all the information');
      }
        if (password.text == confirmPassword.text) {
          if (mobileNumber.text.length == 11 &&
              mobileNumber.text.startsWith('09')) {

            var response = await _usecase.registerUserUsecase(
                username.text, password.text, mobileNumber.text, email.text, birthDate.text);
            if (response is DataSuccess) {
              Get.offAllNamed(PagesRoutes.login);
              isRegisterLoading.value = false;
              username.text = '';
              password.text = '';
              confirmPassword.text = '';
              email.text = '';
              mobileNumber.text = '';
              birthDate.text = '';
              return const DataSuccess('Information saved successfully');
            } else {
              isRegisterLoading.value = false;
              return DataFailed(errorConvertor(response.error ?? 'Error in sending data'));
            }
          } else {
            isRegisterLoading.value = false;
            return const DataFailed('Please enter the mobile number in the correct format');
          }
        } else {
          isRegisterLoading.value = false;
          return const DataFailed('The password does not match the confirmation password!');
        }

    } else {
      return const DataFailed('Please ensure your internet connection!');
    }
  }

  Future<DataState<UserEntity>> loginUser() async {
    isLoading.value = true;
    if (Get.find<InternetController>().isConnected.value) {
      if(loginUsername.text.isNotEmpty && loginPassword.text.isNotEmpty){

        DataState<UserEntity> dataState =
        await _usecase.loginUser(loginUsername.text, loginPassword.text);
        if (dataState is DataSuccess) {
          if (dataState.data != null) {
            Get.offAllNamed(PagesRoutes.project);
            GetStorage().write(AppUtils.userTokenAccess, dataState.data!.access);
            GetStorage().write(AppUtils.userTokenRefresh, dataState.data!.refresh);
            GetStorage().write(AppUtils.username, loginUsername.text);

            isLoading.value = false;
            return DataSuccess(dataState.data);
          }
          return const DataFailed('Error in retrieving data');
        } else {
          isLoading.value = false;
          return DataFailed(errorConvertor(dataState.error!));
        }
      }else{
        isLoading.value = false;
        return const DataFailed('Please fill in the empty fields first');
      }
    }else{
      isLoading.value = false;
      return const DataFailed('Please ensure your internet connection');
    }

  }


  @override
  void dispose() {
    username.dispose();
    password.dispose();
    confirmPassword.dispose();
    mobileNumber.dispose();
    super.dispose();
  }
}
