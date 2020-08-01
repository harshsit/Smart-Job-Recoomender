class Blogs {
  BlogsList blogsList;

  Blogs({this.blogsList});

  Blogs.fromJson(Map<String, dynamic> json) {
    blogsList = json['Blogs_list'] != null
        ? new BlogsList.fromJson(json['Blogs_list'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.blogsList != null) {
      data['Blogs_list'] = this.blogsList.toJson();
    }
    return data;
  }
}

class BlogsList {
  int status;
  String message;
  int count;
  List<Data> data;

  BlogsList({this.status, this.message, this.count, this.data});

  BlogsList.fromJson(Map<String, dynamic> json) {
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
  String photo;
  String refrences;
  String added;
  int rating;
  String apply;
  int domain;
  List<int> socialMediaTags;
  List<Null> socioeconomicTags;

  Data(
      {this.id,
      this.title,
      this.description,
      this.photo,
      this.refrences,
      this.added,
      this.rating,
      this.apply,
      this.domain,
      this.socialMediaTags,
      this.socioeconomicTags});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['Title'];
    description = json['Description'];
    photo = json['photo'];
    refrences = json['Refrences'];
    added = json['Added'];
    rating = json['Rating'];
    apply = json['Apply'];
    domain = json['Domain'];
    socialMediaTags = json['SocialMediaTags'].cast<int>();
    // if (json['SocioeconomicTags'] != null) {
    //   socioeconomicTags = new List<Null>();
    //   json['SocioeconomicTags'].forEach((v) {
    //     socioeconomicTags.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Title'] = this.title;
    data['Description'] = this.description;
    data['photo'] = this.photo;
    data['Refrences'] = this.refrences;
    data['Added'] = this.added;
    data['Rating'] = this.rating;
    data['Apply'] = this.apply;
    data['Domain'] = this.domain;
    data['SocialMediaTags'] = this.socialMediaTags;
    // if (this.socioeconomicTags != null) {
    //   data['SocioeconomicTags'] =
    //       this.socioeconomicTags.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}