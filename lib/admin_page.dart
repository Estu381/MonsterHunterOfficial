import 'package:flutter/material.dart';
import 'register_page.dart'; // Import file register_page.dart

class AdminPage extends StatefulWidget {
  final List<String> slideImages;
  final List<String> gameImages;

  const AdminPage({Key? key, required this.slideImages, required this.gameImages}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  bool isLoggedIn = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController adminIdController = TextEditingController();
  TextEditingController newSlideImageController = TextEditingController();
  TextEditingController newGameImageController = TextEditingController();
  TextEditingController newsIndexController = TextEditingController();
  TextEditingController newNewsImageController = TextEditingController();

  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Page'),
        backgroundColor: Color(0xFF4E2208),
        leading: Image.asset(
          'assets/mhlogofix.png',
          width: 40,
          height: 40,
        ),
        actions: [],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!isLoggedIn)
              _buildLoginForm()
            else
              _buildWelcomeMessage(),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: adminIdController,
            decoration: InputDecoration(labelText: 'Admin ID'),
          ),
          TextField(
            controller: usernameController,
            decoration: InputDecoration(labelText: 'Username'),
          ),
          SizedBox(height: 16.0),
          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(labelText: 'Password'),
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isLoggedIn = true;
                  });
                },
                child: Text('Login'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()), // Hapus adminIdList
                  );
                },
                child: Text('Register Here'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeMessage() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Welcome to Admin Page!',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Update Slideshow Image
          TextField(
            controller: newSlideImageController,
            decoration: InputDecoration(labelText: 'New Slideshow Image (e.g., mhwild.png)'),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              setState(() {
                int index = _currentPage % widget.slideImages.length;
                widget.slideImages[index] = 'assets/${newSlideImageController.text}';
                _currentPage = 0;
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Slideshow image added!'),
                ),
              );
            },
            child: Text('Add Slideshow Image'),
          ),
          // Delete Slideshow Image
          ElevatedButton(
            onPressed: () {
              setState(() {
                int index = _currentPage % widget.slideImages.length;
                widget.slideImages.removeAt(index);
                _currentPage = 0;
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Slideshow image deleted!'),
                ),
              );
            },
            child: Text('Delete Slideshow Image'),
          ),
          // Update Game Images
          TextField(
            controller: newGameImageController,
            decoration: InputDecoration(labelText: 'New Game Image (e.g., mhgu.png)'),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              setState(() {
                widget.gameImages.add('assets/${newGameImageController.text}');
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Game image added!'),
                ),
              );
            },
            child: Text('Add Game Image'),
          ),
          // Delete Game Image
          ElevatedButton(
            onPressed: () {
              setState(() {
                if (widget.gameImages.isNotEmpty) {
                  widget.gameImages.removeLast();
                }
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Game image deleted!'),
                ),
              );
            },
            child: Text('Delete Game Image'),
          ),
        ],
      ),
    );
  }
}
