import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  var _contacts;

  Future<void> getContacts() async {
    List<Contact> contacts = await ContactsService.getContacts();
    print(contacts);
    if (mounted) {
      setState(() {
        _contacts = contacts;
      });
    }
  }

  @override
  void initState() {
    getContacts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contact"),),
      body: _contacts!=null && _contacts.length!=0
        ? ListView.builder(
          itemCount: _contacts.length ?? 0, 
          itemBuilder:(BuildContext context, int index) {
            Contact? contact = _contacts?.elementAt(index);
            return ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 18),
              leading: (contact?.avatar != null && contact!.avatar!.isNotEmpty)
                ? CircleAvatar(backgroundImage: MemoryImage(contact.avatar!),)
                : CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Text(contact!.initials()),
                ),
              title: Text(contact.displayName ?? ""),
            );
          }
        )
        : const Center(child: Text("Kontak Kosong"),)
    );
  }
}