import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_convertor_application_project/controller/themeController.dart';
import 'package:provider/provider.dart';

import '../controller/ContactController.dart';

class IosAddPersonPage extends StatelessWidget {
  IosAddPersonPage({super.key});

  File? image;
  TextEditingController nameController =
      TextEditingController(text: "Enter Name");
  TextEditingController phoneController =
      TextEditingController(text: "Enter Contact");
  TextEditingController chatController =
      TextEditingController(text: "Chat Conversation");

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Consumer<ContactController>(builder: (context, p, _) {
                return Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    image: (p.imagePath != "")
                        ? DecorationImage(
                            image: FileImage(File(p.imagePath)),
                            fit: BoxFit.cover,
                          )
                        : null,
                    shape: BoxShape.circle,
                    color: Color(0xff9397A3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5,
                        offset: Offset(2, 2),
                      )
                    ],
                  ),
                  child: (p.imagePath == "")
                      ? Icon(
                          CupertinoIcons.person_solid,
                          color: Colors.white,
                          size: 120,
                        )
                      : null,
                );
              }),
              SizedBox(
                height: 5,
              ),
              Consumer<ContactController>(builder: (context, p, _) {
                return TextButton(
                  onPressed: () async {
                    ImagePicker picker = ImagePicker();
                    XFile? file;

                    showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                        title: Text("Pick Image"),
                        content: Text("Choose the sourse for your image"),
                        actions: [
                          CupertinoButton(
                            child: Text("Camera"),
                            onPressed: () async {
                              file = await picker.pickImage(
                                  source: ImageSource.camera);

                              if (file != null) {
                                image = File(file!.path);
                                p.setimagePath(imagePath: file!.path);
                                // p.imagePath = file!.path;
                              }
                              Navigator.of(context).pop();
                            },
                          ),
                          CupertinoButton(
                            child: Text("Gallary"),
                            onPressed: () async {
                              file = await picker.pickImage(
                                  source: ImageSource.gallery);

                              if (file != null) {
                                image = File(file!.path);
                                p.setimagePath(imagePath: file!.path);
                                // p.imagePath = file!.path;
                              }

                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      ),
                    );
                  },
                  child: Text(
                    "Add Photo",
                    style: TextStyle(color: Colors.blueAccent, fontSize: 18),
                  ),
                );
              }),
              SizedBox(
                height: 30,
              ),
              Form(
                key: formkey,
                child: Column(
                  children: [
                    CupertinoTextField(
                      controller: nameController,
                      // padding: EdgeInsets.all(5),

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            width: 1, color: CupertinoColors.systemGrey),
                      ),
                      keyboardType: TextInputType.name,
                      maxLines: 2,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
