import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whatsapp/domain/entities/contact_entity.dart';

abstract class LocalDataSource {
  Future<List<ContactEntity>> getDeviceNumbers(context);
}

class LocalDataSourceImpl implements LocalDataSource {
  @override
  Future<List<ContactEntity>> getDeviceNumbers(context) async {
    List<ContactEntity> contacts = [];

    var _status = await Permission.contacts.status;
    if (_status.isGranted) {
      final getContactsData = await ContactsService.getContacts();
      getContactsData.forEach((myContact) {
        myContact.phones!.forEach((phoneData) {
          contacts.add(ContactEntity(
            phoneNumber: phoneData.value,
            label: myContact.displayName,
          ));
        });
      });
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: Text("Contacts Permission"),
                content: Text("This app needs contacts access"),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: Text("Deny"),
                    onPressed: () => Navigator.pop(context),
                  ),
                  CupertinoDialogAction(
                    child: Text("Settings"),
                    onPressed: () => openAppSettings(),
                  ),
                ],
              ));
    }
    return contacts;
  }
}
