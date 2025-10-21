import 'package:evently/UI/common/AppLogo.dart';
import 'package:evently/UI/common/CustomFormField.dart';
import 'package:evently/UI/common/LanguageSwitcher.dart';
import 'package:evently/UI/design/design.dart';
import 'package:evently/UI/provider/AuthenticationProvider.dart';
import 'package:evently/firestore_service.dart';
import 'package:evently/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Login"),
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

                    SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () {
                              login();
                            },
                      child: isLoading
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(),
                                SizedBox(width: 8),
                                Text("Logging in"),
                              ],
                            )
                          : Text("Log in"),
                    ),

                    SizedBox(height: 12),
                    OutlinedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: AppColors.primary,
                        textStyle: TextStyle(
                          color: AppColors.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                        side: BorderSide(
                          color: AppColors.primary,
                        ),
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                      ),
                      onPressed: () async {
                        var user = await FirestoreService.signInWithGoogle();
                        print(user.user?.displayName);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(AppImages.google, width: 24, fit: BoxFit
                              .cover,),
                          SizedBox(width: 8),
                          Text("Log in with Google",),

                        ],),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Doesn't have an account?",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(width: 4),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.RegisterScreen.routeName,
                      );
                    },
                    child: Text(
                      "Sign Up",
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

  void login() async {
    if (validateForm() == false) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    AuthenticationProvider provider = Provider.of<AuthenticationProvider>(
      context,
      listen: false,
    );
    AuthResponse response = await provider.login(
      emailController.text,
      passwordController.text,
    );
    if (response.success) {
      //create an account
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Logged in Successfully")));
      Navigator.pushReplacementNamed(context, AppRoutes.HomeScreen.routeName);
    } else {
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
    if (response.failure == AuthFailure.invalidCredential) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Wrong Email or Password")));
    }
  }

  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
    // pass through each field and validate it
  }
}
