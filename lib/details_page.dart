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
  final String description;
  final int price; // Change to int

  DetailsPage({
    required this.imagePath,
    required this.name,
    required this.bedrooms,
    required this.bathrooms,
    required this.balconies,
    required this.description,
    required this.location,
    required this.price, // Include price here
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
              height: 300,
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
                  SizedBox(height: 10),
                  // Display the price
                  Text(
                    'Price: \$${price.toString()}', // Format the price as int
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text(
                    description,
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
                      price: price, // Save price as int
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

  Widget _buildInfoBox(BuildContext context, String label, String value) {
    double screenWidth = MediaQuery.of(context).size.width;
    double valueFontSize = screenWidth < 400 ? 16 : 18;
    double labelFontSize = screenWidth < 400 ? 14 : 16;

    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
