import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../modals/ContactModal.dart';

class ContactController extends ChangeNotifier {
  String imagePath = "";

  clearLocalData() {
    imagePath = "";
  }

  setimagePath({required String imagePath}) {
    this.imagePath = imagePath;
    notifyListeners();
  }

  SharedPreferences preferences;
  ContactController({required this.preferences});

  List<ContactModal> _allContact = [];
  late int _contact_counter;
  List<String> SP_Contacs = [];

  get counter {
    _contact_counter = preferences.getInt('contact_counter') ?? 0;
    return _contact_counter;
  }

  get allContactlist {
    _allContact.clear();
    for (int i = 0; i < counter; i++) {
      SP_Contacs = preferences.getStringList('Contact : ${i}')!;
      ContactModal cm = ContactModal(
        name: SP_Contacs[0],
        phone: SP_Contacs[1],
        date: SP_Contacs[2],
        time: SP_Contacs[3],
        chat: SP_Contacs[4],
        image: SP_Contacs[5],
      );
      _allContact.add(cm);
    }
    return _allContact;
  }

  List<String> setSp_Contact({required ContactModal contact}) {
    SP_Contacs.clear();
    SP_Contacs.add(contact.name);
    SP_Contacs.add(contact.phone);
    SP_Contacs.add(contact.date);
    SP_Contacs.add(contact.time);
    SP_Contacs.add(contact.chat);
    SP_Contacs.add(contact.image);
    return SP_Contacs;
  }

  bool addContact({required ContactModal contact}) {
    if (_allContact.any((element) => element.phone == contact.phone)) {
      return false;
    } else {
      _contact_counter = counter;
      SP_Contacs = setSp_Contact(contact: contact);
      preferences.setStringList('Contact : ${_contact_counter}', SP_Contacs);
      preferences.setInt('contact_counter', ++_contact_counter);
      SP_Contacs.clear();
      _allContact.add(contact);
      notifyListeners();
      return true;
    }
  }

  void editContact({required ContactModal contact, required int index}) {
    SP_Contacs = setSp_Contact(contact: contact);
    preferences.setStringList('Contact : ${index}', SP_Contacs);
    _allContact[index] = contact;
    SP_Contacs.clear();
    notifyListeners();
  }

  void deleteContact({required int index}) {
    _allContact.removeAt(index);
    _allContact.forEach((element) {
      print(element.name);
    });
    for (int i = 0; i < _allContact.length; i++) {
      SP_Contacs = setSp_Contact(contact: _allContact[i]);
      preferences.setStringList('Contact : ${i}', SP_Contacs);
    }
    preferences.setInt('contact_counter', --_contact_counter);
    notifyListeners();
  }
}
