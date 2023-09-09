import 'dart:io';
import 'package:flutter/material.dart';
import 'package:platform_convertor_application_project/components/EditDeleteModalBottomSheet.dart';
import 'package:platform_convertor_application_project/controller/ContactController.dart';
import 'package:platform_convertor_application_project/modals/ContactModal.dart';
import 'package:platform_convertor_application_project/utils/ColorUtils.dart';
import 'package:provider/provider.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(18),
      child: Center(
        child: Consumer<ContactController>(
          builder: (context, pro, _) {
            return (pro.allContactlist.isNotEmpty)
                ? ListView.builder(
                    itemCount: pro.allContactlist.length,
                    itemBuilder: (context, index) {
                      ContactModal cm = pro.allContactlist[index];
                      return Card(
                        child: ListTile(
                          onTap: () {
                            editDeleteContactSheet(
                                context: context, cm: cm, index: index);
                          },
                          title: Text(cm.name),
                          subtitle: Text(
                            cm.chat,
                          ),
                          leading: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.primaries[index],
                            foregroundImage: (cm.image != "")
                                ? FileImage(File(cm.image))
                                : null,
                            child: (cm.image == "")
                                ? Text(
                                    "${cm.name[0].toUpperCase()}",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )
                                : null,
                          ),
                          trailing: Column(
                            children: [
                              Spacer(),
                              Text("${cm.date}"),
                              Text(
                                "${cm.time}",
                                style: TextStyle(fontSize: 14),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : Text("NOT ANY CHATS YET...!!");
          },
        ),
      ),
    );
  }
}
