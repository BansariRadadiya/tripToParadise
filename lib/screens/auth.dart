import 'signin.dart';
import 'signup.dart';
import 'package:flutter/cupertino.dart';


class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) => isLogin
      ? SignIn(
        )
      : SignUp(onClickdSignIn: toggle);
  void toggle() => setState(() => isLogin = !isLogin);
}
