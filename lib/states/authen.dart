import 'package:flutter/material.dart';
import 'package:officesv/utility/my_constant.dart';
import 'package:officesv/utility/my_dialog.dart';
import 'package:officesv/widgets/show_button.dart';
import 'package:officesv/widgets/show_image.dart';
import '../widgets/show_form.dart';
import '../widgets/show_text.dart';

class Authen extends StatefulWidget {
  const Authen({
    Key? key,
  }) : super(key: key);

  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  String? user, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
        behavior: HitTestBehavior.opaque,
        child: Container(
          decoration: MyConstant().painBox(),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                newImage(),
                // ignore: prefer_const_constructors
                newAppName(),

                newUser(),
                newPassword(),
                newLogin()
              ],
            ),
          ),
        ),
      ),
    );
  }

  ShowButton newLogin() {
    return ShowButton(
      label: 'Login',
      pressFunc: () {
        print('user = $user, password = $password');
      
      if ((user?.isEmpty ?? true) || (password?.isEmpty ?? true)) {
        print('Have Space');
        MyDialog(context: context).normalDialog('Have Space', 'Please Fill Every Blank');
      } else {
        print('No Space');
      }
      
      
      },
    );
  }

  Showform newPassword() {
    return Showform(
      label: 'Password :',
      icondata: Icons.lock_outline,
      sccuText: true,
      changeFunc: (String string) {
        password = string.trim();
      },
    );
  }

  Showform newUser() {
    return Showform(
      label: 'User :',
      icondata: Icons.perm_identity,
      changeFunc: (String string) {
        user = string.trim();
      },
    );
  }

  ShowText newAppName() {
    return ShowText(
      label: MyConstant.appName,
      textStyle: MyConstant().h2Style(),
    );
  }

  SizedBox newImage() {
    return const SizedBox(
      width: 250,
      child: ShowImage(),
    );
  }
}
