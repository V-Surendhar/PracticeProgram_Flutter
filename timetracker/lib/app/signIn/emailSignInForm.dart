import 'package:flutter/material.dart';
import 'package:timetracker/CustomWIdgets/formSubmitButton.dart';
import 'package:timetracker/app/signIn/validators.dart';
import 'package:timetracker/services/auth.dart';




enum EmailSignInFormType{ signIn , register }

class EmailSignInForm extends StatefulWidget with EmailAndPasswordValidator{

  EmailSignInForm({Key? key, required this.auth});

  final AuthBase auth;



  @override
  State<EmailSignInForm> createState() => _EmailSignInFormState();

}

class _EmailSignInFormState extends State<EmailSignInForm> {


  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  EmailSignInFormType _formType = EmailSignInFormType.signIn;

  void _toggleFormType() {

    setState(() {
      _formType = _formType == EmailSignInFormType.signIn ?
          EmailSignInFormType.register : EmailSignInFormType.signIn;
          submittedOnce = false;
    });
    _emailController.clear();
    _passwordController.clear();

  }

  String get _email => _emailController.text;
  String get _password => _passwordController.text;

  bool submittedOnce =false;
  bool _isLoading = false;

  void _submit() async{

print("Submit called");  
      setState(() {
      submittedOnce = true;
      _isLoading = true;
      });
      try {
      
      if (_formType == EmailSignInFormType.signIn) {
      await widget.auth.signInWithEmailAndPassword(_email, _password);
      }
      else {
      await widget.auth.createUserWithEmailPassword(_email, _password);
      }

      Navigator.of(context).pop();
      }
      catch(e){

        print(e.toString());
      }
      finally{
        
        setState((){
          
          _isLoading = false;
          
        });
        
       
      }

      
  }

  void _emailEditingComplete(){
    final newFocus = widget.emailValidator.isValid(_email) ? _passwordFocusNode : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

void _updateState(){
    setState(() {

    });
}


  List<Widget> _buildChildren(){

   
    final primaryText = _formType == EmailSignInFormType.signIn ?
        "Sign in" : "Create an account";

    final secondaryText = _formType ==EmailSignInFormType.signIn ?
        "Need an account? Register" : "Have an account? Sign in";



    bool _submitEnable = widget.emailValidator.isValid(_email) &&
                          widget.passwordValidator.isValid(_password) && !_isLoading;


    bool emailValid = widget.emailValidator.isValid(_email);
    bool passwordValid = widget.passwordValidator.isValid(_password);

    return [


    TextField(
      focusNode: _emailFocusNode,
      textInputAction: TextInputAction.next,
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      controller:  _emailController,
      decoration: InputDecoration(
        errorText: !emailValid && submittedOnce ? widget.inValidEmailErrorText : null,
        labelText: "Email",
        hintText: "test@test.com",
        enabled:  _isLoading == false,
      ),
      onEditingComplete: _emailEditingComplete,
      onChanged: (email){_updateState();},
    ),

      SizedBox(
        height: 8.0,
      ),

      TextField(
        focusNode: _passwordFocusNode,
        textInputAction: TextInputAction.done,
        autocorrect: false,
        controller: _passwordController,
        obscureText: true,
        decoration: InputDecoration(
          labelText: "Password",
          errorText: !passwordValid && submittedOnce ? widget.inValidPasswordErrorText :null ,
          enabled:  _isLoading == false,
        ),
        onEditingComplete: _submit,
        onChanged: (password){_updateState();},
      ),

      SizedBox(
        height: 8.0,
      ),

      FormSubmitButton(onPressed: _submitEnable ? _submit : null ,text: primaryText),

      SizedBox(
        height: 8.0,
      ),

      TextButton(onPressed: !_isLoading ? _toggleFormType :null , child: Text(secondaryText),)


    ];

  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: _buildChildren(),
        ),
      ),
    );




  }







}