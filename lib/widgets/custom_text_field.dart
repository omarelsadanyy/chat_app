import 'package:flutter/material.dart';

class CustomFieldTextField extends StatelessWidget {
    CustomFieldTextField({ this.hintText, this.onChanged, this.obscureText=false, this.decoration});
  final String? hintText ;
  Function(String)? onChanged;
  bool? obscureText;
  InputDecoration? decoration;
  @override
  Widget build(BuildContext context) {
      return TextFormField( 
        obscureText: obscureText!,
        validator: (data){
          if(data!.isEmpty){
            return 'Field is required';
          }
        },
        onChanged: onChanged, 
            decoration: decoration ?? InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.white),
              enabledBorder: OutlineInputBorder(
               borderSide: BorderSide(color: Colors.white)
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white)
              )
            ),
          );
  }
}