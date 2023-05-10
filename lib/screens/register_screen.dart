import 'package:cancer_detector/screens/home_screen.dart';
import 'package:cancer_detector/utils/extentions/text_styls.dart';
import 'package:cancer_detector/utils/indicators.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/strings.dart';
import '../widgets/common/common_text_field.dart';

class RegisterScreen extends StatefulWidget {
  static const PAGE_ROUTE = "/registerScreen";
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with Indicators {
  late TextEditingController _emailTextEditingController;
  late TextEditingController _passwordTextEditingController;
  late TextEditingController _displayNameTextEditingController;
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  @override
  void initState() {
    _emailTextEditingController = TextEditingController();
    _passwordTextEditingController = TextEditingController();
    _displayNameTextEditingController = TextEditingController();
    Firebase.initializeApp();
    super.initState();
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
      body: ListView(
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.3,
              padding: EdgeInsets.only(bottom: 20),
              alignment: Alignment.bottomCenter,
              child:
                  Text(Strings().createAccountTitle).largeHeadline1(context)),
          Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: _buildFields()),
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
          CommonTextField(
              _displayNameTextEditingController, Strings().userName),
          const SizedBox(
            height: 10,
          ),
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
          _createAccountButton(),
          _backToLoginButton()
        ],
      ),
    );
  }

  Widget _createAccountButton() {
    return InkWell(
      onTap: _createAccount,
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            color: AppColors.mainButtonsColor),
        child: Text(Strings().createAccountTitle)
            .applyColor(textColor: AppColors.mainButtonsLableColor),
      ),
    );
  }

  Widget _backToLoginButton() {
    return TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text(Strings().haveAccount));
  }

  void _createAccount() async {
    if (!_formKey.currentState!.validate()) return;
    try {
      print("here done before");
      final credential = await _auth.createUserWithEmailAndPassword(
        email: _emailTextEditingController.text,
        password: _passwordTextEditingController.text,
      );
      await db.collection('users').add({
        "Name": _displayNameTextEditingController.text,
        "Email": credential.user!.email
      });
      print("here done ");
      Navigator.of(context).pushReplacementNamed(HomeScreen.PAGE_ROUTE,
          arguments: _auth.currentUser);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print("here done  week password");
        showSnacBarWithMessage(
            context: context, message: Strings().weakPassword);
      } else if (e.code == 'email-already-in-use') {
        print("here done email in use");
        showSnacBarWithMessage(
            context: context, message: Strings().emailAlreadyExists);
      } else {
        print("here done something else");
        showSnacBarWithMessage(context: context, message: e.code);
      }
    } catch (e) {
      print("here done in catch");
      showSnacBarWithMessage(context: context, message: Strings().errorOccured);
    } finally {
      print("here done finally");
      setState(() {
        _displayNameTextEditingController.text = "";
        _passwordTextEditingController.text = "";
        _emailTextEditingController.text = "";
      });
    }
  }
}
