import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UseImagePicker extends StatefulWidget {
  final void Function(File image) onImagePicker;
  const UseImagePicker({Key? key, required this.onImagePicker})
      : super(key: key);

  @override
  State<UseImagePicker> createState() => _UseImagePickerState();
}

class _UseImagePickerState extends State<UseImagePicker> {
  File? _image;

  Future<void> _imagePicker() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
      widget.onImagePicker(_image!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey,
              backgroundImage: _image != null ? FileImage(_image!) : null,
            ),
            Positioned(
              right: 0,
              left: 62,
              top: 30,
              bottom: 0,
              child: GestureDetector(
                child: const Icon(
                  Icons.image_sharp,
                  color: Colors.blue,
                ),
                onTap: () {
                  _imagePicker();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
