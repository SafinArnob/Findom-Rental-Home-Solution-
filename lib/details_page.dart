import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'favourites_provider.dart'; // Import your FavouritesProvider

class DetailsPage extends StatelessWidget {
  final String imagePath;
  final String name;
  final String location;
  final int bedrooms;
  final int bathrooms;
  final int balconies;
  final String description; // Add this line

  // Constructor to accept details
  DetailsPage({
    required this.imagePath,
    required this.name,
    required this.bedrooms,
    required this.bathrooms,
    required this.balconies,
    required this.description,
    required this.location, // Include location here
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /* Text(
                    name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10), */

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildInfoBox(context, 'Bedrooms', bedrooms.toString()),
                      SizedBox(width: 10),
                      _buildInfoBox(context, 'Bathrooms', bathrooms.toString()),
                      SizedBox(width: 10),
                      _buildInfoBox(context, 'Balconies', balconies.toString()),
                    ],
                  ),
                  SizedBox(height: 20),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      children: [
                        TextSpan(
                          text: 'Location: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: location,
                          style: TextStyle(fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    description, // Display the description
                    style: TextStyle(fontSize: 16),
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
                      SnackBar(content: Text('$name added to favourites')),
                    );
                  },
                  child: Text('Add to Favourites'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget to create a standardized info box
  Widget _buildInfoBox(BuildContext context, String label, String value) {
    // Get the screen width
    double screenWidth = MediaQuery.of(context).size.width;

    // Determine the font size based on screen width
    double valueFontSize =
        screenWidth < 400 ? 16 : 18; // Smaller font for narrow screens
    double labelFontSize =
        screenWidth < 400 ? 14 : 16; // Smaller font for narrow screens

    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.0), // Reduce vertical padding
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Center the contents vertically
          children: [
            Text(
              value,
              style: TextStyle(
                  fontSize: valueFontSize, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: labelFontSize,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
