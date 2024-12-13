import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:calm/models/resources_model.dart'; // Your Resource model
import 'package:calm/services/resource_service.dart'; // Ensure fetchResources is imported

class ResourcesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Self-Help Resources')),
      body: FutureBuilder<List<Resource>>(
        future: fetchResources(), // Ensure this method is properly defined and imported
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading resources'));
          }

          final resources = snapshot.data ?? [];
          return ListView.builder(
            itemCount: resources.length,
            itemBuilder: (context, index) {
              final resource = resources[index];
              return ListTile(
                title: Text(resource.title),
                subtitle: Text(resource.type),
                onTap: () async {
                  if (await canLaunch(resource.url)) {
                    await launch(resource.url);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Could not launch ${resource.url}')),
                    );
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
