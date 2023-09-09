import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_convertor_application_project/controller/themeController.dart';
import 'package:provider/provider.dart';
import '../controller/ContactController.dart';
import '../controller/DateTimeController.dart';
import '../modals/ContactModal.dart';
import '../utils/ColorUtils.dart';

class IosAddPersonPage extends StatelessWidget {
  IosAddPersonPage({super.key});

  File? image;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController chatController = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double w = size.width;
    double h = size.height;
    return Padding(
      padding: EdgeInsets.symmetric(
          // horizontal: 16,
          // vertical: 16,
          ),
      child: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
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
                    // color: Color(0xff9397A3),
                    color: theme_Color1.withOpacity(0.3),
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
                    style: TextStyle(
                      color: theme_Color1,
                      fontSize: 16,
                    ),
                  ),
                );
              }),
              SizedBox(
                height: 30,
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
                  border:
                      Border.all(width: 1, color: CupertinoColors.systemGrey),
                ),
                keyboardType: TextInputType.name,
              ),
              SizedBox(
                height: 15,
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
                  border:
                      Border.all(width: 1, color: CupertinoColors.systemGrey),
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(
                height: 15,
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
                  border:
                      Border.all(width: 1, color: CupertinoColors.systemGrey),
                ),
                keyboardType: TextInputType.name,
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    CupertinoIcons.calendar,
                    size: 25,
                    color: CupertinoColors.systemGrey,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                    width: 310,
                    height: 36,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                          width: 1, color: CupertinoColors.systemGrey),
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        showCupertinoModalPopup(
                          context: context,
                          builder: (context) => CupertinoActionSheet(
                            title: Text("Pick Date"),
                            message: SizedBox(
                              height: 250,
                              child: CupertinoDatePicker(
                                initialDateTime: DateTime.now(),
                                mode: CupertinoDatePickerMode.date,
                                onDateTimeChanged: (date) {
                                  Provider.of<DateTimeController>(context,
                                          listen: false)
                                      .dateChanged(dateTime: date);
                                },
                              ),
                            ),
                            actions: [
                              CupertinoButton(
                                  child: Text("Set"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  })
                            ],
                            cancelButton: CupertinoActionSheetAction(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              isDestructiveAction: true,
                              child: Text("Cancel"),
                            ),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          Consumer<DateTimeController>(
                            builder: (context, p, _) {
                              return (p.d == null)
                                  ? Text(
                                      "Pick Date",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: CupertinoColors.inactiveGray
                                            .withOpacity(0.5),
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
                          Spacer(),
                          Icon(
                            CupertinoIcons.calendar_badge_plus,
                            size: 23,
                            color: CupertinoColors.systemGrey,
                          ),
                          SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    CupertinoIcons.time_solid,
                    size: 25,
                    color: CupertinoColors.systemGrey,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Consumer<DateTimeController>(builder: (context, pro, _) {
                    return Container(
                      width: 310,
                      height: 36,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            width: 1, color: CupertinoColors.systemGrey),
                      ),
                      child: GestureDetector(
                        onTap: () async {
                          showCupertinoModalPopup(
                            context: context,
                            builder: (context) => CupertinoActionSheet(
                              title: Text(
                                "Pick Time",
                                style: TextStyle(fontSize: 18),
                              ),
                              message: SizedBox(
                                height: 250,
                                child: CupertinoDatePicker(
                                  initialDateTime: DateTime.now(),
                                  mode: CupertinoDatePickerMode.time,
                                  onDateTimeChanged: (time) {
                                    pro.timeChanged(
                                        time: TimeOfDay.fromDateTime(time));
                                  },
                                ),
                              ),
                              actions: [
                                CupertinoButton(
                                    child: Text("Set"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    })
                              ],
                              cancelButton: CupertinoActionSheetAction(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                isDestructiveAction: true,
                                child: Text("Cancel"),
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            Consumer<DateTimeController>(
                              builder: (context, p, _) {
                                return (pro.t == null)
                                    ? Text(
                                        "Pick Time",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: CupertinoColors.inactiveGray
                                              .withOpacity(0.5),
                                        ),
                                      )
                                    : Text(
                                        "${pro.t!.hour == 0 ? '12' : pro.t!.hour % 12}:${pro.t!.minute} ${pro.t!.hour >= 12 ? 'PM' : 'AM'}",
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
                            Spacer(),
                            Icon(
                              Icons.more_time,
                              size: 23,
                              color: CupertinoColors.systemGrey,
                            ),
                            SizedBox(
                              width: 10,
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
              SizedBox(
                height: 70,
              ),
              Consumer<DateTimeController>(builder: (context, p, _) {
                return Transform.scale(
                  scaleY: 0.9,
                  child: CupertinoButton.filled(
                    child: const Text(
                      "Save",
                      style: TextStyle(
                        fontSize: 20,
                        color: CupertinoColors.secondarySystemBackground,
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
                        nameController = TextEditingController();
                        phoneController = TextEditingController();
                        chatController = TextEditingController();

                        Provider.of<ContactController>(context, listen: false)
                            .clearLocalData();
                        Provider.of<DateTimeController>(context, listen: false)
                            .clearDateTime();
                        ContactModal cm = Provider.of<ContactController>(
                                context,
                                listen: false)
                            .allContactlist[0];
                        print(
                            "Contact list ${cm.name},${cm.phone},${cm.date},${cm.time}");
                        FocusManager.instance.primaryFocus!.unfocus();
                      }
                    },
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}

//deleted
// Row(
//   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   children: [
//     //date
//     // GestureDetector(
//     //   onTap: () async {
//     //     showCupertinoModalPopup(
//     //       context: context,
//     //       builder: (context) => CupertinoActionSheet(
//     //         title: Text("Pick Date"),
//     //         message: SizedBox(
//     //           height: 250,
//     //           child: CupertinoDatePicker(
//     //             initialDateTime: DateTime.now(),
//     //             mode: CupertinoDatePickerMode.date,
//     //             onDateTimeChanged: (date) {
//     //               Provider.of<DateTimeController>(context,
//     //                       listen: false)
//     //                   .dateChanged(dateTime: date);
//     //             },
//     //           ),
//     //         ),
//     //         actions: [
//     //           CupertinoButton(
//     //               child: Text("Set"),
//     //               onPressed: () {
//     //                 Navigator.of(context).pop();
//     //               })
//     //         ],
//     //         cancelButton: CupertinoActionSheetAction(
//     //           onPressed: () {
//     //             Navigator.of(context).pop();
//     //           },
//     //           isDestructiveAction: true,
//     //           child: Text("Cancel"),
//     //         ),
//     //       ),
//     //     );
//     //   },
//     //   child: Container(
//     //     height: 40,
//     //     width: w / 2 - 40,
//     //     decoration: BoxDecoration(
//     //       // color: Colors.red,
//     //       borderRadius: BorderRadius.circular(5),
//     //       border: Border.all(color: CupertinoColors.systemGrey),
//     //     ),
//     //     child: Row(
//     //       children: [
//     //         Padding(
//     //           padding: EdgeInsets.symmetric(
//     //               vertical: 5, horizontal: 5),
//     //           child: Icon(
//     //             CupertinoIcons.calendar,
//     //             color: CupertinoColors.systemGrey,
//     //             size: 23,
//     //           ),
//     //         ),
//     //         SizedBox(
//     //           width: 6,
//     //         ),
//     //         Consumer<DateTimeController>(
//     //           builder: (context, p, _) {
//     //             return (p.d == null)
//     //                 ? Text(
//     //                     "Pick Date",
//     //                     style: TextStyle(
//     //                       fontSize: 16,
//     //                       color: CupertinoColors.inactiveGray
//     //                           .withOpacity(0.5),
//     //                     ),
//     //                   )
//     //                 : Text(
//     //                     "${p.d!.day}/${p.d!.month}/${p.d!.year}",
//     //                     style: TextStyle(
//     //                       fontSize: 16,
//     //                       color: Provider.of<ThemeController>(
//     //                                   context,
//     //                                   listen: false)
//     //                               .getTheme
//     //                           ? Colors.white
//     //                           : Colors.black54,
//     //                     ),
//     //                   );
//     //           },
//     //         ),
//     //       ],
//     //     ),
//     //   ),
//     // ),
//     SizedBox(
//       width: 10,
//     ),
//     Consumer<DateTimeController>(builder: (context, pro, _) {
//       return GestureDetector(
//         onTap: () async {
//           showCupertinoModalPopup(
//             context: context,
//             builder: (context) => CupertinoActionSheet(
//               title: Text(
//                 "Pick Time",
//                 style: TextStyle(fontSize: 18),
//               ),
//               message: SizedBox(
//                 height: 250,
//                 child: CupertinoDatePicker(
//                   initialDateTime: DateTime.now(),
//                   mode: CupertinoDatePickerMode.time,
//                   onDateTimeChanged: (time) {
//                     pro.timeChanged(
//                         time: TimeOfDay.fromDateTime(time));
//                   },
//                 ),
//               ),
//               actions: [
//                 CupertinoButton(
//                     child: Text("Set"),
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     })
//               ],
//               cancelButton: CupertinoActionSheetAction(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 isDestructiveAction: true,
//                 child: Text("Cancel"),
//               ),
//             ),
//           );
//         },
//         child: Container(
//           height: 40,
//           width: w / 2 - 40,
//           decoration: BoxDecoration(
//             // color: Colors.red,
//             borderRadius: BorderRadius.circular(5),
//             border: Border.all(
//               color: CupertinoColors.systemGrey,
//             ),
//           ),
//           child: Row(
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(5),
//                 child: Icon(
//                   CupertinoIcons.time,
//                   size: 23,
//                   color: CupertinoColors.systemGrey,
//                 ),
//               ),
//               SizedBox(
//                 width: 6,
//               ),
//               (pro.t == null)
//                   ? Text(
//                       "Pick Time",
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: CupertinoColors.inactiveGray
//                             .withOpacity(0.5),
//                       ),
//                     )
//                   : Text(
//                       "${pro.t!.hour == 0 ? '12' : pro.t!.hour % 12}:${pro.t!.minute} ${pro.t!.hour >= 12 ? 'PM' : 'AM'}",
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Provider.of<ThemeController>(
//                                     context,
//                                     listen: false)
//                                 .getTheme
//                             ? Colors.white
//                             : Colors.black54,
//                       ),
//                     ),
//             ],
//           ),
//         ),
//       );
//     }),
//   ],
// ),
