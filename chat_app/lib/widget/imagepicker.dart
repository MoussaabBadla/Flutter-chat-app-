import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class userimage extends StatefulWidget {
  const userimage({required this.pickfn, });
  final void Function(File pickedImage) pickfn;

  @override
  State<userimage> createState() => _userimageState();
}

class _userimageState extends State<userimage> {
  File? _pickedImage;
  final ImagePicker _picker = ImagePicker();
  Future imagepicker(ImageSource src) async {
    final pickedimage = await _picker.pickImage(
      source: src,
    );
    if (pickedimage == null) return;
    final File imageTemp = File(pickedimage.path);
    setState(() {
      _pickedImage = imageTemp;
    });
    widget.pickfn(_pickedImage!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: const Color.fromARGB(255, 225, 231, 236),
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage!) : null,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton.icon(
              onPressed: () => imagepicker(ImageSource.gallery),
              label: const Text(
                'Add an imege',
                style: TextStyle(color: const Color(0xFF837DFF)),
              ),
              icon: const Icon(Icons.add, color: Color(0xFF837DFF)),
            )
          ],
        )
      ],
    );
  }
}
