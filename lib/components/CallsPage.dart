import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/ContactController.dart';
import '../modals/ContactModal.dart';
import 'EditDeleteModalBottomSheet.dart';

class CallsPage extends StatelessWidget {
  const CallsPage({super.key});

  @override
  Widget build(BuildContext context) {
    call({required String number}) async {
      Uri uri = Uri(
        scheme: 'tel',
        path: number,
      );

      await launchUrl(uri);
    }

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
                            trailing: IconButton(
                              onPressed: () {
                                call(number: cm.phone);
                              },
                              icon: Icon(
                                Icons.call,
                                size: 30,
                                color: Colors.green,
                              ),
                            )),
                      );
                    },
                  )
                : Text("NOT ANY CALLS YET...!!");
          },
        ),
      ),
    );
  }
}
