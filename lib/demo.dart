import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sqflite_db/add_contact.dart';
import 'package:sqflite_db/contact.dart';
import 'package:sqflite_db/db_helper.dart';

class Demo extends StatefulWidget {
  const Demo({Key? key}) : super(key: key);

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Local DB')),
      body: FutureBuilder<List<Contact>>(
        future: DBHelper.readContacts(),
        builder: (BuildContext context, AsyncSnapshot<List<Contact>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Loading ......')
                ],
              ),
            );
          }
          return snapshot.data!.isEmpty
              ? Center(
                  child: Text('Vai Data nai'),
                )
              : ListView(
                  children: snapshot.data!.map((contact) {
                    return Center(
                      child: Card(
                        elevation: 10,
                        child: ListTile(
                          title: Text('${contact.name}'),
                          subtitle: Text('${contact.contact}'),
                        ),
                      ),
                    );
                  }).toList(),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final refresh = await Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => AddContact()));
          if (refresh != null) {
            setState(() {});
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
