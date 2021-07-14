
import 'package:contacts_2/Services/ContactService.dart';
import 'package:contacts_2/models/ContactInstert.dart';
import 'package:contacts_2/models/SingleContactModel.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:restart_app/restart_app.dart';

class EditContact extends StatefulWidget {
  final String iD;
  EditContact({required this.iD});
  @override
  _EditContactState createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {

  ContactService get contactService => GetIt.instance<ContactService>();
  late SingleContactModel contact;
  String errorMessage = "";


  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Edit a Contact"),),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: isLoading ? Center(child: CircularProgressIndicator(),) : Column(
            children: <Widget>[
              TextFormField(
                autocorrect: false,
                controller: firstNameController,
                decoration: InputDecoration(
                    hintText: "Enter first name",
                    labelText: "First Name"
                ),
              ),
              SizedBox(height: 10.0,),
              TextFormField(
                autocorrect: false,
                controller: lastNameController,
                decoration: InputDecoration(
                    hintText: "Enter last name",
                    labelText: "Last Name"
                ),
              ),
              SizedBox(height: 10.0,),
              TextFormField(
                autocorrect: false,
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
                    final result = await contactService.updateContact(widget.iD,contact);
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text("Notice"),
                          content: Text("Contact has been edited"),
                          actions: <Widget>[
                            TextButton(
                                onPressed: (){
                                  Navigator.of(context).pop();
                                  Restart.restartApp();
                                },
                                child: Text("Ok"))
                          ],
                        )
                    ).then((data) => {
                      if(result.data){
                        Navigator.of(context).pop()
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
