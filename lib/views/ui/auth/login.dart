import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_gear_pro/controllers/login_provider.dart';
import 'package:pet_gear_pro/models/auth/login_model.dart';
import 'package:pet_gear_pro/views/shared/app_constants.dart';
import 'package:pet_gear_pro/views/shared/appstyle.dart';
import 'package:pet_gear_pro/views/shared/custom_textfield.dart';
import 'package:pet_gear_pro/views/shared/reusable_text.dart';
import 'package:pet_gear_pro/views/ui/auth/register.dart';
import 'package:pet_gear_pro/views/ui/mainscreen.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  bool validation = false;

  void formValidation() {
    if (email.text.isNotEmpty && password.text.isNotEmpty) {
      validation = true;
    } else {
      validation = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginNotifier>(
      builder: (context, authNotifier, child) {
        return Scaffold(
            appBar: AppBar(
              toolbarHeight: 50,
              backgroundColor: Colors.black,
            ),
            backgroundColor: Colors.black,
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 60.h),
              decoration: const BoxDecoration(image: DecorationImage(opacity: 0.5, image: AssetImage("assets/images/bg.png"))),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ReusableText(text: "Welcome!", style: appstyle(30, Color(kLight.value), FontWeight.w600)),
                  ReusableText(text: "Fill these details to login you account", style: appstyle(16, Color(kLight.value), FontWeight.normal)),
                  const SizedBox(height: 50),
                  CustomTextField(
                      keyboard: TextInputType.emailAddress,
                      hintText: "Email",
                      controller: email,
                      validator: (email) {
                        if (email!.isEmpty || !email.contains("@")) {
                          return "Please enter a valid email address";
                        } else {
                          return null;
                        }
                      }),
                  const SizedBox(height: 20),
                  CustomTextField(
                      keyboard: TextInputType.emailAddress,
                      obscureText: authNotifier.isObsecure,
                      hintText: "Password",
                      controller: password,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          authNotifier.isObsecure = !authNotifier.isObsecure;
                        },
                        child: Icon(
                          authNotifier.isObsecure ? Icons.visibility_off : Icons.visibility,
                          color: Color(kDark.value),
                        ),
                      ),
                      validator: (password) {
                        if (password!.isEmpty || password.length < 7) {
                          return "Please enter a valid password";
                        } else {
                          return null;
                        }
                      }),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupPage()));
                      },
                      child: ReusableText(
                        text: "Register",
                        style: appstyle(14, Color(kLight.value), FontWeight.w500),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  GestureDetector(
                    onTap: () {
                      formValidation();
                      if (validation) {
                        LoginModel model = LoginModel(email: email.text, password: password.text);

                        authNotifier.userLogin(model).then((response) {
                          if (response == true) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Login Successful!'),
                                backgroundColor: Colors.green,
                              ),
                            );
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const MainScreen()));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Failed to login, please retry'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('The form is not valid'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(color: Color(kLight.value), borderRadius: const BorderRadius.all(Radius.circular(12))),
                      child: Center(child: authNotifier.processing ? const CircularProgressIndicator.adaptive() : ReusableText(text: "L O G I N", style: appstyle(18, Colors.black, FontWeight.bold))),
                    ),
                  )
                ],
              ),
            ));
      },
    );
  }
}
