import 'package:evently/UI/common/AppLogo.dart';
import 'package:evently/UI/common/CustomFormField.dart';
import 'package:evently/UI/common/LanguageSwitcher.dart';
import 'package:evently/UI/design/design.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Register")),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppImages.logo, width: 136, height: 141),
              Center(child: AppLogo()),

              SizedBox(height: 16),

              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomFormField(
                      labelText: "Name",
                      prefixIcon: Icons.person,
                      keyboardType: TextInputType.name,
                      validator: (text) {
                        if (text?.trim().isEmpty == true) {
                          return "Please enter your name";
                        }
                        return null;
                      },
                      controller: nameController,
                    ),

                    CustomFormField(
                      labelText: "Email",
                      prefixIcon: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                      validator: (text) {
                        final emailRegex = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                        );
                        if (text?.trim().isEmpty == true) {
                          return "Please enter a valid email address";
                        }
                        if (!emailRegex.hasMatch(text!)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      controller: emailController,
                    ),

                    CustomFormField(
                      labelText: "Password",
                      prefixIcon: Icons.lock,
                      isPassword: true,
                      validator: (text) {
                        if (text?.trim().isEmpty == true) {
                          return "Please enter a password";
                        }
                        if (text!.length < 6) {
                          return "Password must be at least 6 characters";
                        }
                        return null;
                      },
                      controller: passwordController,
                    ),

                    CustomFormField(
                      labelText: "Re Password",
                      prefixIcon: Icons.lock,
                      isPassword: true,
                      validator: (text) {
                        if (text?.trim().isEmpty == true) {
                          return "Please enter a password";
                        }
                        if (text!.length < 6) {
                          return "Password must be at least 6 characters";
                        }
                        if (passwordController.text != text) {
                          return "Passwords do not match";
                        }
                        return null;
                      },
                      controller: rePasswordController,
                    ),

                    SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        createAccount();
                      },
                      child: Text("Create Account"),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(width: 4),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Login",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 12),

              LanguageSwitcher(),
            ],
          ),
        ),
      ),
    );
  }

  void createAccount() {
    if (validateForm() == false) {
      return;
    }
  }

  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
    // pass through each field and validate it
  }
}
