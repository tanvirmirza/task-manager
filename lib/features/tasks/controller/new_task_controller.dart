import 'package:get/get.dart';
import 'package:task_manager/core/api/repository/network_caller_dio.dart';
import 'package:task_manager/core/api/model/api_response.dart';
import 'package:task_manager/core/constants/app_urls.dart';
import 'package:task_manager/core/utils/shared_prefarenses_helper.dart';
import 'package:task_manager/features/tasks/model/new_task_model.dart';

class NewTaskController extends GetxController {
  final SharedPreferencesHelper _prefs = SharedPreferencesHelper();

  /// Observable states
  final RxBool isLoading = false.obs;
  final RxList<DataItem> newTaskList = <DataItem>[].obs;
  final RxString errorMessage = ''.obs;

  /// Fetch new tasks from API
  Future<void> fetchNewTasks() async {
    try {
      isLoading.value = true;

      final String? token = _prefs.getString('token');
      if (token == null) {
        errorMessage.value = 'Token not found';
        return;
      }

      final response = await NetworkCaller.getRequest(
        AppUrls.newTaskListUrl,
        token: token,
      );

      if (response.isSuccess && response.responseData != null) {
        final data = response.responseData['data'];

        if (data is List) {
          final parsed = ResponseModel.fromJson(response.responseData);
          newTaskList.assignAll(parsed.data);
          errorMessage.value = '';
          print("✅ New tasks loaded: ${newTaskList.length}");
        } else {
          errorMessage.value = 'Invalid data format received.';
        }
      } else {
        errorMessage.value = response.errorMessage ?? 'Failed to load new tasks.';
      }
    } catch (e) {
      errorMessage.value = 'Unexpected error: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
