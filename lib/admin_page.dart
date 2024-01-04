import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  final List<String> slideImages;
  final List<String> gameImages; // Tambahkan gameImages ke constructor

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
            controller: adminIdController, // Tambahkan controller untuk admin_id
            decoration: InputDecoration(labelText: 'Admin ID'),
          ),  TextField(
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
          ElevatedButton(
            onPressed: () {
              // Simulate login, set isLoggedIn to true
              setState(() {
                isLoggedIn = true;
              });
            },
            child: Text('Login'),
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
              // Update the slideshow image
              setState(() {
                int index = _currentPage % widget.slideImages.length;
                widget.slideImages[index] = 'assets/${newSlideImageController.text}';
                // Set the current page to 0 to force a rebuild of the PageView
                _currentPage = 0;
              });

              // Tampilkan snackbar
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Gambar di Slideshow sudah ditambahkan!'),
                ),
              );
            },
            child: Text('Tambahkan Gambar Slideshow'),
          ),

          // Delete Slideshow Image
          ElevatedButton(
            onPressed: () {
              // Delete the current slideshow image
              setState(() {
                int index = _currentPage % widget.slideImages.length;
                widget.slideImages.removeAt(index);
                // Set the current page to 0 to force a rebuild of the PageView
                _currentPage = 0;
              });

              // Tampilkan snackbar
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Gambar di Slideshow sudah dihapus!'),
                ),
              );
            },
            child: Text('Hapus Gambar Slideshow'),
          ),

          // Update Game Images
          TextField(
            controller: newGameImageController,
            decoration: InputDecoration(labelText: 'New Game Image (e.g., mhgu.png)'),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              // Add new game image
              setState(() {
                widget.gameImages.add('assets/${newGameImageController.text}');
              });

              // Tampilkan snackbar
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Gambar di OUR GAMES sudah ditambahkan!'),
                ),
              );
            },
            child: Text('Tambahkan Gambar OUR GAMES'),
          ),

          // Delete Game Image
          ElevatedButton(
            onPressed: () {
              // Delete the last game image
              setState(() {
                if (widget.gameImages.isNotEmpty) {
                  widget.gameImages.removeLast();
                }
              });

              // Tampilkan snackbar
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Gambar di OUR GAMES sudah dihapus!'),
                ),
              );
            },
            child: Text('Hapus Gambar OUR GAMES'),
          ),

          // ... (code for updating news images)

        ],
      ),
    );
  }
}
