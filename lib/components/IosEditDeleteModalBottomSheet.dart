import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../controller/ContactController.dart';
import '../controller/ModalBottomSheetController.dart';
import '../controller/themeController.dart';
import '../modals/ContactModal.dart';
import '../utils/ColorUtils.dart';

void iosEditDeleteContactSheet(
    {required BuildContext context,
    required ContactModal cm,
    required int index}) {
  TextEditingController nameController = TextEditingController(text: cm.name);
  TextEditingController phoneController = TextEditingController(text: cm.phone);
  TextEditingController chatController = TextEditingController(text: cm.chat);

  File? image;

  showCupertinoModalPopup(
    context: context,
    builder: (context) {
      return Container(
        height: 300,
        padding: const EdgeInsets.only(right: 18, top: 0, bottom: 18, left: 18),
        decoration: BoxDecoration(
          color: Provider.of<ThemeController>(context, listen: false).getTheme
              ? Color(0xff1B1B1B)
              : CupertinoColors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            topLeft: Radius.circular(10),
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.primaries[index],
              foregroundImage:
                  (cm.image != "") ? FileImage(File(cm.image)) : null,
              child: (cm.image == "")
                  ? Text(
                      "${cm.name[0].toUpperCase()}",
                      style: const TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )
                  : null,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "${cm.name}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "${cm.chat}",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CupertinoButton(
                  child: Text(
                    "Edit",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                        title: Text("Edit Contact"),
                        content: Column(
                          children: [
                            Divider(
                              thickness: 0.3,
                              color: CupertinoColors.systemGrey,
                            ),
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.primaries[index],
                              foregroundImage: (cm.image != "")
                                  ? FileImage(File(cm.image))
                                  : null,
                              child: (cm.image == "")
                                  ? Text(
                                      "${cm.name[0].toUpperCase()}",
                                      style: const TextStyle(
                                          fontSize: 50,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )
                                  : null,
                            ),
                            Consumer<ContactController>(
                                builder: (context, p, _) {
                              return CupertinoButton(
                                child: Text("Edit Photo"),
                                onPressed: () async {
                                  print("photo : ${cm.image}");
                                  ImagePicker picker = ImagePicker();
                                  XFile? file;
                                  showCupertinoDialog(
                                    context: context,
                                    builder: (context) => CupertinoAlertDialog(
                                      title: Text("Pick Image"),
                                      content: Text(
                                          "Choose the sourse for your image"),
                                      actions: [
                                        CupertinoButton(
                                          onPressed: () async {
                                            print("onpressed...");
                                            file = await picker.pickImage(
                                                source: ImageSource.camera);
                                            if (file != null) {
                                              print("pic is not null");
                                              image = File(file!.path);
                                              cm.image = file!.path;
                                              p.setimagePath(
                                                  imagePath: file!.path);
                                              print(
                                                  "edited pic: ${file!.path}");
                                            }
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            "Camera",
                                          ),
                                        ),
                                        CupertinoButton(
                                          onPressed: () async {
                                            file = await picker.pickImage(
                                                source: ImageSource.gallery);
                                            if (file != null) {
                                              image = File(file!.path);
                                              cm.image = file!.path;
                                              p.setimagePath(
                                                  imagePath: file!.path);
                                            }
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Gallary"),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            }),
                            const SizedBox(
                              height: 10,
                            ),
                            CupertinoTextFormFieldRow(
                              controller: nameController,
                              placeholder: " Name",
                              prefix: Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.person_solid,
                                    color: CupertinoColors.systemGrey,
                                  ),
                                  SizedBox(
                                    width: 16,
                                  )
                                ],
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    width: 1,
                                    color: CupertinoColors.systemGrey),
                              ),
                              keyboardType: TextInputType.name,
                            ),
                            CupertinoTextFormFieldRow(
                              controller: phoneController,
                              placeholder: " Phone",
                              prefix: Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.phone_fill,
                                    color: CupertinoColors.systemGrey,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    width: 1,
                                    color: CupertinoColors.systemGrey),
                              ),
                              keyboardType: TextInputType.phone,
                            ),
                            CupertinoTextFormFieldRow(
                              controller: chatController,
                              placeholder: " Chat",
                              prefix: Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.chat_bubble_2_fill,
                                    color: CupertinoColors.systemGrey,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    width: 1,
                                    color: CupertinoColors.systemGrey),
                              ),
                              keyboardType: TextInputType.name,
                            ),
                          ],
                        ),
                        actions: [
                          Consumer<ContactController>(
                            builder: (context, p, _) {
                              return CupertinoButton(
                                child: Text("EDIT"),
                                onPressed: () {
                                  cm.name = nameController.text;
                                  cm.phone = phoneController.text;
                                  cm.chat = chatController.text;

                                  p.editContact(contact: cm, index: index);
                                  p.clearLocalData();
                                  Navigator.of(context).pop();
                                },
                              );
                            },
                          ),
                          CupertinoButton(
                              child: Text("CANCEL"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              }),
                        ],
                      ),
                    );
                  },
                ),
                CupertinoButton(
                  child: Text(
                    "Delete",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  onPressed: () {
                    Provider.of<ContactController>(context, listen: false)
                        .deleteContact(index: index);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
