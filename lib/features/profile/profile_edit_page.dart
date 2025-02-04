import 'package:flutter/material.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  // Dummy user data
  String username = "JohnDoe";
  String email = "johndoe@example.com";
  String password = "password123";

  // Controllers for editable fields
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isEditing = false;
  bool isPasswordObscured = true; // Added obscure state

  @override
  void initState() {
    super.initState();
    usernameController.text = username;
    passwordController.text = password;
  }

  void _toggleEdit() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  void _saveChanges() {
    setState(() {
      username = usernameController.text;
      password = passwordController.text;

      isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.save : Icons.edit),
            onPressed: () {
              if (isEditing) {
                _saveChanges();
              } else {
                _toggleEdit();
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Username Field
            TextField(
              style: const TextStyle(color: Colors.black),
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                enabled: isEditing,
              ),
            ),
            const SizedBox(height: 16),

            // Email Field (Uneditable)
            TextField(
              style: const TextStyle(color: Colors.black),
              controller: TextEditingController(text: email),
              decoration: const InputDecoration(
                labelText: 'Email',
                enabled: false,
              ),
            ),
            const SizedBox(height: 16),

            // Password Field with toggle
            TextField(
              style: const TextStyle(color: Colors.black),
              controller: passwordController,
              obscureText: isPasswordObscured,
              enabled: isEditing,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: isEditing
                    ? IconButton(
                        icon: Icon(
                          isPasswordObscured
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            isPasswordObscured = !isPasswordObscured;
                          });
                        },
                      )
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
