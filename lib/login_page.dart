import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Add your login logic here
                _performLogin();
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

  void _performLogin() {
    // You can implement your login logic here
    String username = usernameController.text;
    String password = passwordController.text;

    // Add your authentication logic (e.g., API call, validation) here

    // For this example, print the credentials to the console
    print('Username: $username');
    print('Password: $password');

    // You can navigate to the next screen or perform any other action after login
  }
}

void main() {
  runApp(MaterialApp(
    home: LoginPage(),
  ));
}
