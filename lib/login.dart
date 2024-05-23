import 'package:flutter/material.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 32),
                const Text(
                  'Welcome to Planner App',
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: "Serif",
                    fontWeight: FontWeight.bold,
                    height: 2.0,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Keep your data safe',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Serif",
                    fontWeight: FontWeight.bold,
                    height: 2.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                Positioned(
                  left: 0,
                  top: 0,
                  child: CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage('assets/Planner.jpg'),
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 8),
                    child: TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                          filled: true,
                          hintText: "Username",
                          prefixIcon: const Icon(Icons.message),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(28))),
                    )),
                Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 8),
                    child: TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                            filled: true,
                            hintText: "Password",
                            prefixIcon: const Icon(Icons.lock),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(28))),
                        obscureText: true)),
                const SizedBox(height: 32),
                OverflowBar(
                  alignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      child: const Text('CANCEL'),
                      onPressed: () {
                        _usernameController.clear();
                        _passwordController.clear();
                      },
                    ),
                    ElevatedButton(
                      child: const Text('LOGIN'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
