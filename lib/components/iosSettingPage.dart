import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../controller/ProfileController.dart';
import '../controller/platformConverter.dart';
import '../controller/themeController.dart';
import '../modals/ProfileModal.dart';
import '../utils/ColorUtils.dart';

class IosSettingPage extends StatelessWidget {
  IosSettingPage({super.key});

  File? image;
  String imagepath = "";
  @override
  Widget build(BuildContext context) {
    int profile_index =
        Provider.of<ProfileController>(context).getUpdateProfile ? 1 : 0;
    int theme_index = Provider.of<ThemeController>(context).getTheme ? 1 : 0;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 80, horizontal: 0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            CupertinoListTile(
              title: Text("Profile"),
              subtitle: Text("Update Profile"),
              leading: Icon(CupertinoIcons.profile_circled),
              trailing: Consumer<ProfileController>(
                builder: (context, pro, _) {
                  return CupertinoSlidingSegmentedControl(
                    children: {
                      0: Icon(Icons.person_off_rounded),
                      1: Icon(Icons.person),
                    },
                    groupValue: profile_index,
                    thumbColor: CupertinoColors.white,
                    onValueChanged: (index) {
                      profile_index = index!;
                      pro.setUpdateProfile();
                    },
                  );
                },
              ),
            ),
            Consumer<ProfileController>(builder: (context, pro, _) {
              TextEditingController nameController = TextEditingController();
              TextEditingController bioController = TextEditingController();

              ProfileModal pm = pro.getProfileData;
              if (pm.profileName != "") {
                nameController.text = pm.profileName;
                bioController.text = pm.profileBio;
                pro.setimagePath(imagePath: pm.profileImage);
              }
              return Visibility(
                visible: pro.getUpdateProfile,
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          image: (pro.imagePath != "")
                              ? DecorationImage(
                                  image: FileImage(File(pro.imagePath)),
                                  fit: BoxFit.cover,
                                )
                              : null,
                          shape: BoxShape.circle,
                          // color: Color(0xff9397A3),
                          color: theme_Color1.withOpacity(0.3),
                        ),
                        child: (pro.imagePath == "")
                            ? Icon(
                                CupertinoIcons.person_solid,
                                color: Colors.white,
                                size: 70,
                              )
                            : null,
                      ),
                      CupertinoButton(
                        child: Text("Add Photo"),
                        onPressed: () async {
                          print("Tapped");
                          ImagePicker picker = ImagePicker();
                          XFile? file;

                          showCupertinoDialog(
                            context: context,
                            builder: (context) => CupertinoAlertDialog(
                              title: Text("Pick Image"),
                              content: Text("Choose the sourse for your image"),
                              actions: [
                                CupertinoButton(
                                  onPressed: () async {
                                    file = await picker.pickImage(
                                        source: ImageSource.camera);

                                    if (file != null) {
                                      image = File(file!.path);
                                      pro.setimagePath(imagePath: file!.path);
                                      // pm.profileImage = file!.path;
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
                                      pro.setimagePath(imagePath: file!.path);
                                      // pm.profileImage = file!.path;
                                    }

                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Gallary"),
                                ),
                              ],
                            ),
                          );
                        },
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
                              width: 1, color: CupertinoColors.systemGrey),
                        ),
                        keyboardType: TextInputType.name,
                      ),
                      CupertinoTextFormFieldRow(
                        controller: bioController,
                        placeholder: " Enter Bio..",
                        prefix: Row(
                          children: [
                            Icon(
                              CupertinoIcons.pencil_ellipsis_rectangle,
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
                              width: 1, color: CupertinoColors.systemGrey),
                        ),
                        keyboardType: TextInputType.name,
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Spacer(),
                          CupertinoButton(
                            child: Text(
                              "SAVE",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            onPressed: () {
                              ProfileModal pm = ProfileModal(
                                  profileName: nameController.text,
                                  profileImage: pro.imagePath,
                                  profileBio: bioController.text);
                              pro.setProfile(pm: pm);
                              FocusManager.instance.primaryFocus!.unfocus();
                            },
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          CupertinoButton(
                            child: Text(
                              "RESET",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            onPressed: () {
                              ProfileModal pm = ProfileModal(
                                  profileName: "",
                                  profileImage: "",
                                  profileBio: "");
                              pro.setProfile(pm: pm);
                              pro.clearLocalData();
                              FocusManager.instance.primaryFocus!.unfocus();
                            },
                          ),
                          Spacer(),
                        ],
                      )
                    ],
                  ),
                ),
              );
            }),
            Divider(
              thickness: 0.5,
              color: CupertinoColors.systemGrey.withOpacity(0.5),
            ),
            CupertinoListTile(
              title: Text("Theme"),
              subtitle: Text("Change Theme"),
              leading: Icon(CupertinoIcons.sun_min_fill),
              trailing: Consumer<ThemeController>(builder: (context, pro, _) {
                return CupertinoSlidingSegmentedControl(
                  children: {
                    0: Icon(CupertinoIcons.sun_min),
                    1: Icon(CupertinoIcons.moon_fill),
                  },
                  groupValue: theme_index,
                  thumbColor: CupertinoColors.white,
                  onValueChanged: (index) {
                    profile_index = index!;
                    pro.changeTheme();
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
