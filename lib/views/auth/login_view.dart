import 'package:attendx/controllers/auth_controller.dart';
import 'package:attendx/views/auth/auth_wapper_view.dart';
import 'package:attendx/views/widgets/text_field_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isPasswordShown = true;

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Provider.of<AuthController>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 60,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "ATTEND KCU",
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                              fontWeight: FontWeight.w400,
                              color: Color(0xff023768),
                              fontSize: 15),
                        ),
                        Text(
                          "Attendance Monitor",
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff023768),
                              fontSize: 18),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.login),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                height: 500,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xff021D49), Color(0xff023768)]),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    )),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Signin Information",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Email",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 17),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextFieldWidget(
                            child: TextFormField(
                              controller: _emailController,
                              style: const TextStyle(fontSize: 17),
                              cursorColor: Colors.blue,
                              decoration: const InputDecoration(
                                icon: Icon(
                                  Icons.person,
                                  color: Colors.blue,
                                ),
                                hintText: "Enter Email Address",
                                border: InputBorder.none,
                              ),
                              validator: (String? val) {
                                final bool isValid =
                                    EmailValidator.validate(val!.trim());
                                if (isValid == false) {
                                  return "Enter Valid Email Address";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Password",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 17),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextFieldWidget(
                            child: TextFormField(
                              controller: _passwordController,
                              style: const TextStyle(fontSize: 17),
                              cursorColor: Colors.blue,
                              obscureText: isPasswordShown,
                              decoration: InputDecoration(
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isPasswordShown = !isPasswordShown;
                                    });
                                  },
                                  child: Icon(Icons.visibility),
                                ),
                                hintText: "Enter Password",
                                icon: Icon(
                                  Icons.lock,
                                  color: Colors.blue,
                                ),
                                border: InputBorder.none,
                              ),
                              validator: (String? val) {
                                if (val!.trim().length < 7) {
                                  return "Enter Valid Password";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Forgot Password?",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 18),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      authController.isLoading
                          ? Container(
                              alignment: Alignment.center,
                              height: 52,
                              decoration: BoxDecoration(
                                  color: Color(0xffED4900),
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ))
                          : GestureDetector(
                              onTap: () async {
                                FocusScopeNode currentFocus =
                                    FocusScope.of(context);
                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }

                                bool formValid =
                                    _formKey.currentState!.validate();
                                if (formValid == false) {
                                  return;
                                }

                                bool result = await authController.primaryLogin(
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim());

                                if (result == true) {
                                  Get.offAll(() => const AuthWrapperView());
                                }
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  height: 52,
                                  decoration: BoxDecoration(
                                      color: Color(0xffED4900),
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  child: const Text(
                                    "Sign in",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  )),
                            ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
