import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phone_authentication/pages/color.dart';
import 'package:phone_authentication/pages/otp.dart';

class PhonePage extends StatefulWidget {
  const PhonePage({Key? key}) : super(key: key);
  static String verify = "";

  @override
  State<PhonePage> createState() => _PhoneState();
}

class _PhoneState extends State<PhonePage> {
  TextEditingController countrycode = TextEditingController();
  var phone = "";

  @override
  void initState() {
    // TODO: implement initState
    countrycode.text = "+91";
    super.initState();
  }

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
              child: TextField(
                onChanged: (value) {
                  phone = value;
                },
                controller: countrycode,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  // hintText: '0000000000',
                  //prefixText: '91+ ',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                keyboardType: TextInputType.phone,
                //maxLength: 10,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              child: GestureDetector(
                onTap: () async {
                  // Combine country code and phone number
                  String phoneNumber = phone;

                  // Remove any spaces or special characters from the phone number
                  phoneNumber = phoneNumber.replaceAll(RegExp(r'\s+'), '');

                  try {
                    // Verify phone number
                    await FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber: phoneNumber,
                      verificationCompleted:
                          (PhoneAuthCredential credential) {},
                      verificationFailed: (FirebaseAuthException e) {},
                      codeSent: (String verificationId, int? resendToken) {
                        PhonePage.verify = verificationId;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => const OtpPage()));
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {},
                    );
                  } catch (e) {
                    // Handle verification error
                    print("Phone verification error: $e");
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
                    "Send the OTP >",
                    style: TextStyle(
                      color: white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
