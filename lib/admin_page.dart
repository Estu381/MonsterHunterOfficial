import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'register_page.dart';
import 'edit.dart';

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

  Future<void> _pickImage(TextEditingController controller) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        controller.text = pickedFile.path;
      });
    }
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

      // Setelah berhasil menambahkan gambar, kirim kembali gambar tersebut ke halaman sebelumnya (MyHomePage)
      Navigator.pop(context, newSlideImageController.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $e'),
        ),
      );
    }
  }

  void _deleteSlideshowImage() {
    try {
      if (newSlideImageController.text.isNotEmpty) {
        // Hapus gambar dari penyimpanan lokal
        File imageFile = File(newSlideImageController.text);
        if (imageFile.existsSync()) {
          imageFile.deleteSync();

          // Setelah menghapus dari penyimpanan lokal, reset nilai controller
          newSlideImageController.text = '';

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Slideshow image deleted locally!'),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Slideshow image not found locally.'),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No slideshow image selected for deletion.'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $e'),
        ),
      );
    }
  }

  void _addGameImage() async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://10.10.25.27/flutter_api/api.php?action=add_game_image'),
      );

      request.files.add(await http.MultipartFile.fromPath('new_game_image', newGameImageController.text));

      var response = await request.send();
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);

      print(responseString);

      _handleApiResponse(http.Response(responseString, response.statusCode), 'Game image added!');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $e'),
        ),
      );
    }
  }

  void _deleteGameImage() async {
    try {
      var response = await http.post(
        Uri.parse('http://192.168.227.206/flutter_api/api.php?action=delete_game_image'),
        body: {'game_image_path': newGameImageController.text},
      );

      print(response.body);
      print(response.statusCode);

      _handleApiResponse(response, 'Game image deleted!');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $e'),
        ),
      );
    }
  }

  void _editGame() async {
    // Implementasi edit game
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => edit(),
      ),
    );
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
          content: Text('Failed to communicate with the server. ${response.reasonPhrase}'),
        ),
      );
    }
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
            controller: usernameController,
            decoration: InputDecoration(labelText: 'Username'),
          ),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () async {
                  // Perform login validation
                  if (await validateLogin()) {
                    // Set isLoggedIn to true if login is successful
                    setState(() {
                      isLoggedIn = true;
                    });

                    // Show a success notification
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Login successful!'),
                        backgroundColor: Colors.green, // Customize the background color
                      ),
                    );
                  } else {
                    // Show a snackbar for invalid login credentials
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Invalid login credentials!'),
                        backgroundColor: Colors.red, // Customize the background color
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
          _buildImagePicker(
            'New Slideshow Image',
            newSlideImageController,
                () {
              _addSlideshowImage();
            },
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              _deleteSlideshowImage();
            },
            child: Text('Delete Slideshow Image'),
          ),
          // Update Game Images
          _buildImagePicker(
            'New Game Image',
            newGameImageController,
                () {
              _addGameImage();
            },
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              _deleteGameImage();
            },
            child: Text('Delete Game Image'),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              _editGame();
            },
            child: Text('Edit News Text'),
          ),
        ],
      ),
    );
  }

  Widget _buildImagePicker(String labelText, TextEditingController controller, VoidCallback onPressed) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(labelText),
        SizedBox(height: 8.0),
        controller.text.isNotEmpty
            ? Image.file(
          File(controller.text),
          height: 100,
        )
            : ElevatedButton(
          onPressed: () {
            _pickImage(controller);
          },
          child: Text('Pick Image'),
        ),
        SizedBox(height: 8.0),
        TextField(
          controller: controller,
          decoration: InputDecoration(labelText: 'Image Path'),
          readOnly: true,
        ),
        SizedBox(height: 8.0),
        ElevatedButton(
          onPressed: onPressed,
          child: Text('Upload Image'),
        ),
      ],
    );
  }
}
