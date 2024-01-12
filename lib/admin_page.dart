import 'package:flutter/material.dart';
import 'login_page.dart'; // Import file login_page.dart
import 'register_page.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Page'),
        backgroundColor: Color(0xFF4E2208),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to the Admin Page!',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            _buildLoginForm(),
            SizedBox(height: 20.0),
            _buildRegisterButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Login',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextField(
          controller: _usernameController,
          decoration: InputDecoration(labelText: 'Username'),
        ),
        TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(labelText: 'Password'),
        ),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigasi ke halaman LoginPage
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
              child: Text('Login'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigasi ke halaman RegisterPage
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterPage(adminIdList: []),
                  ),
                );
              },
              child: Text('Register'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRegisterButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AdminPage(),
  ));
}
