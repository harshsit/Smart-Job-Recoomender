class profilemodel {
  bool sucess;
  int status;
  Data data;

  profilemodel({this.sucess, this.status, this.data});

  profilemodel.fromJson(Map<String, dynamic> json) {
    sucess = json['sucess'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sucess'] = this.sucess;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String name;
  String address;
  String resume;
  int marketRating;
  int techRating;
  String bio;
  int experience;
  List<Skills> skills;
  String residence;
  int familyincome;
  int time;

  Data(
      {this.name,
      this.address,
      this.resume,
      this.marketRating,
      this.techRating,
      this.bio,
      this.experience,
      this.skills,
      this.residence,
      this.familyincome,
      this.time});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    address = json['Address'];
    resume = json['Resume'];
    marketRating = json['MarketRating'];
    techRating = json['TechRating'];
    bio = json['Bio'];
    experience = json['Experience'];
    if (json['Skills'] != null) {
      skills = new List<Skills>();
      json['Skills'].forEach((v) {
        skills.add(new Skills.fromJson(v));
      });
    }
    residence = json['Residence'];
    familyincome = json['Familyincome'];
    time = json['Time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['Address'] = this.address;
    data['Resume'] = this.resume;
    data['MarketRating'] = this.marketRating;
    data['TechRating'] = this.techRating;
    data['Bio'] = this.bio;
    data['Experience'] = this.experience;
    if (this.skills != null) {
      data['Skills'] = this.skills.map((v) => v.toJson()).toList();
    }
    data['Residence'] = this.residence;
    data['Familyincome'] = this.familyincome;
    data['Time'] = this.time;
    return data;
  }
}

class Skills {
  String name;

  Skills({this.name});

  Skills.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    return data;
  }
}