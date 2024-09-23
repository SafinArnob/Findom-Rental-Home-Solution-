import 'package:flutter/material.dart';

class FamilyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Family Page')),
      body: Center(child: Text('Family Page')),
    );
  }
}

class BachelorsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bachelors Page')),
      body: Center(child: Text('Bachelors Page')),
    );
  }
}

class SubletsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sublets Page')),
      body: Center(child: Text('Sublets Page')),
    );
  }
}

class MaidPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Maid Page')),
      body: Center(child: Text('Maid Page')),
    );
  }
}

class OthersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Others Page')),
      body: Center(child: Text('Others Page')),
    );
  }
}

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  // List of options with icons, labels, and routes
  final List<Map<String, dynamic>> options = [
    {'icon': Icons.family_restroom, 'label': 'Family', 'route': FamilyPage()},
    {'icon': Icons.person, 'label': 'Bachelors', 'route': BachelorsPage()},
    {'icon': Icons.house_siding, 'label': 'Sublets', 'route': SubletsPage()},
    {'icon': Icons.cleaning_services, 'label': 'Maid', 'route': MaidPage()},
    {'icon': Icons.miscellaneous_services, 'label': 'Others', 'route': OthersPage()},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        backgroundColor: Colors.cyan,
      ),
      body: Container(
        color: Colors.cyan[50],
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Logo
            Image.asset(
              'assets/images/img.png', // Replace with your logo image path
              height: 150.0, // Increased height for the logo
            ),
            const SizedBox(height: 20), // Space between logo and buttons
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                ),
                itemCount: options.length,
                itemBuilder: (context, index) {
                  return OptionCard(
                    icon: options[index]['icon'],
                    label: options[index]['label'],
                    route: options[index]['route'],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OptionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget route;

  const OptionCard({required this.icon, required this.label, required this.route});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => route),
          );
        },
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.cyan, // Button color set to cyan
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          height: 120, // Increased height of the button
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.white), // Increased icon size
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CategoryPage(),
  ));
}
