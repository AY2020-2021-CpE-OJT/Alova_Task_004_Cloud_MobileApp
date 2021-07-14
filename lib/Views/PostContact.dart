
import 'package:contacts_2/Services/ContactService.dart';
import 'package:contacts_2/models/ContactInstert.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:restart_app/restart_app.dart';

class PostContact extends StatefulWidget {
  @override
  _PostContactState createState() => _PostContactState();
}

class _PostContactState extends State<PostContact> {
  ContactService get contactService => GetIt.instance<ContactService>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Create a Contact"),),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: firstNameController,
                decoration: InputDecoration(
                    hintText: "Enter first name",
                    labelText: "First Name"
                ),
              ),
              SizedBox(height: 10.0,),
              TextFormField(
                controller: lastNameController,
                decoration: InputDecoration(
                    hintText: "Enter last name",
                    labelText: "Last Name"
                ),
              ),
              SizedBox(height: 10.0,),
              TextFormField(
                controller: phoneNumberController,
                decoration: InputDecoration(
                    hintText: "Enter phone number",
                    labelText: "Phone Number"
                ),
              ),
              SizedBox(height: 30.0,),
              SizedBox(
                width: double.infinity, height: 40.0,
                child: ElevatedButton(
                  child: Text(
                      "Submit"
                  ),
                  onPressed: () async{
                    final contact = ContactInsert(
                        firstname: firstNameController.text,
                        lastname: lastNameController.text,
                        phoneNumber: phoneNumberController.text);
                    final result = await contactService.createContact(contact);
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text("Notice"),
                          content: Text("Contact has been added"),
                          actions: <Widget>[
                            TextButton(
                                onPressed: (){
                                  Navigator.of(context).pop();
                                  Restart.restartApp();
                                },
                                child: Text("Ok"))
                          ],
                        )
                    ).then((data){
                      if(result.data){
                        Navigator.of(context).pop();
                      }
                    });
                  },
                ),
              )
            ],
          ),
        )
    );
  }
}
