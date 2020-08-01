class Machineanalysis {
  String name;
  String email;
  String mobileNumber;
  List<String> skills;
  Null collegeName;
  List<String> degree;
  Null designation;
  List<String> experience;
  Null companyNames;
  int noOfPages;
  int totalExperience;

  Machineanalysis(
      {this.name,
      this.email,
      this.mobileNumber,
      this.skills,
      this.collegeName,
      this.degree,
      this.designation,
      this.experience,
      this.companyNames,
      this.noOfPages,
      this.totalExperience});

  Machineanalysis.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    mobileNumber = json['mobile_number'];
    skills = json['skills'].cast<String>();
    collegeName = json['college_name'];
    degree = json['degree'].cast<String>();
    designation = json['designation'];
    experience = json['experience'].cast<String>();
    companyNames = json['company_names'];
    noOfPages = json['no_of_pages'];
    totalExperience = json['total_experience'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile_number'] = this.mobileNumber;
    data['skills'] = this.skills;
    data['college_name'] = this.collegeName;
    data['degree'] = this.degree;
    data['designation'] = this.designation;
    data['experience'] = this.experience;
    data['company_names'] = this.companyNames;
    data['no_of_pages'] = this.noOfPages;
    data['total_experience'] = this.totalExperience;
    return data;
  }
}