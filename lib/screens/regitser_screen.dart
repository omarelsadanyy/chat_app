import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegitserScreen extends StatefulWidget {
  RegitserScreen({super.key});
  static String id = 'RegitserScreen';

  @override
  State<RegitserScreen> createState() => _RegitserScreenState();
}

class _RegitserScreenState extends State<RegitserScreen> {
  String? email;

  String? password;

   bool isLoading = false;
   bool isPasswordVisible = false;
  GlobalKey<FormState> formkey=GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD( 
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kprimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9),
          child: Form(
            key: formkey,
            child: ListView(
              children: [
                 SizedBox(height: 60,),
                Image.asset('assets/images/scholar.png',
                height: 100,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Scholar Chat',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontFamily: 'pacifico',
                      ),
                    ),
                  ],
                ),
               SizedBox(height: 50,),
                Row(
                  children: [
                    Text(
                      'Register',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                CustomFieldTextField(
                  onChanged: (data) {
                    email = data;
                  },
                  hintText: 'Enter your email',
                ),
                SizedBox(height: 10),
                 CustomFieldTextField(
                  obscureText: isPasswordVisible,
                  onChanged: (data) {
                    password = data;
                  },
                  hintText: 'Enter your password',
                  decoration :InputDecoration(
                    hintText: 'Enter your password',
                    hintStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                    ),
                  )
                ),
                SizedBox(height: 20),
                CustomButton(
                  text: 'Register',
                  onTap: () async {
      if (formkey.currentState!.validate()) {
        if (email != null && password != null) {
          isLoading = true;
          setState(() {});
          try {
            await registerUser();
            Navigator.pushNamed(context, ChatScreen.id,
                arguments: email);
          } on FirebaseAuthException catch (e) {
            if (e.code == 'weak-password') {
              showSnackBar(context, 'The password provided is too weak.');
            } else if (e.code == 'email-already-in-use') {
              showSnackBar(context, 'The account already exists for that email.');
            }
          }
          isLoading = false;
          setState(() {});
        } else {
          showSnackBar(context, 'Please fill in all fields.');
        }
      }
                  },
                  
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        ' Login',
                        style: TextStyle(
                          color: Color(0xffc7ede6),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
            
              ],
            ),
          ),
        ),
      ),
    );
  }

  

  Future<void> registerUser() async {
     await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
          email: email!.trim(),
          password: password!.trim(),
        );
  }
}