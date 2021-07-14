class SingleContactModel{
  String iD, firstname, lastname, phoneNumber;
  SingleContactModel({required this.iD, required this.firstname, required this.lastname, required this.phoneNumber});

  factory SingleContactModel.fromJson(Map<String, dynamic> item){
    return SingleContactModel(
        iD: item['_id'],
        firstname: item['firstname'],
        lastname: item['lastname'],
        phoneNumber: item['phoneNumber']);
  }
}