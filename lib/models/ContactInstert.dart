class ContactInsert{
  String firstname, lastname, phoneNumber;
  ContactInsert({required this.firstname, required this.lastname, required this.phoneNumber});

  Map<String, dynamic>toJson() {
    return{
      "firstname": firstname,
      "lastname": lastname,
      "phoneNumber": phoneNumber
    };
  }

}