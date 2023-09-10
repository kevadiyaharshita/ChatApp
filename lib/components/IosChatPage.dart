import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_convertor_application_project/components/IosEditDeleteModalBottomSheet.dart';
import 'package:platform_convertor_application_project/controller/ContactController.dart';
import 'package:platform_convertor_application_project/modals/ContactModal.dart';
import 'package:provider/provider.dart';

class IosChatPage extends StatelessWidget {
  const IosChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ContactController>(builder: (context, pro, _) {
      return (pro.allContactlist.isNotEmpty)
          ? ListView.separated(
              separatorBuilder: (context, index) => Divider(
                // thickness: 0.5,
                indent: 100,
                color: CupertinoColors.systemGrey.withOpacity(0.5),
              ),
              itemCount: pro.allContactlist.length,
              itemBuilder: (context, index) {
                ContactModal cm = pro.allContactlist[index];
                return CupertinoListTile(
                  onTap: () {
                    iosEditDeleteContactSheet(
                        context: context, cm: cm, index: index);
                  },
                  leadingSize: 70,
                  title: Text(cm.name),
                  subtitle: Text(cm.chat),
                  leading: Container(
                    padding: EdgeInsets.all(5),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.primaries[index],
                      foregroundImage:
                          (cm.image != "") ? FileImage(File(cm.image)) : null,
                      child: (cm.image == "")
                          ? Text(
                              "${cm.name[1].toUpperCase()}",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )
                          : null,
                    ),
                  ),
                  trailing: Column(
                    children: [
                      Text(
                        cm.date,
                        style: TextStyle(
                            fontSize: 14, color: CupertinoColors.systemGrey),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        cm.time,
                        style: TextStyle(
                            fontSize: 14, color: CupertinoColors.systemGrey),
                      ),
                    ],
                  ),
                );
              },
            )
          : Text("No Chats");
    });
  }
}
