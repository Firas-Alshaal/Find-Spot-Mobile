import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lost_find_tracker/core/utils/theme_color.dart';

Future<dynamic> getImageFromGallery() async {
  final XFile? selectedImage =
      await ImagePicker().pickImage(source: ImageSource.gallery);
  if (selectedImage != null) {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: selectedImage.path,
      maxWidth: 700,
      maxHeight: 700,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      aspectRatioPresets: [CropAspectRatioPreset.square],
      uiSettings: [
        AndroidUiSettings(
          toolbarWidgetColor: ColorsFave.whiteColor,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
          toolbarColor: ColorsFave.primaryColor,
          toolbarTitle: "Cropper",
          showCropGrid: true,
          statusBarColor: ColorsFave.primaryColor,
          backgroundColor: ColorsFave.blackColor,
        ),
        IOSUiSettings(title: "Cropper")
      ],
    );
    if (croppedFile != null) {
      return selectedImage;
    }
  }
}
