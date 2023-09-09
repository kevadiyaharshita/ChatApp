import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_convertor_application_project/modals/ProfileModal.dart';
import 'package:platform_convertor_application_project/utils/ColorUtils.dart';
import 'package:provider/provider.dart';

import '../controller/ProfileController.dart';
import '../controller/platformConverter.dart';
import '../controller/themeController.dart';

class SettingPage extends StatelessWidget {
  SettingPage({super.key});

  File? image;
  String imagepath = "";
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(18),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: Container(
                height: 50,
                width: 30,
                alignment: Alignment.center,
                child: Icon(
                  Icons.person_pin,
                  size: 30,
                ),
              ),
              title: Text(
                "Profile",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "Update Profile Data",
              ),
              trailing: Consumer<ProfileController>(builder: (context, pro, _) {
                return Switch(
                  activeColor: theme_Color1,
                  activeTrackColor: theme_Color1,
                  inactiveTrackColor: Colors.white,
                  thumbColor: MaterialStateColor.resolveWith((states) =>
                      (pro.getUpdateProfile) ? Colors.white : theme_Color1),
                  value: pro.getUpdateProfile,
                  onChanged: (val) {
                    pro.setUpdateProfile();
                  },
                );
              }),
            ),

            //profile visibility
            Consumer<ProfileController>(
              builder: (context, pro, _) {
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
                          height: 10,
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
                        TextButton.icon(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () async {
                            ImagePicker picker = ImagePicker();
                            XFile? file;

                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("Pick Image"),
                                content:
                                    Text("Choose the sourse for your image"),
                                actions: [
                                  ElevatedButton.icon(
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
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        backgroundColor: Colors.white),
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
                        ),
                        Container(
                          height: 150,
                          width: 330,
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              //name
                              Consumer<ThemeController>(
                                builder: (context, p, _) {
                                  return TextFormField(
                                    keyboardType: TextInputType.name,
                                    textInputAction: TextInputAction.next,
                                    controller: nameController,
                                    decoration: InputDecoration(
                                      hintText: "Enter Name",
                                      labelText: "Name",
                                      labelStyle: TextStyle(
                                        fontSize: 20,
                                        color: p.getTheme
                                            ? Colors.white
                                            : Colors.black54,
                                      ),
                                      prefixIcon: Icon(
                                        Icons.person,
                                      ),
                                    ),
                                  );
                                },
                              ),

                              //bio
                              Consumer<ThemeController>(
                                builder: (context, p, _) {
                                  return TextFormField(
                                    keyboardType: TextInputType.name,
                                    textInputAction: TextInputAction.next,
                                    controller: bioController,
                                    decoration: InputDecoration(
                                      hintText: "Enter Your Bio",
                                      labelText: "Bio",
                                      labelStyle: TextStyle(
                                        fontSize: 20,
                                        color: p.getTheme
                                            ? Colors.white
                                            : Colors.black54,
                                      ),
                                      prefixIcon: Icon(
                                        Icons.person,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Consumer<ProfileController>(
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
                                    ProfileModal pm = ProfileModal(
                                        profileName: nameController.text,
                                        profileImage: pro.imagePath,
                                        profileBio: bioController.text);
                                    pro.setProfile(pm: pm);
                                    FocusManager.instance.primaryFocus!
                                        .unfocus();
                                  },
                                  icon: Icon(Icons.save_alt),
                                  label: Text(
                                    "Save",
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
                                ProfileModal pm = ProfileModal(
                                    profileName: "",
                                    profileImage: "",
                                    profileBio: "");
                                pro.setProfile(pm: pm);
                                pro.clearLocalData();
                                FocusManager.instance.primaryFocus!.unfocus();
                              },
                              icon: Icon(Icons.refresh),
                              label: const Text(
                                "Reset",
                                style: TextStyle(fontSize: 18),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Container(
                  height: 50,
                  width: 30,
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.light_mode,
                    size: 30,
                  )),
              title: Text(
                "Theme",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "Change Theme",
              ),
              trailing: Consumer<ThemeController>(
                builder: (context, pro, _) {
                  return Switch(
                    activeColor: theme_Color1,
                    activeTrackColor: theme_Color1,
                    inactiveTrackColor: Colors.white,
                    thumbColor: MaterialStateColor.resolveWith((states) =>
                        (pro.getTheme) ? Colors.white : theme_Color1),
                    value: pro.getTheme,
                    onChanged: (val) {
                      pro.changeTheme();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
