
class Officer{
  String id;
  String agency;
  String firstName;
  String middleName;
  String lastName;
  String email;
  String gender;
  String department;
  String office;
  String image;
  String position;
  String division;
  String section;
  String status;


  Officer({
    this.id,
    this.agency,
    this.firstName,
    this.middleName,
    this.lastName,
    this.email,
    this.gender,
    this.department,
    this.office,
    this.image,
    this.position,
    this.division,
    this.section,
    this.status,
  });

  factory Officer.fromJson(Map<String, dynamic> item) {
    return Officer(
      id : item['id'],
      agency : item['agency'],
      firstName : item['firstName'],
      middleName : item['middleName'],
      lastName : item['lastName'],
      email : item['email'],
      gender : item['gender'],
      department : item['department'],
      office : item['office'],
      image : item['image'],
      position : item['position'],
      division : item['division'],
      section : item['section'],
      status : item['status'],
    );
  }
}
