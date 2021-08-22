import 'package:base_caller/utils/routes.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  bool changedButton = false;
  TextEditingController tokenController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  moveToMain(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        changedButton = true;
      });
      await Future.delayed(Duration(seconds: 1));
      await Navigator.pushNamed(context, MyRoutes.homeRoute,
          arguments: tokenController.text);
      setState(() {
        changedButton = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 150),
              Text("Welcome",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: 50),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                child: Column(
                  children: [
                    TextFormField(
                      controller: tokenController,
                      decoration: InputDecoration(
                        hintText: "Truecaller Auth Token",
                        labelText: "Token",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Token cannot be empty";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 40),
                    Material(
                      color: Colors.blueAccent,
                      borderRadius:
                          BorderRadius.circular(changedButton ? 40 : 8),
                      child: InkWell(
                        onTap: () => moveToMain(context),
                        child: AnimatedContainer(
                          duration: Duration(seconds: 1),
                          width: changedButton ? 40 : 120,
                          height: 40,
                          alignment: Alignment.center,
                          child: changedButton
                              ? Icon(Icons.done)
                              : Text(
                                  "Next",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
