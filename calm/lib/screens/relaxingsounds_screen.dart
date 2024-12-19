// import 'package:flutter/material.dart';
// import 'package:calm/screens/sound_list.dart';

// class CategoriesScreen extends StatelessWidget {
//   // List of categories
//   final List<Map<String, String>> categories = [
//     {'title': 'Ocean Sounds', 'query': 'ocean', 'image': 'assets/ocean.png'},
//     {'title': 'Thunderstorm Sounds', 'query': 'thunderstorm', 'image': 'assets/thunderstorm.png'},
//     {'title': 'Rain Sounds', 'query': 'rain', 'image': 'assets/rain.png'},
//     {'title': 'Waterfall Sounds', 'query': 'waterfall', 'image': 'assets/waterfall.png'},
//     {'title': 'Rainforest Sounds', 'query': 'rainforest', 'image': 'assets/rainforest.png'},
//     {'title': 'Tin Sounds', 'query': 'tin', 'image': 'assets/tin.png'},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Relaxing Sound Categories'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: GridView.builder(
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 3,
//             crossAxisSpacing: 8,
//             mainAxisSpacing: 8,
//             childAspectRatio: 3 / 4,
//           ),
//           itemCount: categories.length,
//           itemBuilder: (context, index) {
//             final category = categories[index];
//             return GestureDetector(
//               onTap: () {
//                 // Navigate to the SoundList screen with the selected category
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => SoundList(categoryQuery: category['query']!),
//                   ),
//                 );
//               },
//               child: Card(
//                 elevation: 4,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     Expanded(
//                       child: ClipRRect(
//                         borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
//                         child: Image.asset(
//                           category['image']!,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(
//                         category['title']!,
//                         textAlign: TextAlign.center,
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
