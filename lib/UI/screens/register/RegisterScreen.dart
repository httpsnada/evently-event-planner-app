import 'package:evently/UI/common/AppLogo.dart';
import 'package:evently/UI/common/CustomFormField.dart';
import 'package:evently/UI/common/LanguageSwitcher.dart';
import 'package:evently/UI/design/design.dart';
import 'package:evently/UI/provider/AuthenticationProvider.dart';
import 'package:evently/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController rePasswordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Register"),
        automaticallyImplyLeading: false,),

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
                      onPressed: isLoading ? null : () {
                        createAccount();
                      },
                      child: isLoading ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(width: 8,),
                          Text("Creating an account")
                        ],
                      ) :
                      Text("Create Account"),
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
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, AppRoutes.LoginScreen.routeName);
                    },
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

  void createAccount() async {
    if (validateForm() == false) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    AuthenticationProvider provider = Provider.of<AuthenticationProvider>(
        context, listen: false);
    AuthResponse response = await provider.register(
        emailController.text, passwordController.text, nameController.text);
    if (response.success) {
      //create an account
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("User Registered Successfully")));
      Navigator.pushReplacementNamed(context, AppRoutes.HomeScreen.routeName);

    }
    else {
      hangleAuthError(response);
    }
    setState(() {
      isLoading = false;
    });
    //to get a copy of the provider outside of the build function you should use listen: false

    //   try {
    //     final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    //       email: emailController.text,
    //       password: passwordController.text,
    //     );
    //   } on FirebaseAuthException catch (e) {
    //     if (e.code == 'weak-password') {
    //       print('The password provided is too weak.');
    //     } else if (e.code == 'email-already-in-use') {
    //       print('The account already exists for that email.');
    //     }
    //   } catch (e) {
    //     print(e);
    //   }
    // }
  }

  void hangleAuthError(AuthResponse response) {
    if (response.failure == AuthFailure.weakPass) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Weak Password")));
    }
    else if (response.failure == AuthFailure.emailInUse) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Email already in use")));
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Something went wrong")));
    }
  }

  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
    // pass through each field and validate it
  }

}
