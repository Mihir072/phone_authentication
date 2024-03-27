import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phone_authentication/pages/color.dart';
import 'package:phone_authentication/pages/home.dart';
import 'package:phone_authentication/pages/phone.dart';
import 'package:pinput/pinput.dart';
import 'package:velocity_x/velocity_x.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({Key? key}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  var code = "";
  var value = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(),
              child: Image.asset('assets/images/flower.png'),
            ),
            // Image.asset('assets/image/flower.jpg'),
            const Padding(
              padding: EdgeInsets.only(
                top: 20,
              ),
              child: Text(
                "Phone Verification",
                textAlign: TextAlign.center,
                textScaler: TextScaler.linear(1.5),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                top: 2,
              ),
              child: Text(
                "We need register your phone befor getting\n started!",
                textAlign: TextAlign.center,
                //textScaler: TextScaler.linear(1.5),
                style: TextStyle(fontWeight: FontWeight.bold, color: txtcolor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
              child: Pinput(
                length: 6,
                showCursor: true,
                onChanged: (value) {
                  code = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              child: GestureDetector(
                onTap: () async {
                  try {
                    PhoneAuthCredential credential =
                        PhoneAuthProvider.credential(
                            verificationId: PhonePage.verify, smsCode: code);

                    // Sign the user in (or link) with the credential
                    await auth.signInWithCredential(credential);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => const HomePage()));
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: "Invailid OTP".text.bold.center.make()));
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 12.0,
                  ),
                  decoration: BoxDecoration(
                    color: green,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Text(
                    "Verify your number",
                    style: TextStyle(
                      color: white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => const PhonePage()));
              },
              child: const Text(
                'Edit your number?',
                style: TextStyle(color: txtcolor),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
