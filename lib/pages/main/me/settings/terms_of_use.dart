import 'package:flutter/material.dart';

class TermsOfUsePage extends StatelessWidget {
  const TermsOfUsePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Terms of use")),
        body: Padding(padding: EdgeInsets.all(12), child: Text("")),
      ),
    );
  }
}
