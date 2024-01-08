import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'register_page.dart';

class AdminPage extends StatefulWidget {
  final List<String> slideImages;
  final List<String> gameImages;

  const AdminPage({Key? key, required this.slideImages, required this.gameImages}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  bool isLoggedIn = false;
  TextEditingController adminIdController = TextEditingController();
  TextEditingController newSlideImageController = TextEditingController();
  TextEditingController newGameImageController = TextEditingController();

  late PageController _pageController;
  int _currentPage = 0;

  List<String> adminIdList = [];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
  }

  bool validateLogin() {
    // Remove any login validation logic and always return true
    return true;
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
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (validateLogin()) {
                    setState(() {
                      isLoggedIn = true;
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Invalid login credentials!'),
                      ),
                    );
                  }
                },
                child: Text('Login'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterPage(adminIdList: adminIdList),
                    ),
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
              _addSlideshowImage();
            },
            child: Text('Add Slideshow Image'),
          ),
          // Delete Slideshow Image
          ElevatedButton(
            onPressed: () {
              _deleteSlideshowImage();
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
              _addGameImage();
            },
            child: Text('Add Game Image'),
          ),
          // Delete Game Image
          ElevatedButton(
            onPressed: () {
              _deleteGameImage();
            },
            child: Text('Delete Game Image'),
          ),
        ],
      ),
    );
  }

  void _addSlideshowImage() async {
    try {
      var response = await http.post(
        Uri.parse('http://192.168.227.206/flutter_api/api.php?action=add_slide_image'),
        body: {'new_slide_image': newSlideImageController.text},
      );

      print(response.body);
      print(response.statusCode);


      _handleApiResponse(response, 'Slideshow image added!');
    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $e'),
        ),

      );

    }
  }

  void _deleteSlideshowImage() async {
    // Implementasi penghapusan gambar slideshow dari database di sini (sesuai kebutuhan)
  }

  void _addGameImage() async {
    // Implementasi penambahan gambar game ke database di sini (sesuai kebutuhan)
  }

  void _deleteGameImage() async {
    // Implementasi penghapusan gambar game dari database di sini (sesuai kebutuhan)
  }

  void _handleApiResponse(http.Response response, String successMessage) {
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['success'] == true) {
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(successMessage),
            ),
          );
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed. ${data['message']}'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to communicate with the server.'),
        ),
      );
    }
  }
}
