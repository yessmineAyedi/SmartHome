import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:turkeysh_smart_home/core/constants/utils.dart';
import 'package:turkeysh_smart_home/features/project/data/model/request/project_request.dart';
import 'package:turkeysh_smart_home/features/project/domain/usecase/project_usecase.dart';

import '../../../../core/resource/internet_controller.dart';
import '../../../../core/resource/data_state.dart';
import '../../domain/entity/project_entity.dart';
import '../../domain/entity/prooject_result_entity.dart';

class ProjectController extends GetxController {
  final ProjectUseCase _useCase;

  ProjectController(this._useCase);

  late TextEditingController projectName;
  late TextEditingController projectAddress;
  late Map<String, dynamic> request;
  RxList<ProjectResultsEntity> projectList = RxList();

  var isLoading = false.obs;
  var isGetProjectsLoading = false.obs;
  var isDeleteLoading = false.obs;
  bool projectEditMode = false;
  int? projectId;

  @override
  void onInit() {
    projectName = TextEditingController();
    projectAddress = TextEditingController();
    getAllProjects();
    super.onInit();
  }

  Future<DataState<String>> createNewProject() async {
    isLoading.value = true;
    request = ProjectRequest(projectName.text, projectAddress.text).toJson();
    if (Get.find<InternetController>().isConnected.value) {
      if (projectName.text.isNotEmpty && projectAddress.text.isNotEmpty) {
        DataState dataState = await _useCase.addProject(request);
        if (dataState is DataSuccess) {
          if (dataState.data != null) {
            projectList.add(dataState.data);
            projectName.text = '';
            projectAddress.text = '';
            return const DataSuccess('Information has been successfully saved');
          } else {
            isLoading.value = false;
            return DataFailed(dataState.error ?? 'Error in sending information');
          }
        } else {
          isLoading.value = false;
          return DataFailed(dataState.error ?? 'Error in sending information');
        }
      } else {
        isLoading.value = false;
        return const DataFailed('Please enter all the information');
      }
    } else {
      isLoading.value = false;
      return const DataFailed('Please ensure your internet connection is stable');
    }
  }

  Future<void> getAllProjects() async {
    isGetProjectsLoading.value = true;
    bool offlineMode = GetStorage().read(AppUtils.offlineMode) ?? false;

    if (offlineMode) {
      DataState<List<ProjectResultsEntity>> localData = await _useCase.getLocalProject();
      if (localData is DataSuccess) {
        isGetProjectsLoading.value = false;
        projectList.value = localData.data ?? [];
      }
    } else {
      DataState<ProjectEntity> dataState = await _useCase.getAllProjects();
      if (dataState is DataSuccess) {
        if (dataState.data != null) {
          projectList.value = dataState.data?.results ?? [];
          await _useCase.deleteLocal();
          await _useCase.saveProjectToLocal(dataState.data!.results ?? []);
        }
        isGetProjectsLoading.value = false;
      } else {
        print(dataState.error);
      }
    }
  }

  Future<DataState<String>> updateProject(int id) async {
    isLoading.value = true;
    request = ProjectRequest(projectName.text, projectAddress.text).toJson();
    if (Get.find<InternetController>().isConnected.value) {
      if (projectName.text.isNotEmpty && projectAddress.text.isNotEmpty) {
        DataState dataState = await _useCase.updateProject(request, id);
        if (dataState is DataSuccess) {
          if (dataState.data != null) {
            getAllProjects();
            projectName.text = '';
            projectAddress.text = '';
            isLoading.value = false;
            return const DataSuccess('Information has been successfully saved');
          } else {
            isLoading.value = false;
            return DataFailed(dataState.error ?? 'Error in sending information');
          }
        } else {
          isLoading.value = false;
          return DataFailed(dataState.error ?? 'Error in sending information');
        }
      } else {
        isLoading.value = false;
        return const DataFailed('Please enter all the information');
      }
    } else {
      isLoading.value = false;
      return const DataFailed('Please ensure your internet connection is stable');
    }
  }

  Future<DataState<String>> deleteProject(int id) async {
    isDeleteLoading.value = true;
    if (Get.find<InternetController>().isConnected.value) {
      DataState dataState = await _useCase.deleteProjectById(id);
      if (dataState is DataSuccess) {
        getAllProjects();
        return const DataSuccess('The project has been successfully deleted');
      } else {
        isDeleteLoading.value = false;
        return DataFailed(dataState.error ?? 'Error in sending information');
      }
    } else {
      isDeleteLoading.value = false;
      return const DataFailed('Please check your internet connection');
    }
  }

  @override
  void dispose() {
    projectName.dispose();
    projectAddress.dispose();
    super.dispose();
  }
}
