class generalJobs {
  bool sucess;
  int status;
  String response;
  int count;
  List<Data> data;

  generalJobs({this.sucess, this.status, this.response, this.count, this.data});

  generalJobs.fromJson(Map<String, dynamic> json) {
    sucess = json['sucess'];
    status = json['status'];
    response = json['response'];
    count = json['count'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sucess'] = this.sucess;
    data['status'] = this.status;
    data['response'] = this.response;
    data['count'] = this.count;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String jobTitle;
  String jobDescreption;
  int fields;
  int level;
  int minimumExperience;
  String preferedCity;
  int id;
  String name;

  Data(
      {this.jobTitle,
        this.jobDescreption,
        this.fields,
        this.level,
        this.minimumExperience,
        this.preferedCity,
        this.id,
        this.name});

  Data.fromJson(Map<String, dynamic> json) {
    jobTitle = json['job_title'];
    jobDescreption = json['Job_Descreption'];
    fields = json['fields'];
    level = json['Level'];
    minimumExperience = json['Minimum_experience'];
    preferedCity = json['prefered_city'];
    id = json['id'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['job_title'] = this.jobTitle;
    data['Job_Descreption'] = this.jobDescreption;
    data['fields'] = this.fields;
    data['Level'] = this.level;
    data['Minimum_experience'] = this.minimumExperience;
    data['prefered_city'] = this.preferedCity;
    data['id'] = this.id;
    data['Name'] = this.name;
    return data;
  }
}