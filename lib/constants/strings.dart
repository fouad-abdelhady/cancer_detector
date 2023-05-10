class Strings {
  static final _strings = Strings._internal();
  factory Strings() => _strings;
  Strings._internal();
  final analyse = "Analyse";
  final selectAnotherImage = "select another image";
  final createAccount = "Don't you have Account?";
  final haveAccount = "Do you have Account?";
  final loginError = "Wrong user name or password";
  final userName = "User Name";
  final email = "Email";
  final aboutBreastCancer = "About Breast Cancer";
  final password = "Password";
  final createAccountTitle = "Create Account";
  final login = "LOGIN";
  final logOut = "Logout";
  final emptyTextField = "Required Field";
  final invalidEmail = "Invalid Invalid Email";
  final invalidDisplayName = "Invalid display name";
  final weakPassword = "The password provided is too weak.";
  final emailAlreadyExists = 'The account already exists for that email.';
  final errorOccured = "Error Occured, Please try again";
  String getWellcome(String name) => "Welcome $name,";
}
