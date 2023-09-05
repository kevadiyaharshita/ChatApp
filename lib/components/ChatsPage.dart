import 'dart:io';

import 'package:flutter/material.dart';
import 'package:platform_convertor_application_project/controller/ContactController.dart';
import 'package:platform_convertor_application_project/modals/ContactModal.dart';
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
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => Container(
                                  height: 360,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      topLeft: Radius.circular(10),
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        CircleAvatar(
                                          radius: 70,
                                          backgroundColor:
                                              Colors.primaries[index],
                                          foregroundImage: (cm.image != "")
                                              ? FileImage(File(cm.image))
                                              : null,
                                          child: (cm.image == "")
                                              ? Text(
                                                  "${cm.name[0].toUpperCase()}}",
                                                  style: TextStyle(
                                                      fontSize: 50,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                )
                                              : null,
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          cm.name,
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(cm.chat),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ElevatedButton.icon(
                                              onPressed: () {},
                                              icon: Icon(Icons.edit),
                                              label: Text("Edit",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20)),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            ElevatedButton.icon(
                                              onPressed: () {},
                                              icon: Icon(Icons.delete),
                                              label: Text(
                                                "Delete",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        OutlinedButton.icon(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          label: Text("Close"),
                                          icon: Icon(Icons.close),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            title: Text(cm.name),
                            subtitle: Text(
                              cm.chat,
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.primaries[index],
                              foregroundImage: (cm.image != "")
                                  ? FileImage(File(cm.image))
                                  : null,
                              child: (cm.image == "")
                                  ? Text(
                                      "${cm.name[0].toUpperCase()}}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )
                                  : null,
                            ),
                            trailing: Text("${cm.date},${cm.time}"),
                          ),
                        );
                      },
                    )
                  : Text("NOT ANY CHATS YET...!!");
            },
          ),
        ));
  }
}
