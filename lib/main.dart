import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
void main() {
  runApp(
      MaterialApp(
        home: MyApp(),
      )
  );
}

class MyApp extends StatefulWidget{

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final LocalAuthentication auth = LocalAuthentication();

  String msg = "You are not authorized.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:Text("Fingerprint/Face Scan/Pin/Pattern Authenciation"),
          backgroundColor: Colors.purple,
        ),
        body: Container(
          margin: EdgeInsets.only(top:50),
          alignment: Alignment.center,
          child: Column(
            children: [
              Center(
                child: Text(msg),
              ),
              Divider(),
              ElevatedButton(
                  onPressed:() async {
                    try {
                      bool hasbiometrics = await auth.canCheckBiometrics; //check if there is authencations,

                      if(hasbiometrics){
                        List<BiometricType> availableBiometrics = await auth.getAvailableBiometrics();
                        if (Platform.isIOS) {
                          if (availableBiometrics.contains(BiometricType.face)) {

                            bool pass = await auth.authenticate(
                                localizedReason: 'Authenticate with fingerprint',
                                );

                            if(pass){
                              msg = "You are Autenciated.fing ";
                              setState(() {

                              });
                            }

                          }
                        }else{
                          if (availableBiometrics.contains(BiometricType.fingerprint)) {

                            bool pass =await auth.authenticate(localizedReason: "Authenticate with fingerprint/face");
                            /*bool pass = await auth.authenticate(
                                localizedReason: 'Authenticate with fingerprint/face',
                                biometricOnly: true );*/
                            if(pass){
                              msg = "You are Authenicated.fing";
                              setState(() {

                              });
                            }
                          }
                          else
                          {
                            print("error fingerprint");
                          }
                        }
                      }else{
                        msg = "You are not alowed to access biometrics.";
                        setState(() {

                        });
                      }


                    } on PlatformException catch (e) {
                      print("error come $e");
                      msg = "Error while opening fingerprint/face scanner";
                    }

                  },
                  child: Text("Authenticate with Fingerprint/Face Scan")
              ),


              ElevatedButton(
                  onPressed:() async {
                    try {
    bool pass =await auth.authenticate(localizedReason: "Authenticate with fingerprint/face");

                    /*  bool pass = await auth.authenticate(
                          localizedReason: 'Authenticate with pattern/pin/passcode',
                          biometricOnly: false );*/
                      if(pass){
                        msg = "You are Authenticated.";
                        setState(() {

                        });
                      }

                    } on PlatformException catch (e) {
                      print("error come $e");
                      msg = "Error while opening fingerprint/face scanner";
                    }

                  },
                  child: Text("Authenticate with Pin/Passcode/Pattern Scan")
              ),
            ],

          ),
        )
    );
  }
}