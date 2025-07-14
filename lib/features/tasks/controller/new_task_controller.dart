import 'package:get/get.dart';
import 'package:task_manager/core/api/repository/network_caller_dio.dart';
import 'package:task_manager/core/api/model/api_response.dart';
import 'package:task_manager/core/constants/app_urls.dart';
import 'package:task_manager/core/utils/shared_prefarenses_helper.dart';
import 'package:task_manager/features/tasks/model/new_task_model.dart';

class TaskListController extends GetxController {
  final prefs = SharedPreferencesHelper();
  var isLoading = false.obs;
  var tasks = <DataItem>[].obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    fetchTasks();
    super.onInit();
  }

  Future<void> fetchTasks() async {
    String? token = prefs.getString('token');
    isLoading.value = true;

    final ResponseData response = await NetworkCaller.getRequest(
      AppUrls.newTaskListUrl,
      token: token,
    );

    isLoading.value = false;

    if (response.isSuccess && response.responseData != null) {
      try {
        print("Raw response: ${response.responseData}");

        // make sure it's a List inside 'data'
        if (response.responseData['data'] is List) {
          final responseModel = ResponseModel.fromJson(response.responseData);
          tasks.assignAll(responseModel.data);
          print("Tasks loaded: ${tasks.length}");
        } else {
          errorMessage.value = 'Invalid data format. Expected a list.';
        }
      } catch (e) {
        errorMessage.value = 'Failed to parse data.';
        print("Parsing error: $e");
      }
    } else {
      errorMessage.value = response.errorMessage ?? 'Failed to load tasks';
      print("Fetch error: ${errorMessage.value}");
    }
  }

}
