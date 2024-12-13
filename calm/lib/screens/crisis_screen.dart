import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';




class CrisisScreen extends StatelessWidget {
  final List<Map<String, String>> hotlines = [
    {'country': 'Kenya', 'number': '254 722 178 177'},
    {'country': 'USA', 'number': '1-800-273-8255'},
    {'country': 'UK', 'number': '116-123'},
    {'country': 'India', 'number': '9152987821'},
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Crisis Management')),
      body: ListView.builder(
        itemCount: hotlines.length,
        itemBuilder: (context, index) {
          final hotline = hotlines[index];
          return ListTile(
            title: Text(hotline['country']!),
            subtitle: Text(hotline['number']!),
            trailing: IconButton(
              icon: Icon(Icons.call),
              onPressed: () {
                launch('tel:${hotline['number']}');
              },
            ),
          );
        },
      ),
    );
  }
}
