

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loginscreen/Loginscreen.dart';
import 'package:http/http.dart' as http;
import 'package:loginscreen/Api.dart';
import 'package:loginscreen/Model.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  final TextEditingController _emailController =TextEditingController();
  final TextEditingController _nameController =TextEditingController();
  final TextEditingController _passController =TextEditingController();



  final _formkeyemail = GlobalKey<FormState>();
  final _formkeyname = GlobalKey<FormState>();
  final _formkeypass = GlobalKey<FormState>();


  ValiduserEmail() async{
    try{
      print("this response of try email is runng");
      var response = await http.post(Uri.parse(Api.validateEmail),
        body: {
        'user_email' : _emailController.text,
        },
      );
      print("the 1 try runned now if block");
      if(response.statusCode == 200){
        print("status code recieved 200 ");


        var resbodyofemail = jsonDecode(response.body);


        if(resbodyofemail['emailfound'] == true){
          print("resbodyofemail working");
          Fluttertoast.showToast(msg: "Email is already Created");
        }
        else{
          saveuserDetail();
        }
      }
    }
        catch(e){
      // print(e.toString() + "this is response error");
          Fluttertoast.showToast(msg: e.toString());
        }
  }

  saveuserDetail() async{
    User userModel = User(1, _nameController.text.trim(), _emailController.text.trim(), _passController.text.trim());
    print('Usermodel done');
    try {
      print("this responsed of try user is runng");
      var responsed = await http.post(
          Uri.parse(Api.signup),
          body: userModel.toJson()
      );
         print("try user completed");
         if(responsed.statusCode == 200 ){
           print("userdetail status ocde == 200");
           var responseofsignup = jsonDecode(responsed.body);

           if(responseofsignup['success'] == true){
              Fluttertoast.showToast(msg: "Account Created Successfully");
              print("this response of signup is runng");
           }
            else{
              Fluttertoast.showToast(msg: "Error Occured");
              print("this response of signup else is runng");
            }
         }

    }
        catch(e){
          Fluttertoast.showToast(msg: e.toString());
        }
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children:  [
            const SizedBox(
              height: 150,
            ),
            const Center(
              child: Text(
                "Signup",
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Enter your Credentials',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.circular(25)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Form(
                    key: _formkeyemail,
                    child: TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if(value == null || value.isEmpty){
                          return "Please Enter Email";
                        }
                        return null;
                      },
                      decoration:  InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(
                          Icons.email_rounded,
                          color: Colors.amber,
                        ),
                        hintText: "Email",


                      ),
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.circular(25)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Form(
                    key: _formkeyname,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _nameController,
                      validator: (value) {
                        if(value == null || value.isEmpty){
                          return "Please Enter Name";
                        }
                        return null;
                      },
                      decoration:  InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Colors.amber,
                        ),
                        hintText: "Name",
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.circular(25)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Form(
                    key: _formkeypass,
                    child: TextFormField(
                      controller: _passController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if(value == null || value.isEmpty){
                          return "Please Enter Password";
                        }
                        return null;
                      },
                      decoration:  InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.amber,
                        ),
                        hintText: "Password",
                        suffixIcon: IconButton(onPressed: (){}, icon: const Icon(Icons.visibility, color: Colors.grey)),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 50,),
            ElevatedButton(
              onPressed: (){
              if( _formkeyname.currentState!.validate() && _formkeyemail.currentState!.validate()  && _formkeypass.currentState!.validate()){
                // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('OK')));
                ValiduserEmail();
              }

              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                fixedSize: const Size(200, 50),
                elevation: 16,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                  side: BorderSide.none,
                ),
              ),
              child: const Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                  )
              ),
            ),

            const SizedBox(
              height: 25,
            ),

            TextButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Login()));
            }, child: const Text("Sign in")),


          ],
        ),
      ),
    );
  }
}
