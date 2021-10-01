import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:team_up_4_success/utils/authentication.dart';

class AuthDialog extends StatefulWidget {
  @override
  _AuthDialogState createState() => _AuthDialogState();
}
late TextEditingController textControllerEmail;
late TextEditingController textControllerPassword;
late FocusNode textFocusNodeEmail;
late FocusNode textFocusNodePassword;
bool _isEditingEmail = false;
bool _isRegistering = false;

@override
void initState() {
  textControllerEmail = TextEditingController();
  textControllerEmail.text = '';
  textControllerPassword = TextEditingController();
  textControllerPassword.text = '';
  textFocusNodeEmail = FocusNode();
  textFocusNodePassword = FocusNode();
  initState();
}

String? _validateEmail(String value) {
  value = value.trim();

  if (textControllerEmail.text.isNotEmpty) {
    if (value.isEmpty) {
      return 'Email can\'t be empty';
    } else if (!value.contains(RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
      return 'Enter a correct email address';
    }
  }

  return null;
}


class _AuthDialogState extends State<AuthDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      // ...
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Email address'),
                TextField(
                  focusNode: textFocusNodeEmail,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  controller: textControllerEmail,
                  autofocus: false,
                  onChanged: (value) {
                    setState(() {
                      _isEditingEmail = true;
                    });
                  },
                  onSubmitted: (value) {
                    textFocusNodeEmail.unfocus();
                    FocusScope.of(context).requestFocus(textFocusNodePassword);
                  },
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.blueGrey[800]!,
                        width: 3,
                      ),
                    ),
                    filled: true,
                    hintStyle: new TextStyle(
                      color: Colors.blueGrey[300],
                    ),
                    hintText: "Email",
                    fillColor: Colors.white,
                    errorText: _isEditingEmail
                        ? _validateEmail(textControllerEmail.text)
                        : null,
                    errorStyle: TextStyle(
                      fontSize: 12,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
                Text('Password'),
                TextField(
                  focusNode: textFocusNodeEmail,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  controller: textControllerEmail,
                  autofocus: false,
                  onChanged: (value) {
                    setState(() {
                      _isEditingEmail = true;
                    });
                  },
                  onSubmitted: (value) {
                    textFocusNodeEmail.unfocus();
                    FocusScope.of(context).requestFocus(textFocusNodeEmail);
                  },
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.blueGrey[800]!,
                        width: 3,
                      ),
                    ),
                    filled: true,
                    hintStyle: new TextStyle(
                      color: Colors.blueGrey[300],
                    ),
                    hintText: "Pasword",
                    fillColor: Colors.white,
                    errorText: _isEditingEmail
                        ? _validateEmail(textControllerEmail.text)
                        : null,
                    errorStyle: TextStyle(
                      fontSize: 12,
                      color: Colors.redAccent,
                    ),
                  ),
                )
                ,Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                        width: double.maxFinite,
                        child: TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.blueGrey.shade800,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: () async {
                              setState(() {
                                _isRegistering = true;
                              });
                              await registerWithEmailPassword(
                                  textControllerEmail.text,
                                  textControllerPassword.text)
                                  .then((result) {
                                if (result != null) {
                                  setState(() {
                                    var loginStatus =
                                    'You have registered successfully';
                                  });
                                  print(result);
                                }
                              }).catchError((error) {
                                print('Registration Error: $error');
                                setState(() {
                                  var loginStatus =
                                  'Error occured while registering';
                                  ;
                                });
                              });

                              setState(() {
                                _isRegistering = false;
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 15.0,
                                bottom: 15.0,
                              ),
                              child: _isRegistering
                                  ? SizedBox(
                                height: 16,
                                width: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor:
                                  new AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                                  : Text(
                                'Sign up',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                      )
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
