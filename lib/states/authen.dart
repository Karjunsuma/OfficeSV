import 'package:flutter/material.dart';
import 'package:officesv/utility/my_constant.dart';
import 'package:officesv/widgets/show_button.dart';
import 'package:officesv/widgets/show_image.dart';
import '../widgets/show_form.dart';
import '../widgets/show_text.dart';

class Authen extends StatelessWidget {
  const Authen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              newImage(),
              // ignore: prefer_const_constructors
              newAppName(),

              newUser(),
              newPassword(),
              ShowButton(label: 'Login',)
            ],
          ),
        ),
      ),
    );
  }

  Showform newPassword() {
    return Showform(
              label: 'Password :',
              icondata: Icons.lock_outline,
              sccuText: true,
            );
  }

  Showform newUser() {
    return Showform(
              label: 'User :',
              icondata: Icons.perm_identity,
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
