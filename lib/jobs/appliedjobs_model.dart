class Apply {
  int status;
  bool sucess;
  String message;
  int count;
  List<Data> data;

  Apply({this.status, this.sucess, this.message, this.count, this.data});

  Apply.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    sucess = json['sucess'];
    message = json['message'];
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
    data['status'] = this.status;
    data['sucess'] = this.sucess;
    data['message'] = this.message;
    data['count'] = this.count;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String at;
  String proposal;
  String jobName;
  String jobCompany;

  Data({this.at, this.proposal, this.jobName, this.jobCompany});

  Data.fromJson(Map<String, dynamic> json) {
    at = json['At'];
    proposal = json['proposal'];
    jobName = json['job_name'];
    jobCompany = json['job_company'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['At'] = this.at;
    data['proposal'] = this.proposal;
    data['job_name'] = this.jobName;
    data['job_company'] = this.jobCompany;
    return data;
  }
}