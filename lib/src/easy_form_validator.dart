import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EasyFormValidator extends StatefulWidget {
  final String? labelText;
  final double widget;
  final TextEditingController controller;
  final String? hintText;
  final bool isPassword;
  final bool isEmail;
  final String validatorText;
  final TextInputType? keyboardType;

  const EasyFormValidator({
    super.key,
    this.hintText,
    required this.isPassword,
    required this.controller,
    required this.validatorText,
    required this.isEmail,
    this.keyboardType,
    required this.widget,
    this.labelText,
  });

  @override
  State<EasyFormValidator> createState() => _EasyFormValidatorState();
}

class _EasyFormValidatorState extends State<EasyFormValidator> {
  bool isHide = true;

  String? validateEmail(String? email) {
    RegExp emailRegex = RegExp(r'^[\w\.-]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
    final isEmailValid = emailRegex.hasMatch(email ?? '');
    if (!isEmailValid) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? password) {
    RegExp passwordRegex =
        RegExp(r'^(?=.*[a-z])(?=.*[A-Z])[A-Za-z\d@$!%*?&]{8,}$');
    final isPasswordValid = passwordRegex.hasMatch(password ?? '');
    if (!isPasswordValid) {
      return 'Password must be at least 8 chars, with uppercase and lowercase letters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.widget,
      child: TextFormField(
        keyboardType: widget.keyboardType,
        style: GoogleFonts.aBeeZee(
            textStyle: const TextStyle(
                fontSize: 12,
                color: Colors.black,
                decoration: TextDecoration.none)),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (widget.isEmail) {
            return validateEmail(widget.controller.text);
          } else if (widget.isPassword) {
            return validatePassword(widget.controller.text);
          } else {
            if (value == null || value.isEmpty) {
              return widget.validatorText;
            } else {
              return null;
            }
          }
        },
        controller: widget.controller,
        obscureText: widget.isPassword && isHide,
        decoration: InputDecoration(
          errorMaxLines: 2,
          labelText: widget.labelText,
          labelStyle: GoogleFonts.aBeeZee(
            textStyle: const TextStyle(
                color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w400),
          ),
          suffixIcon: widget.isPassword
              ? Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isHide = !isHide;
                      });
                    },
                    child: Text(
                      isHide ? "Show" : "Hide",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.aBeeZee(
                        textStyle: const TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                )
              : null,
          hintText: widget.hintText,
          errorStyle: const TextStyle(
            fontSize: 12,
          ),
          hintStyle: GoogleFonts.aBeeZee(
            textStyle: const TextStyle(
                color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w400),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
