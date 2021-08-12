import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> storagePermission() async {
  if (GetPlatform.isIOS || GetPlatform.isAndroid) {
    await Permission.storage.request();
    return await Permission.storage.isGranted;
  } else
    return true;
}

Future<bool> isGrantedStoragePer() async => await Permission.storage.isGranted;

// Future<bool> cameraPermission() async {
//   if (UniversalPlatform.isIOS || UniversalPlatform.isAndroid) {
//     await Permission.camera.request();
//     return await Permission.camera.isGranted;
//   } else {
//     return true;
//   }
// }
