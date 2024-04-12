import 'package:get/get.dart';
import 'package:schooll/services/utils/helpers/network.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
  }
}
