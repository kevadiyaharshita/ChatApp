import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_convertor_application_project/modals/ContactModal.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controller/ContactController.dart';
import '../controller/DateTimeController.dart';
import '../controller/ModalBottomSheetController.dart';
import '../controller/themeController.dart';
import '../utils/ColorUtils.dart';

void editDeleteContactSheet(
    {required BuildContext context,
    required ContactModal cm,
    required int index}) {
  TextEditingController nameController = TextEditingController(text: cm.name);
  TextEditingController phoneController = TextEditingController(text: cm.phone);
  TextEditingController chatController = TextEditingController(text: cm.chat);

  File? image;

  showModalBottomSheet(
    isScrollControlled: true,

    // isDismissible: false,
    context: context,
    builder: (context) => Container(
      height: (Provider.of<ModalSheetVisibility>(context).getVisibility)
          ? 785
          : 490,
      padding: const EdgeInsets.only(right: 18, top: 0, bottom: 18, left: 18),
      decoration: BoxDecoration(
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
            radius: 50,
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
          Consumer<ContactController>(builder: (context, p, _) {
            return TextButton.icon(
              onPressed: () async {
                ImagePicker picker = ImagePicker();
                XFile? file;
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Pick Image"),
                    content: Text("Choose the sourse for your image"),
                    actions: [
                      ElevatedButton.icon(
                        onPressed: () async {
                          file = await picker.pickImage(
                              source: ImageSource.camera);
                          if (file != null) {
                            image = File(file!.path);
                            cm.image = file!.path;
                            p.setimagePath(imagePath: file!.path);
                          }
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Colors.white),
                        label: Text(
                          "Camera",
                        ),
                        icon: Icon(Icons.camera_alt),
                      ),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Colors.white),
                        onPressed: () async {
                          file = await picker.pickImage(
                              source: ImageSource.gallery);
                          if (file != null) {
                            image = File(file!.path);
                            cm.image = file!.path;
                            p.setimagePath(imagePath: file!.path);
                          }
                          Navigator.of(context).pop();
                        },
                        label: Text("Gallary"),
                        icon: Icon(Icons.image),
                      ),
                    ],
                  ),
                );
              },
              icon: Icon(Icons.add_a_photo_outlined),
              label: Text("Edit Photot"),
            );
          }),
          const SizedBox(
            height: 10,
          ),
          Consumer<ThemeController>(builder: (context, pro, _) {
            return TextFormField(
              onTap: () {
                Provider.of<ModalSheetVisibility>(context, listen: false)
                    .changeVisibility(v: true);
              },
              onTapOutside: (event) =>
                  Provider.of<ModalSheetVisibility>(context, listen: false)
                      .changeVisibility(v: false),
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              controller: nameController,
              validator: (val) {
                if (val!.isEmpty) {
                  return "Please Enter Name !!";
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                hintText: "Enter Name",
                labelText: "Name",
                labelStyle: TextStyle(
                  fontSize: 20,
                  color: pro.getTheme ? Colors.white : Colors.black54,
                ),
                prefixIcon: Icon(
                  Icons.person,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    // width: 2,
                    color: pro.getTheme ? Colors.grey : Colors.black54,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: pro.getTheme ? Colors.grey : Colors.black54,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: pro.getTheme ? Colors.white : Colors.black54,
                  ),
                ),
              ),
              onChanged: (val) {},
            );
          }),
          SizedBox(
            height: 10,
          ),
          Consumer<ThemeController>(builder: (context, pro, _) {
            return TextFormField(
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              controller: phoneController,
              onTap: () {
                Provider.of<ModalSheetVisibility>(context, listen: false)
                    .changeVisibility(v: true);
              },
              onTapOutside: (event) =>
                  Provider.of<ModalSheetVisibility>(context, listen: false)
                      .changeVisibility(v: false),
              validator: (val) {
                if (val!.isEmpty) {
                  return "Please Enter Phone !!";
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                hintText: "Enter Phone",
                labelText: "Phone",
                labelStyle: TextStyle(
                  fontSize: 20,
                  color: pro.getTheme ? Colors.white : Colors.black54,
                ),
                prefixIcon: const Icon(
                  Icons.call,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    // width: 2,
                    color: pro.getTheme ? Colors.grey : Colors.black54,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: pro.getTheme ? Colors.grey : Colors.black54,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: pro.getTheme ? Colors.white : Colors.black54,
                  ),
                ),
              ),
              onChanged: (val) {},
            );
          }),
          const SizedBox(
            height: 10,
          ),
          Consumer<ThemeController>(builder: (context, pro, _) {
            return TextFormField(
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              controller: chatController,
              onTap: () {
                Provider.of<ModalSheetVisibility>(context, listen: false)
                    .changeVisibility(v: true);
              },
              onTapOutside: (event) =>
                  Provider.of<ModalSheetVisibility>(context, listen: false)
                      .changeVisibility(v: false),
              validator: (val) {
                if (val!.isEmpty) {
                  return "Please Enter Message !!";
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                hintText: "Chat Conversation ",
                labelText: "Chat",
                labelStyle: TextStyle(
                  fontSize: 20,
                  color: pro.getTheme ? Colors.white : Colors.black54,
                ),
                prefixIcon: const Icon(
                  Icons.chat,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    // width: 2,
                    color: pro.getTheme ? Colors.grey : Colors.black54,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: pro.getTheme ? Colors.grey : Colors.black54,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: pro.getTheme ? Colors.white : Colors.black54,
                  ),
                ),
              ),
              onChanged: (val) {},
            );
          }),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Consumer<ContactController>(
                builder: (context, p, _) {
                  return ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(130, 30),
                      backgroundColor: theme_Color1,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      cm.name = nameController.text;
                      cm.phone = phoneController.text;
                      cm.chat = chatController.text;

                      p.editContact(contact: cm, index: index);
                      p.clearLocalData();
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.edit),
                    label: Text(
                      "Edit",
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                },
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(130, 30),
                  backgroundColor: theme_Color1,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Provider.of<ContactController>(context, listen: false)
                      .deleteContact(index: index);
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.delete),
                label: const Text(
                  "Delete",
                  style: TextStyle(fontSize: 18),
                ),
              )
            ],
          )
        ],
      ),
    ),
  );
}

// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// GestureDetector(
// onTap: () async {
// DateTime? d = await showDatePicker(
// context: context,
// initialDatePickerMode: DatePickerMode.day,
// initialDate:
// Provider.of<DateTimeController>(context, listen: false)
//     .d ??
// DateTime.now(),
// firstDate: DateTime.now(),
// lastDate: DateTime.now().add(
// Duration(days: 100),
// ),
// );
//
// if (d != null) {
// Provider.of<DateTimeController>(context, listen: false)
//     .dateChanged(dateTime:d );
// }
// },
// child: Container(
// height: 60,
// width: 183,
// decoration: BoxDecoration(
// // color: Colors.red,
// borderRadius: BorderRadius.circular(10),
// border: Border.all(
// color: Provider.of<ThemeController>(context).getTheme
// ? Colors.grey.shade400
//     : Colors.black54)),
// child: Row(
// children: [
// Padding(
// padding: EdgeInsets.all(10),
// child: Icon(
// Icons.calendar_month_sharp,
// size: 25,
// ),
// ),
// SizedBox(
// width: 0,
// ),
// Consumer<DateTimeController>(
// builder: (context, p, _) {
// return (p.d == null)
// ? Text(
// "Pick Date",
// style: TextStyle(
// fontSize: 18,
// color: Provider.of<ThemeController>(context,
// listen: false)
//     .getTheme
// ? Colors.white
//     : Colors.black54,
// ),
// )
//     : Text(
// "${p.d!.day}/${p.d!.month}/${p.d!.year}",
// style: TextStyle(
// fontSize: 16,
// color: Provider.of<ThemeController>(context,
// listen: false)
//     .getTheme
// ? Colors.white
//     : Colors.black54,
// ),
// );
// },
// ),
// ],
// ),
// ),
// ),
// SizedBox(
// height: 10,
// ),
// GestureDetector(
// onTap: () async {
// TimeOfDay? t = await showTimePicker(
// context: context,
// initialTime:
// Provider.of<DateTimeController>(context, listen: false)
//     .t ??
// TimeOfDay.now(),
// );
// if (t != null) {
// Provider.of<DateTimeController>(context, listen: false)
//     .timeChanged(time: t);
// }
// },
// child: Container(
// height: 60,
// width: 183,
// decoration: BoxDecoration(
// // color: Colors.red,
// borderRadius: BorderRadius.circular(10),
// border: Border.all(
// color: Provider.of<ThemeController>(context).getTheme
// ? Colors.grey.shade400
//     : Colors.black54),
// ),
// child: Row(
// children: [
// Padding(
// padding: EdgeInsets.all(10),
// child: Icon(
// Icons.access_time,
// size: 25,
// ),
// ),
// SizedBox(
// width: 0,
// ),
// Consumer<DateTimeController>(
// builder: (context, p, _) {
// return (p.t == null)
// ? Text(
// "Pick Time",
// style: TextStyle(
// fontSize: 18,
// color: Provider.of<ThemeController>(context,
// listen: false)
//     .getTheme
// ? Colors.white
//     : Colors.black54,
// ),
// )
//     : Text(
// "${p.t!.hour == 0 ? '12' : p.t!.hour % 12}:${p.t!.minute} ${p.t!.hour >= 12 ? 'PM' : 'AM'}",
// style: TextStyle(
// fontSize: 16,
// color: Provider.of<ThemeController>(context,
// listen: false)
//     .getTheme
// ? Colors.white
//     : Colors.black54,
// ),
// );
// },
// ),
// ],
// ),
// ),
// ),
// ],
// ),
