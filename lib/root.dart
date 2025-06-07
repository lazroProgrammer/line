import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line/main.dart';
import 'package:line/pages/login/login_page.dart';
import 'package:line/pages/main/main_page.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  late Future<User?> _userFuture;
  late Future<bool> _dataFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = Future.value(FirebaseAuth.instance.currentUser);
    _dataFuture = _loadInitialData();
  }

  Future<bool> _loadInitialData() async {
    await getData(); // your custom function
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: _userFuture,
      builder: (context, authSnapshot) {
        if (authSnapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (authSnapshot.data != null) {
          return FutureBuilder<bool>(
            future: _dataFuture,
            builder: (context, dataSnapshot) {
              if (dataSnapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              } else if (dataSnapshot.hasError) {
                return Scaffold(
                  body: Center(child: Text("Oops, error loading data")),
                );
              } else {
                return const Mainpage();
              }
            },
          );
        } else {
          return LoginPage();
        }
      },
    );
  }
}
