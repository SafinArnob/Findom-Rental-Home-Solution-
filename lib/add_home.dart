import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddHomePage extends StatefulWidget {
  @override
  _AddHomePageState createState() => _AddHomePageState();
}

class _AddHomePageState extends State<AddHomePage> {
  String? _houseType;
  int _bedrooms = 1;
  int _bathrooms = 1;
  int _balconies = 0;
  List<File> _images = [];

  final picker = ImagePicker();
  final TextEditingController _locationController = TextEditingController();
  bool _uploading = false;

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _images.add(File(pickedFile.path));
      });
    }
  }

  Future<void> _uploadDetails() async {
    setState(() {
      _uploading = true; // Show progress indicator
    });

    try {
      List<String> imageUrls = [];
      for (File image in _images) {
        String fileName = image.path.split('/').last;
        Reference ref =
            FirebaseStorage.instance.ref().child('images/$fileName');
        UploadTask uploadTask = ref.putFile(image);
        TaskSnapshot taskSnapshot = await uploadTask;
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();
        imageUrls.add(downloadUrl);
      }

      await FirebaseFirestore.instance.collection('homes').add({
        'houseType': _houseType,
        'bedrooms': _bedrooms,
        'bathrooms': _bathrooms,
        'balconies': _balconies,
        'location': _locationController.text,
        'images': imageUrls,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Details uploaded successfully!')),
      );

      // Clear form after successful upload
      setState(() {
        _houseType = null;
        _bedrooms = 1;
        _bathrooms = 1;
        _balconies = 0;
        _images.clear();
        _locationController.clear();
        _uploading = false; // Hide progress indicator
      });
    } catch (e) {
      // Error handling
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload details: $e')),
      );

      setState(() {
        _uploading = false; // Hide progress indicator
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Your Home'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              value: _houseType,
              hint: Text('Select House Type'),
              items: ['Family Flat', 'Sub-late Room', 'Bachelor Seat']
                  .map((type) => DropdownMenuItem<String>(
                        value: type,
                        child: Text(type),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _houseType = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _locationController,
              decoration: InputDecoration(
                labelText: 'Location',
                border: OutlineInputBorder(),
              ),
            ),
            if (_houseType == 'Family Flat' || _houseType == 'Sub-late Room')
              Column(
                children: [
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Bedrooms: $_bedrooms'),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              setState(() {
                                if (_bedrooms > 1) _bedrooms--;
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                _bedrooms++;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Bathrooms: $_bathrooms'),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              setState(() {
                                if (_bathrooms > 1) _bathrooms--;
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                _bathrooms++;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Balconies: $_balconies'),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              setState(() {
                                if (_balconies > 0) _balconies--;
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                _balconies++;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                await _getImage(ImageSource.gallery);
              },
              child: Text('Add Image'),
            ),
            SizedBox(height: 16.0),
            _images.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: _images
                        .map((image) => Image.file(
                              image,
                              height: 200,
                              fit: BoxFit.cover,
                            ))
                        .toList(),
                  )
                : Container(),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _uploadDetails,
              child: _uploading
                  ? CircularProgressIndicator()
                  : Text('Upload Details'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AddHomePage(),
  ));
}
