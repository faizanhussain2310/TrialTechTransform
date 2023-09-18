import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:trialtechtransform_app/constants/colors.dart';
import 'package:trialtechtransform_app/constants/size.config.dart';
import 'package:trialtechtransform_app/services/auth.service.dart';
import 'package:trialtechtransform_app/views/authview/auth.view.dart';
import 'dart:ui';

import 'package:trialtechtransform_app/views/authview/otp.scr.dart';
import 'package:trialtechtransform_app/views/authview/signup.view.dart';
import 'package:trialtechtransform_app/views/widgets/custom.widgets.dart';

class SignUpView extends StatefulWidget {
  SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  List<String> list = <String>["UnderTrial", "lawyer"];
  String dropdownValue = "UnderTrial";

  TextEditingController phnCtrl = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: darkBlue,
      body: Stack(
        children: [
          Positioned(
            left: SizeConfig.width / 10,
            top: SizeConfig.height * 0.25,
            child: Align(
              child: Container(
                width: SizeConfig.width / 1.2,
                // height: SizeConfig.height / 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xfff5f5f5),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: SizeConfig.width / 6,
                      ),
                      Text(
                        "Your Role",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DropdownButtonFormField<String>(
                        value: dropdownValue,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            filled: true,
                            fillColor: greybg),
                        icon: const Icon(Icons.arrow_drop_down_rounded),
                        elevation: 16,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 18),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            dropdownValue = value!;
                          });
                        },
                        items:
                            list.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Name",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            hintText: "Enter Your Name",
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(),
                            filled: true,
                            fillColor: greybg,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Phone Number",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: phnCtrl,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            hintText: "Phone Number",
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(),
                            filled: true,
                            fillColor: greybg,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: SizedBox(
                          width: SizeConfig.width / 2,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(darkBlue)),
                              onPressed: () async {
                                if (phnCtrl.text.trim().isEmpty) {
                                  CustomWidget().snackBar(
                                      "Enter Phone Number", context, 500);
                                } else if (phnCtrl.text.trim().length != 10) {
                                  CustomWidget().snackBar(
                                      "Invalid Phone Number", context, 500);
                                } else {
                                  bool checkUTP = await AuthService()
                                      .checkUTP("+91${phnCtrl.text.trim()}");
                                  bool checkLawyer = await AuthService()
                                      .checkLawyer("+91${phnCtrl.text.trim()}");
                                  if (checkLawyer || checkUTP) {
                                    CustomWidget().snackBar(
                                        "Your Account Already Exist",
                                        context,
                                        500);
                                  } else {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => OtpScreen(
                                                  phn: phnCtrl.text.trim(),
                                                  role: dropdownValue,
                                                  name: nameController.text
                                                      .trim(),
                                                  create: true,
                                                )));
                                  }
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                child: Text(
                                  "Create Account",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: Colors.white),
                                ),
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          "OR",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: darkBlue),
                        ),
                      ),
                      Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have Account ?",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => AuthView()),
                                  (route) => false);
                            },
                            child: Text(
                              " Sign in",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: darkBlue,
                                      fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ))
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              // ellipse12gf (11:9)
              left: SizeConfig.width / 3,
              top: SizeConfig.height * 0.15,
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                    color: greybg,
                    shape: BoxShape.circle,
                    border: Border.all(width: 1)),
                child: Image.asset(
                  "assets/images/law.png",
                ),
              ))
        ],
      ),
    );
  }
}
