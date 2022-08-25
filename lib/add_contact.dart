import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sqflite_db/contact.dart';
import 'package:sqflite_db/db_helper.dart';


class AddContact extends StatefulWidget {
  AddContact({Key? key, this.contact}) : super(key: key);

  Contact? contact;

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _contactController = TextEditingController();

  @override
  void initState() {
    if (widget.contact != null) {
      _nameController.text = '${widget.contact!.name}';
      _contactController.text = '${widget.contact!.contact}';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Enter Data')),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
            children: [
          _buildTextField(_nameController, 'Name'),
          SizedBox(height: 20,),
          _buildTextField(_contactController, 'Contact'),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () async {
                await DBHelper.createContacts(Contact(
                    name: _nameController.text,
                    contact: _contactController.text));
                Navigator.of(context).pop();
              },
              child: Text('Add Data')),
        ]),
      ),
    );
  }

  TextField _buildTextField(TextEditingController _controller, String hint) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
          hintText: hint,
          labelText: hint,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(15.0))),
    );
  }
}
