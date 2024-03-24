import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageContainer extends StatelessWidget {
  final XFile selectedImage;

  const ImageContainer({Key? key, required this.selectedImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.25,
      decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: FileImage(
              File(selectedImage.path),
            ),
          ),
          borderRadius: BorderRadius.circular(10)),
    );
  }
}


class NoImageContainer extends StatelessWidget {
  const NoImageContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height *
          0.25,
      decoration: BoxDecoration(
          color:
          Colors.blue.shade50.withOpacity(.3),
          borderRadius:
          BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment:
        MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.folder_open,
            color: Colors.blue,
            size: 60,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Select your image',
            style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade400),
          ),
        ],
      ),
    );
  }
}

