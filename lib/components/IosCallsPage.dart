import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/ContactController.dart';
import '../modals/ContactModal.dart';

class IosCallsPage extends StatelessWidget {
  const IosCallsPage({super.key});

  @override
  Widget build(BuildContext context) {
    call({required String number}) async {
      Uri uri = Uri(
        scheme: 'tel',
        path: number,
      );

      await launchUrl(uri);
    }

    return Consumer<ContactController>(builder: (context, pro, _) {
      return (pro.allContactlist.isNotEmpty)
          ? ListView.separated(
              separatorBuilder: (context, index) => Divider(
                  // thickness: 0.5,
                  indent: 100,
                  color: CupertinoColors.systemGrey.withOpacity(0.5)),
              itemCount: pro.allContactlist.length,
              itemBuilder: (context, index) {
                ContactModal cm = pro.allContactlist[index];
                return CupertinoListTile(
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
                              "${cm.name[0].toUpperCase()}",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )
                          : null,
                    ),
                  ),
                  trailing: CupertinoButton(
                    child: Icon(CupertinoIcons.phone),
                    onPressed: () {
                      call(number: cm.phone);
                    },
                  ),
                );
              },
            )
          : Text("No Calls");
    });
  }
}
