import 'package:cancer_detector/constants/colors.dart';
import 'package:cancer_detector/constants/strings.dart';
import 'package:cancer_detector/screens/home_screen.dart';
import 'package:cancer_detector/screens/register_screen.dart';
import 'package:cancer_detector/utils/indicators.dart';
import 'package:cancer_detector/utils/validator.dart';
import 'package:cancer_detector/widgets/common/common_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../utils/extentions/text_styls.dart';

class LoginScreen extends StatefulWidget {
  static const PAGE_ROUTE = "/loginScreen";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with Validations, Indicators {
  late TextEditingController _emailTextEditingController;
  late TextEditingController _passwordTextEditingController;
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    _emailTextEditingController = TextEditingController();
    _passwordTextEditingController = TextEditingController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    // _checkUserStatus();
  }

  Future _checkUserStatus() async {
    await Future.delayed(Duration(seconds: 2));
    if (_auth.currentUser != null) {
      Navigator.of(context).pushReplacementNamed(HomeScreen.PAGE_ROUTE,
          arguments: _auth.currentUser);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterButtons: const [
        Text(
          "Developed By Eng.Islam",
          style: TextStyle(color: Colors.grey),
        )
      ],
      body: Column(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                  padding: const EdgeInsets.only(bottom: 20),
                  alignment: Alignment.bottomCenter,
                  child: Text(Strings().login).largeHeadline1(context))),
          Expanded(flex: 2, child: _buildFields()),
        ],
      ),
    );
  }

  Widget _buildFields() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CommonTextField(_emailTextEditingController, Strings().email),
          const SizedBox(
            height: 10,
          ),
          CommonTextField(
            _passwordTextEditingController,
            Strings().password,
            isObsecure: true,
          ),
          const SizedBox(
            height: 20,
          ),
          _buildLoginButton(),
          _buildCreateAccountButton()
        ],
      ),
    );
  }

  Widget _buildLoginButton() {
    return InkWell(
      onTap: logUserIn,
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            color: AppColors.mainButtonsColor),
        child: Text(Strings().login)
            .applyColor(textColor: AppColors.mainButtonsLableColor),
      ),
    );
  }

  Widget _buildCreateAccountButton() {
    return TextButton(
        onPressed: () {
          Navigator.of(context).pushReplacementNamed(RegisterScreen.PAGE_ROUTE);
        },
        child: Text(Strings().createAccount));
  }

  void logUserIn() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      var cread = await _auth.signInWithEmailAndPassword(
          email: _emailTextEditingController.text,
          password: _passwordTextEditingController.text);

      Navigator.of(context).pushReplacementNamed(HomeScreen.PAGE_ROUTE,
          arguments: _auth.currentUser);
    } on FirebaseAuthException catch (e) {
      showSnacBarWithMessage(context: context, message: e.toString());
      setState(() {
        _emailTextEditingController.text = "";
        _passwordTextEditingController.text = "";
      });
    }
  }
}
