import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'favourites_provider.dart'; // Import the FavouritesProvider

class DetailsPage extends StatelessWidget {
  final String imagePath;
  final String name;
  final String location;
  final int bedrooms;
  final int bathrooms;
  final int balconies;

  DetailsPage({
    required this.imagePath,
    required this.name,
    required this.location,
    required this.bedrooms,
    required this.bathrooms,
    required this.balconies,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300, // Adjust the height as per your requirement
                  child: Image.network(
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  location,
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildInfoBox('Bedrooms', bedrooms.toString()),
                    SizedBox(width: 10),
                    _buildInfoBox('Bathrooms', bathrooms.toString()),
                    SizedBox(width: 10),
                    _buildInfoBox('Balconies', balconies.toString()),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  FavouriteItem item = FavouriteItem(
                    imagePath: imagePath,
                    name: name,
                    location: location,
                    bedrooms: bedrooms,
                    bathrooms: bathrooms,
                    balconies: balconies,
                  );
                  Provider.of<FavouritesProvider>(context, listen: false)
                      .addFavourite(item);
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('$name added to favourites')));
                },
                child: Text('Add to Favourites'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBox(String label, String value) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
