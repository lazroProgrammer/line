import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:line/core/apis/app/connectivity.dart';
import 'package:line/core/apis/firebase/auth.dart';
import 'package:line/core/controllers/UI/toggle_controller.dart';
import 'package:line/pages/login/signup.dart';
import 'package:line/widgets/frequent_toasts.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _email = TextEditingController();
  final _password = TextEditingController();
  final isHidden = Get.put(ToggleController(false));
  InputDecoration passwordTFDecoration() {
    return InputDecoration(
      border: const OutlineInputBorder(),
      prefixIcon: const Icon(Icons.password),
      hintText: "Password",
      suffixIcon: IconButton(
        onPressed: () {
          isHidden.toggle();
        },
        icon: Obx(() {
          return (isHidden.obj.value)
              ? const Icon(Icons.visibility_off)
              : const Icon(Icons.visibility);
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Login")),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 100,
                      child: Icon(Icons.person, size: 140),
                    ),
                  ),
                  SizedBox(height: 10),
                  Divider(),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _email,
                    validator: (value) {
                      if (value == null || value.trim() == "") {
                        return "you need to fill in this field";
                      }
                      if (!EmailValidator.validate(value.trim())) {
                        return "invalid email";
                      }
                      return null;
                    },
                    decoration: emailTFDecoration(),
                  ),
                  const SizedBox(height: 20),
                  Obx(() {
                    return TextFormField(
                      controller: _password,
                      obscureText: isHidden.obj.value,
                      validator: (value) {
                        if (value == null || value.trim() == "") {
                          return "you need to fill in this field";
                        }
                        if (value.length < 8) {
                          return "password need to be at least 8 caracters";
                        }
                        return null;
                      },
                      decoration: passwordTFDecoration(),
                    );
                  }),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Connection.internetConnection().then((connection) {
                            if (connection) {
                              try {
                                signInWithEmail(
                                  _email.text.trim(),
                                  _password.text.trim(),
                                ).then((value) {});
                              } catch (e) {
                                print(e);
                              }
                            } else {
                              checkConnectionMsg();
                            }
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.all(16),
                          child: const Text("login"),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SignupPage(),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.all(16),
                          child: const Text("signUp"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

InputDecoration emailTFDecoration() {
  return const InputDecoration(
    border: OutlineInputBorder(),
    prefixIcon: Icon(Icons.mail),
    hintText: "Email",
  );
}
