import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class CompleteProfile extends StatefulWidget {
  const CompleteProfile({super.key});

  @override
  _CompleteProfileState createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  File? imageFile;
  TextEditingController fullNameController = TextEditingController();

  void selectImage(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      cropImage(pickedFile);
    }
  }

  void cropImage(XFile file) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: file.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      compressQuality: 20,
    );

    if (croppedImage != null) {
      setState(() {
        imageFile = File(croppedImage.path);
      });
    }
  }

  void showPhotoOptions() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Upload Profile Picture"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  selectImage(ImageSource.gallery);
                },
                leading: const Icon(Icons.photo_album),
                title: const Text("Select from Gallery"),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  selectImage(ImageSource.camera);
                },
                leading: const Icon(Icons.camera_alt),
                title: const Text("Take a photo"),
              ),
            ],
          ),
        );
      },
    );
  }

  void checkValues() {
    String fullname = fullNameController.text.trim();
    if (fullname == "" || imageFile == null) {
      log("Please fill all the fields");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Please fill all fields and upload a picture")),
      );
    } else {
      log("Uploading data...");
      uploadData();
    }
  }

  void uploadData() {
    log("Image and data 'uploaded'!");
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) {
        return const Scaffold(
          body:
              Center(child: Text("Profile Completed - Home Page Placeholder")),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text("Complete Profile"),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: ListView(
            children: [
              const SizedBox(height: 20),
              CupertinoButton(
                onPressed: showPhotoOptions,
                padding: const EdgeInsets.all(0),
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage:
                      (imageFile != null) ? FileImage(imageFile!) : null,
                  child: (imageFile == null)
                      ? const Icon(Icons.person, size: 60)
                      : null,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: fullNameController,
                decoration: const InputDecoration(
                  labelText: "Full Name",
                ),
              ),
              const SizedBox(height: 20),
              CupertinoButton(
                onPressed: checkValues,
                color: Theme.of(context).colorScheme.secondary,
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
