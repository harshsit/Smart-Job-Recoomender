class Courseslist {
  CourseList courseList;

  Courseslist({this.courseList});

  Courseslist.fromJson(Map<String, dynamic> json) {
    courseList = json['Course_list'] != null
        ? new CourseList.fromJson(json['Course_list'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.courseList != null) {
      data['Course_list'] = this.courseList.toJson();
    }
    return data;
  }
}

class CourseList {
  int status;
  String message;
  int count;
  List<Data> data;

  CourseList({this.status, this.message, this.count, this.data});

  CourseList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
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
    data['message'] = this.message;
    data['count'] = this.count;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int id;
  String title;
  String description;
  String by;
  String photo;
  String refrences;
  int rating;
  String apply;
  String added;
  int domain;
  List<int> socialMediaTags;
  List<int> socioeconomicTags;

  Data(
      {this.id,
      this.title,
      this.description,
      this.by,
      this.photo,
      this.refrences,
      this.rating,
      this.apply,
      this.added,
      this.domain,
      this.socialMediaTags,
      this.socioeconomicTags});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['Title'];
    description = json['Description'];
    by = json['By'];
    photo = json['photo'];
    refrences = json['Refrences'];
    rating = json['Rating'];
    apply = json['Apply'];
    added = json['Added'];
    domain = json['Domain'];
    socialMediaTags = json['SocialMediaTags'].cast<int>();
    socioeconomicTags = json['SocioeconomicTags'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Title'] = this.title;
    data['Description'] = this.description;
    data['By'] = this.by;
    data['photo'] = this.photo;
    data['Refrences'] = this.refrences;
    data['Rating'] = this.rating;
    data['Apply'] = this.apply;
    data['Added'] = this.added;
    data['Domain'] = this.domain;
    data['SocialMediaTags'] = this.socialMediaTags;
    data['SocioeconomicTags'] = this.socioeconomicTags;
    return data;
  }
}