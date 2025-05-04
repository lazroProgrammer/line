import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:line/core/apis/app/connectivity.dart';
import 'package:line/core/apis/firebase/auth.dart';
import 'package:line/core/controllers/UI/toggle_controller.dart';
import 'package:line/widgets/frequent_toasts.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SignupPage> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final isHidden = Get.put(ToggleController(false));
  InputDecoration nameTFDecoration() {
    return const InputDecoration(
      border: OutlineInputBorder(),
      prefixIcon: Icon(Icons.person),
      hintText: "Name",
    );
  }

  InputDecoration emailTFDecoration() {
    return const InputDecoration(
      border: OutlineInputBorder(),
      prefixIcon: Icon(Icons.mail),
      hintText: "Email",
    );
  }

  InputDecoration phoneTFDecoration() {
    return const InputDecoration(
      border: OutlineInputBorder(),
      prefixIcon: Icon(Icons.phone),
      hintText: "Phone",
    );
  }

  InputDecoration currencyTFDecoration() {
    return const InputDecoration(
      border: OutlineInputBorder(),
      prefixIcon: Icon(Icons.currency_exchange),
      hintText: "Currency",
    );
  }

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

  InputDecoration confirmPasswordTFDecoration() {
    return InputDecoration(
      border: const OutlineInputBorder(),
      prefixIcon: const Icon(Icons.password),
      hintText: "Confirm password",
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
        appBar: AppBar(title: Text("Signup")),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 100,
                      child: Icon(Icons.person, size: 140),
                    ),
                  ),
                  Divider(),
                  SizedBox(height: 10),
                  SizedBox(
                    child: TextFormField(
                      controller: _name,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.trim() == "") {
                          return "you need to fill in this field";
                        }
                        // if ()) {
                        //   return "invalid name";
                        // }
                        return null;
                      },
                      decoration: nameTFDecoration(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
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
                  Obx(() {
                    return TextFormField(
                      controller: _confirmPassword,
                      obscureText: isHidden.obj.value,
                      validator: (value) {
                        if (value == null || value.trim() == "") {
                          return "you need to fill in this field";
                        }
                        if (value.length < 8) {
                          return "password need to be at least 8 caracters";
                        }
                        if (value != _password.text) {
                          return "wrong password";
                        }
                        return null;
                      },
                      decoration: confirmPasswordTFDecoration(),
                    );
                  }),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      final valid = formKey.currentState!.validate();
                      if (valid) {
                        Connection.internetConnection().then((
                          connection,
                        ) async {
                          if (connection) {
                            final v = await signUpWithEmail(
                              _email.text,
                              _password.text,
                            );
                            Fluttertoast.showToast(msg: v.toString());
                            // await User.signup(
                            //   _name.text.trim(),
                            //   _email.text.trim(),
                            //   _password.text,
                            //   _phone.text,
                            // );
                          } else {
                            checkConnectionMsg();
                          }
                        });
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.all(16),
                      child: const Text("SignUp"),
                    ),
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
