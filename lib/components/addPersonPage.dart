import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_convertor_application_project/controller/ContactController.dart';
import 'package:platform_convertor_application_project/controller/themeController.dart';
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
    return Padding(
      padding: EdgeInsets.all(18),
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
              height: 10,
            ),
            Consumer<ContactController>(builder: (context, p, _) {
              return TextButton(
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
                        ElevatedButton(
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
                          child: Text(
                            "Camera",
                          ),
                        ),
                        ElevatedButton(
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
                          child: Text("Gallary"),
                        ),
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
                  Consumer<themeController>(builder: (context, pro, _) {
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
                    height: 16,
                  ),
                  Consumer<themeController>(builder: (context, pro, _) {
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
                    height: 16,
                  ),
                  Consumer<themeController>(builder: (context, pro, _) {
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
                    height: 16,
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          DateTime? d = await showDatePicker(
                            context: context,
                            initialDatePickerMode: DatePickerMode.day,
                            initialDate: Provider.of<DateTimeController>(
                                        context,
                                        listen: false)
                                    .d ??
                                DateTime.now(),
                            firstDate: DateTime.now(),
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
                        icon: Icon(Icons.date_range),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Consumer<DateTimeController>(
                        builder: (context, p, _) {
                          return (p.d == null)
                              ? Text("Pick Date")
                              : Text("${p.d!.day}/${p.d!.month}/${p.d!.year}");
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () async {
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
                        icon: Icon(Icons.access_time),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Consumer<DateTimeController>(
                        builder: (context, p, _) {
                          return (p.t == null)
                              ? Text("Pick Time")
                              : Text(
                                  "${p.t!.hour == 0 ? '12' : p.t!.hour % 12}:${p.t!.minute} ${p.t!.hour >= 12 ? 'PM' : 'AM'}");
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Consumer<DateTimeController>(
                    builder: (context, p, _) {
                      return OutlinedButton(
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

                              bool check = Provider.of<ContactController>(
                                      context,
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
                            }
                          },
                          child: Text("Save"));
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
