import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_convertor_application_project/controller/ContactController.dart';
import 'package:platform_convertor_application_project/controller/themeController.dart';
import 'package:platform_convertor_application_project/utils/ColorUtils.dart';
import 'package:provider/provider.dart';
import '../controller/DateTimeController.dart';
import '../modals/ContactModal.dart';

class AddPersonPage extends StatelessWidget {
  AddPersonPage({super.key});

  // String imagePath = "";
  File? image;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController chatController = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    double h = s.height;
    double w = s.width;
    return Padding(
      padding: EdgeInsets.all(18),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Consumer<ContactController>(builder: (context, p, _) {
              return Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  image: (p.imagePath != "")
                      ? DecorationImage(
                          image: FileImage(File(p.imagePath)),
                          fit: BoxFit.cover,
                        )
                      : null,
                  shape: BoxShape.circle,
                  // color: Color(0xff9397A3),
                  color: theme_Color1.withOpacity(0.3),
                ),
                child: (p.imagePath == "")
                    ? Icon(
                        CupertinoIcons.person_solid,
                        color: Colors.white,
                        size: 100,
                      )
                    : null,
              );
            }),
            Consumer<ContactController>(builder: (context, p, _) {
              return TextButton.icon(
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                onPressed: () async {
                  ImagePicker picker = ImagePicker();
                  XFile? file;

                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Pick Image"),
                      // backgroundColor: Six_Blue,

                      content: Text("Choose the sourse for your image"),
                      actions: [
                        ElevatedButton.icon(
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
                              p.setimagePath(imagePath: file!.path);
                              // p.imagePath = file!.path;
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
                label: Text(
                  "Add Photo",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              );
            }),
            SizedBox(
              height: 20,
            ),
            Form(
              key: formkey,
              child: Column(
                children: [
                  Consumer<ThemeController>(builder: (context, pro, _) {
                    return TextFormField(
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
                        prefixIcon: Icon(
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
                  SizedBox(
                    height: 10,
                  ),
                  Consumer<ThemeController>(builder: (context, pro, _) {
                    return TextFormField(
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      controller: chatController,
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
                        prefixIcon: Icon(
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
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          DateTime? d = await showDatePicker(
                            context: context,
                            initialDatePickerMode: DatePickerMode.day,
                            initialDate: Provider.of<DateTimeController>(
                                        context,
                                        listen: false)
                                    .d ??
                                DateTime.now(),
                            firstDate: DateTime(1949),
                            lastDate: DateTime.now().add(
                              Duration(days: 100),
                            ),
                          );

                          if (d != null) {
                            Provider.of<DateTimeController>(context,
                                    listen: false)
                                .dateChanged(dateTime: d);
                          }
                        },
                        child: Container(
                          height: 60,
                          width: w / 2 - 23,
                          decoration: BoxDecoration(
                              // color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Provider.of<ThemeController>(context)
                                          .getTheme
                                      ? Colors.grey.shade400
                                      : Colors.black54)),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Icon(
                                  Icons.calendar_month_sharp,
                                  size: 25,
                                ),
                              ),
                              SizedBox(
                                width: 0,
                              ),
                              Consumer<DateTimeController>(
                                builder: (context, p, _) {
                                  return (p.d == null)
                                      ? Text(
                                          "Pick Date",
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Provider.of<ThemeController>(
                                                        context,
                                                        listen: false)
                                                    .getTheme
                                                ? Colors.white
                                                : Colors.black54,
                                          ),
                                        )
                                      : Text(
                                          "${p.d!.day}/${p.d!.month}/${p.d!.year}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Provider.of<ThemeController>(
                                                        context,
                                                        listen: false)
                                                    .getTheme
                                                ? Colors.white
                                                : Colors.black54,
                                          ),
                                        );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () async {
                          TimeOfDay? t = await showTimePicker(
                            context: context,
                            initialTime: Provider.of<DateTimeController>(
                                        context,
                                        listen: false)
                                    .t ??
                                TimeOfDay.now(),
                          );
                          if (t != null) {
                            Provider.of<DateTimeController>(context,
                                    listen: false)
                                .timeChanged(time: t);
                          }
                        },
                        child: Container(
                          height: 60,
                          width: w / 2 - 23,
                          decoration: BoxDecoration(
                            // color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Provider.of<ThemeController>(context)
                                        .getTheme
                                    ? Colors.grey.shade400
                                    : Colors.black54),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Icon(
                                  Icons.access_time,
                                  size: 25,
                                ),
                              ),
                              SizedBox(
                                width: 0,
                              ),
                              Consumer<DateTimeController>(
                                builder: (context, p, _) {
                                  return (p.t == null)
                                      ? Text(
                                          "Pick Time",
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Provider.of<ThemeController>(
                                                        context,
                                                        listen: false)
                                                    .getTheme
                                                ? Colors.white
                                                : Colors.black54,
                                          ),
                                        )
                                      : Text(
                                          "${p.t!.hour == 0 ? '12' : p.t!.hour % 12}:${p.t!.minute} ${p.t!.hour >= 12 ? 'PM' : 'AM'}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Provider.of<ThemeController>(
                                                        context,
                                                        listen: false)
                                                    .getTheme
                                                ? Colors.white
                                                : Colors.black54,
                                          ),
                                        );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Consumer<DateTimeController>(
                    builder: (context, p, _) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(150, 30),
                          backgroundColor: theme_Color1,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          bool validate = formkey.currentState!.validate();
                          if (validate) {
                            formkey.currentState!.save();
                            ContactModal c = ContactModal(
                              name: nameController.text,
                              phone: phoneController.text,
                              time:
                                  "${p.t!.hour == 0 ? '12' : p.t!.hour % 12}:${p.t!.minute} ${p.t!.hour >= 12 ? 'PM' : 'AM'}",
                              date: "${p.d!.day}/${p.d!.month}/${p.d!.year}",
                              chat: chatController.text,
                              image: Provider.of<ContactController>(context,
                                      listen: false)
                                  .imagePath,
                            );

                            bool check = Provider.of<ContactController>(context,
                                    listen: false)
                                .addContact(contact: c);

                            formkey.currentState!.reset();
                            Provider.of<ContactController>(context,
                                    listen: false)
                                .clearLocalData();
                            Provider.of<DateTimeController>(context,
                                    listen: false)
                                .clearDateTime();
                            ContactModal cm = Provider.of<ContactController>(
                                    context,
                                    listen: false)
                                .allContactlist[0];
                            print(
                                "Contact list ${cm.name},${cm.phone},${cm.date},${cm.time}");

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: (check)
                                    ? Text("Contect Added Succesfully..")
                                    : Text("Failed To Saved..!!"),
                                behavior: SnackBarBehavior.floating,
                                duration: Duration(seconds: 2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                margin: EdgeInsets.all(10),
                                dismissDirection: DismissDirection.horizontal,
                              ),
                            );
                            FocusManager.instance.primaryFocus!.unfocus();
                          }
                        },
                        child: Text(
                          "Save",
                          style: TextStyle(fontSize: 18),
                        ),
                      );
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
