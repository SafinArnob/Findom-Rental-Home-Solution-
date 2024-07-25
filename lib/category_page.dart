import 'package:flutter/material.dart';

// Placeholder pages for navigation
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

class _CategoryPageState extends State<CategoryPage>
    with SingleTickerProviderStateMixin {
  bool _showOverlay = false;
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  // List of options with icons, labels, and routes
  final List<Map<String, dynamic>> options = [
    {'icon': Icons.family_restroom, 'label': 'Family', 'route': FamilyPage()},
    {'icon': Icons.person, 'label': 'Bachelors', 'route': BachelorsPage()},
    {'icon': Icons.house_siding, 'label': 'Sublets', 'route': SubletsPage()},
    {'icon': Icons.cleaning_services, 'label': 'Maid', 'route': MaidPage()},
    {
      'icon': Icons.miscellaneous_services,
      'label': 'Others',
      'route': OthersPage()
    },
  ];

  // List of options for the 3-dot menu
  final List<Map<String, dynamic>> menuOptions = [
    {'icon': Icons.shopping_cart, 'label': 'Cart'},
    {'icon': Icons.star, 'label': 'Rating'},
    {'icon': Icons.favorite, 'label': 'Favourite'},
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  void _toggleOverlay() {
    setState(() {
      _showOverlay = !_showOverlay;
      if (_showOverlay) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category'),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // First row with 3 icons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: options.take(3).map((option) {
                          return OptionCard(
                            icon: option['icon'],
                            label: option['label'],
                            route: option['route'],
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 32), // Gap between rows
                      // Second row with 2 centered icons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Spacer(),
                          OptionCard(
                            icon: options[3]['icon'],
                            label: options[3]['label'],
                            route: options[3]['route'],
                          ),
                          const Spacer(flex: 2),
                          OptionCard(
                            icon: options[4]['icon'],
                            label: options[4]['label'],
                            route: options[4]['route'],
                          ),
                          const Spacer(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: OptionCard(
                  icon: Icons.local_offer,
                  label: 'Hot Deals',
                  route: Container(), // Add route for 'Hot Deals' if needed
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OptionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget route;

  const OptionCard(
      {required this.icon, required this.label, required this.route});

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
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 3,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 24, color: Colors.deepPurple),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.deepPurple, fontWeight: FontWeight.bold),
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
