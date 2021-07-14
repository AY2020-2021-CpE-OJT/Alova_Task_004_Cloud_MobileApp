import 'package:contacts_2/Services/ContactService.dart';
import 'package:contacts_2/Views/DeleteContact.dart';
import 'package:contacts_2/Views/PostContact.dart';
import 'package:contacts_2/models/APIResponse.dart';
import 'package:contacts_2/models/ContactModel.dart';
import 'package:contacts_2/Views/EditContact.dart';
import 'package:flutter/material.dart';
import 'package:restart_app/restart_app.dart';
import 'package:get_it/get_it.dart';



class GetContact extends StatefulWidget {

  @override
  _GetContactState createState() => _GetContactState();
}

class _GetContactState extends State<GetContact> {
  ContactService get service => GetIt.instance<ContactService>();
  late APIResponse<List<ContactModel>> _apiResponse;
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    _fetchContacts();
    super.initState();
  }
  _fetchContacts() async{
    setState(() {
      isLoading = true;
    });
    _apiResponse = await service.getContactList();
    setState(() {
      isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => PostContact()));
          },
          child: Icon(Icons.add),
        ),
        body:  Builder(
          builder: (_){
            if(isLoading){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if(_apiResponse.error){
              return Center(
                child: Text("Error"),
              );
            }
            return ListView.separated(
                itemBuilder: (_, index){
                  return Dismissible(
                    key: ValueKey(_apiResponse.data[index].iD),
                    direction: DismissDirection.startToEnd,
                    onDismissed: (direction){

                    },
                    confirmDismiss: (direction) async{
                      final result = await showDialog(
                          context: context,
                          builder: (_) => DeleteContact());
                      if(result){
                        var message;
                        final deleteResult = await service.deleteContact(_apiResponse.data[index].iD);
                        if(deleteResult.data == true){
                          message = "Contact has been deleted";
                        }else{
                          message = "ERROR";
                        }
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message),duration: new Duration(milliseconds: 1000),));
                        Restart.restartApp();
                        return deleteResult.data;
                      }
                      print(result);
                      return result;
                    },
                    background: Container(
                        color: Colors.red,
                        padding: EdgeInsets.only(left: 15.0),
                        child: Align(
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,),
                          alignment: Alignment.centerLeft,
                        )
                    ),
                    child: ListTile(
                      title: Text(
                        _apiResponse.data[index].lastname,
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      subtitle: Text(
                          _apiResponse.data[index].firstname
                      ),
                      trailing: Text(
                          _apiResponse.data[index].phoneNumber
                      ),
                      onTap: (){
                        Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (data) => EditContact(
                                  iD: _apiResponse.data[index].iD))).then((data) {
                        });
                        print(_apiResponse.data[index].firstname + " " + _apiResponse.data[index].lastname);
                      },
                    ),
                  );
                },
                separatorBuilder: (_,__) => Divider(height: 1, color: Colors.black),
                itemCount: _apiResponse.data.length
            );
          },
        )
    );
  }
}
