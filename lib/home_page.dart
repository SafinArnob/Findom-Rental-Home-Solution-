import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'details_page.dart';
import 'offer_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Future<List<Map<String, dynamic>>> _fetchHomes() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('homes').get();
    return querySnapshot.docs
        .map((doc) => {
              'imagePath': doc['images'][0], // Ensure Firestore field exists
              'houseType': doc['houseType'], // Ensure Firestore field exists
              'location': doc['location'], // Ensure Firestore field exists
              'bedrooms':
                  (doc['bedrooms'] as num).toInt(), // Ensure this is int
              'bathrooms':
                  (doc['bathrooms'] as num).toInt(), // Ensure this is int
              'balconies':
                  (doc['balconies'] as num).toInt(), // Ensure this is int
              'description':
                  doc['description'], // Ensure Firestore field exists
              'price': (doc['price'] as num).toInt(), // Ensure price is int
            })
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(12),
        color: Colors.grey.shade200,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SafeArea(
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: _fetchHomes(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No homes found'));
              }

              final offerHouselist = snapshot.data!;

              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    VxSwiper.builder(
                      aspectRatio: 16 / 10,
                      autoPlay: true,
                      height: 150,
                      enlargeCenterPage: true,
                      itemCount: limitedOffres
                          .length, // Ensure limitedOffres is defined
                      itemBuilder: (context, index) {
                        final item = limitedOffres[index];
                        return GestureDetector(
                          onTap: () {},
                          child: Image.asset(
                            item['imagePath'], // Ensure this path is valid
                            fit: BoxFit.contain, // Change to BoxFit.contain
                          )
                              .box
                              .rounded
                              .clip(Clip.antiAlias)
                              .margin(const EdgeInsets.symmetric(horizontal: 8))
                              .make(),
                        );
                      },
                    ),
                    20.heightBox,
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: offerHouselist.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        mainAxisExtent: 300,
                      ),
                      itemBuilder: (context, index) {
                        final item = offerHouselist[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsPage(
                                  imagePath: item['imagePath'],
                                  name: item['houseType'],
                                  location: item['location'],
                                  bedrooms: item['bedrooms'],
                                  bathrooms: item['bathrooms'],
                                  balconies: item['balconies'],
                                  description: item['description'],
                                  price: item['price'], // Pass price as int
                                ),
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              Image.network(
                                item['imagePath'],
                                height: 200,
                                width: 200,
                                fit: BoxFit.fill,
                              ),
                              const Spacer(),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    item['houseType'],
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              2.heightBox,
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    item['location'],
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                              5.heightBox,
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    '\$${item['price'].toString()}', // Display price as int
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ).box.white.roundedSM.outerShadowSm.make(),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
