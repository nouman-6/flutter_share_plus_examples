import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Share Plus Demo"), centerTitle: true,),
    body: Column(
      children: [
        Card(
              child: ListTile(
                leading: Icon(Icons.text_fields, color: Colors.blue),
                title: Text('1. Share Plain Text'),
                subtitle: Text('Shares a simple text message.'),
                trailing: ElevatedButton(
                  onPressed: () async {
                    final result = await SharePlus.instance.share(
                      ShareParams(text: 'Check out this cool Flutter package! #FlutterShare'),
                    );
                    // Handle result if needed (e.g., show snackbar)
                    if(result.status == ShareResultStatus.success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Text shared successfully!')),
                      );
                    } else if(result.status == ShareResultStatus.dismissed) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Share dismissed.')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Share failed: ${result.raw}')),
                      );
                    }
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(content: Text('Share result: ${result.status}')),
                    // );
                  },
                  child: Text('Share'),
                ),
              ),
            ),

            Card(
              child: ListTile(
                leading: Icon(Icons.link, color: Colors.green),
                title: Text('2. Share URI/URL'),
                subtitle: Text('Shares a web link with optional text.'),
                trailing: ElevatedButton(
                  onPressed: () async {
                    final result = await SharePlus.instance.share(
                      ShareParams(
                        uri: Uri.parse('https://flutter.dev'),
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Share result: ${result.status}')),
                    );
                  },
                  child: Text('Share'),
                ),
              ),
            ),



            Card(
              child: ListTile(
                leading: Icon(Icons.dynamic_form, color: Colors.purple),
                title: Text('4. Share Dynamic Data as Files'),
                subtitle: Text('Generates and shares in-memory data (e.g., CSV export).'),
                trailing: ElevatedButton(
                  onPressed: () async {
                    // Generate dynamic data (e.g., a simple CSV string)
                    final csvData = utf8.encode('Name,Age,City\nAlice,30,New York\nBob,25,London');
                    final dynamicFile = XFile.fromData(
                      csvData,
                      name: 'export.csv',
                      mimeType: 'text/csv',
                    );
                    final result = await SharePlus.instance.share(
                      ShareParams(
                        files: [dynamicFile],
                        text: 'Here\'s your dynamic export file!',
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Share result: ${result.status}')),
                    );
                  },
                  child: Text('Share Dynamic'),
                ),
              ),
            ),
      ],
    ),);
  }
}
