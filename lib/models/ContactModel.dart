class ContactModel{
  String iD, firstname, lastname, phoneNumber;
  ContactModel({required this.iD, required this.firstname, required this.lastname, required this.phoneNumber});

  factory ContactModel.fromJson(Map<String, dynamic> item){
    return ContactModel(
        iD: item['_id'],
        firstname: item['firstname'],
        lastname: item['lastname'],
        phoneNumber: item['phoneNumber']);
  }
}