import 'dart:convert';

import 'package:contacts_2/models/APIResponse.dart';
import 'package:contacts_2/models/ContactInstert.dart';
import 'package:contacts_2/models/ContactModel.dart';
import 'package:contacts_2/models/SingleContactModel.dart';
import 'package:http/http.dart' as http;

class ContactService{
  final String apiGet = 'https://alova-ecpe407-task004.herokuapp.com/phone';
  final contacts = <ContactModel>[];

  //GET LIST OF CONTACTS
  Future<APIResponse<List<ContactModel>>> getContactList(){
    return http.get(Uri.parse(apiGet))
        .then((data) {
      if(data.statusCode == 200){
        final jsonData = jsonDecode(data.body);
        for(var item in jsonData){
          contacts.add(ContactModel.fromJson(item));
        }
        return APIResponse<List<ContactModel>>(data: contacts, error: false);
      }
      return APIResponse<List<ContactModel>>(data: contacts, error: true);
    }).catchError((_) => APIResponse<List<ContactModel>>(data: contacts,error: true));
  }

  //GET SINGLE CONTACT
  Future<APIResponse<SingleContactModel>> getSingleContact(String _id){
    var jsonData1;
    print(apiGet + _id);
    return http.get(Uri.parse(apiGet + _id)).then((data) {
      if(data.statusCode == 200){
        final jsonData = jsonDecode(data.body);
        print(data.body);
        jsonData1 = jsonData;
        return APIResponse<SingleContactModel>(data: SingleContactModel.fromJson(jsonData), error: false);
      }
      return APIResponse<SingleContactModel>(data: jsonData1, error: true);
    }).catchError((_) => APIResponse<SingleContactModel>(data: jsonData1,error: true));
  }

  //POST
  Future<APIResponse<bool>> createContact(ContactInsert item) {
    return http.post(
        Uri.parse(apiGet + '/show',),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(item.toJson()))
        .then((data) {
          if (data.statusCode == 201) {
            return APIResponse<bool>(data: true);
         }return APIResponse<bool>(data: true, error: true);
    }).catchError((_) => APIResponse<bool>(data: true, error: true));
  }

  //UPDATE
  Future<APIResponse<bool>> updateContact(String _id, ContactInsert item) {
    print(apiGet + '/update/' + _id);
    return http.patch(
        Uri.parse(apiGet + '/update/' + _id,),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(item.toJson()))
        .then((data) {
          if (data.statusCode == 204) {
            return APIResponse<bool>(data: true);
          }return APIResponse<bool>(data: true, error: true);
    }).catchError((_) => APIResponse<bool>(data: true, error: true));
  }

  Future<APIResponse<bool>> deleteContact(String _id) {
    print(apiGet + '/delete/' + _id);
    return http.delete(
        Uri.parse(apiGet + '/delete/' + _id,),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },).then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true, error: false);
      }return APIResponse<bool>(data: true, error: true);
    }).catchError((_) => APIResponse<bool>(data: true, error: true));
  }
}