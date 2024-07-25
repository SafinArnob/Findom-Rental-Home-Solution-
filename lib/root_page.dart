import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'add_home.dart';
import 'category_page.dart';
import 'favourites.dart';
import 'home_page.dart';
import 'profile_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _selectedIndex = 0; // Index of the currently selected tab
  final PageController _pageController =
      PageController(); // PageController for PageView

  // GlobalKey for accessing Scaffold state
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // List of page widgets
  static final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    FavouritesPage(),
    CategoryPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    // Navigate to the corresponding page
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  void dispose() {
    _pageController.dispose(); // Dispose PageController to free up resources
    super.dispose();
  }

  // Method to build the AppBar
  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(80.0), // Adjust the height as needed
      child: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Padding(
          padding: EdgeInsets.only(
              top: 20.0, left: 16.0, right: 16.0), // Adjust padding as needed
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.menu, color: Colors.black),
                onPressed: () {
                  _scaffoldKey.currentState!
                      .openDrawer(); // Access ScaffoldState to open drawer
                },
                iconSize: 30,
              ),
              Image.asset(
                'assets/images/img.png', // Replace with your logo image path
                height: 200.0, // Adjust the height as needed
              ),
              Icon(
                Icons.notifications,
                color: Colors.white,
                size: 30.0,
              ),
            ],
          ),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
    );
  }

  // Method to build the Drawer
  Drawer _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/image1.png'),
                ),
                SizedBox(height: 10),
                Text(
                  'example@email.com',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading:
                Icon(Icons.add_home_work_outlined), // Icon for Rent Your Home
            title: Text('Rent Your Home'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddHomePage()),
              );
            },
          ),
          // Add more ListTiles for additional drawer items
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Assign the GlobalKey to Scaffold
      appBar: _selectedIndex == 0
          ? _buildAppBar()
          : null, // Conditionally show AppBar
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: _widgetOptions,
      ),
      drawer: _buildDrawer(), // Add the Drawer widget here
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(0.1),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: GNav(
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[100]!,
                gap: 8,
                activeColor: Colors.deepPurple,
                iconSize: 26,
                padding: EdgeInsets.all(20),
                tabBackgroundColor: Colors.grey[300]!,
                color: Colors.black,
                selectedIndex: _selectedIndex,
                onTabChange: _onItemTapped,
                tabs: const [
                  GButton(
                    icon: Icons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.favorite_border_outlined,
                    text: 'Favourites',
                  ),
                  GButton(
                    icon: Icons.category,
                    text: 'Category',
                  ),
                  GButton(
                    icon: Icons.person,
                    text: 'Profile',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}