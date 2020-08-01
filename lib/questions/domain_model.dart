// class Domainspec {
//   bool sucess;
//   int status;
//   String response;
//   List<Data> data;

//   Domainspec({this.sucess, this.status, this.response, this.data});

//   Domainspec.fromJson(Map<String, dynamic> json) {
//     sucess = json['sucess'];
//     status = json['status'];
//     response = json['response'];
//     if (json['data'] != null) {
//       data = new List<Data>();
//       json['data'].forEach((v) {
//         data.add(new Data.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['sucess'] = this.sucess;
//     data['status'] = this.status;
//     data['response'] = this.response;
//     if (this.data != null) {
//       data['data'] = this.data.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Data {
//   int id;
//   List<QuestionDomain> questionDomain;
//   String questionText;
//   int domain;

//   Data({this.id, this.questionDomain, this.questionText, this.domain});

//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     if (json['Question_domain'] != null) {
//       questionDomain = new List<QuestionDomain>();
//       json['Question_domain'].forEach((v) {
//         questionDomain.add(new QuestionDomain.fromJson(v));
//       });
//     }
//     questionText = json['Question_text'];
//     domain = json['Domain'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     if (this.questionDomain != null) {
//       data['Question_domain'] =
//           this.questionDomain.map((v) => v.toJson()).toList();
//     }
//     data['Question_text'] = this.questionText;
//     data['Domain'] = this.domain;
//     return data;
//   }
// }

// class QuestionDomain {
//   int id;
//   int weightage;
//   String answerText;
//   int questionRelatedTo;
//   int fromDomain;

class Domainspec {
  bool sucess;
  int status;
  String response;
  int count;
  List<Data> data;

  Domainspec({this.sucess, this.status, this.response, this.count, this.data});

  Domainspec.fromJson(Map<String, dynamic> json) {
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
  int id;
  List<QuestionDomain> questionDomain;
  String questionText;
  bool level3;
  int domain;
  int subDomain;

  Data(
      {this.id,
      this.questionDomain,
      this.questionText,
      this.level3,
      this.domain,
      this.subDomain});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['Question_domain'] != null) {
      questionDomain = new List<QuestionDomain>();
      json['Question_domain'].forEach((v) {
        questionDomain.add(new QuestionDomain.fromJson(v));
      });
    }
    questionText = json['Question_text'];
    level3 = json['Level3'];
    domain = json['Domain'];
    subDomain = json['SubDomain'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.questionDomain != null) {
      data['Question_domain'] =
          this.questionDomain.map((v) => v.toJson()).toList();
    }
    data['Question_text'] = this.questionText;
    data['Level3'] = this.level3;
    data['Domain'] = this.domain;
    data['SubDomain'] = this.subDomain;
    return data;
  }
}

class QuestionDomain {
  int id;
  int weightage;
  String answerText;
  int questionRelatedTo;
  int fromDomain;
  int subDomain;

  QuestionDomain(
      {this.id,
      this.weightage,
      this.answerText,
      this.questionRelatedTo,
      this.fromDomain,
      this.subDomain});

  QuestionDomain.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    weightage = json['Weightage'];
    answerText = json['Answer_text'];
    questionRelatedTo = json['Question_related_to'];
    fromDomain = json['from_Domain'];
    subDomain = json['SubDomain'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Weightage'] = this.weightage;
    data['Answer_text'] = this.answerText;
    data['Question_related_to'] = this.questionRelatedTo;
    data['from_Domain'] = this.fromDomain;
    data['SubDomain'] = this.subDomain;
    return data;
  }
}
//   QuestionDomain(
//       {this.id,
//       this.weightage,
//       this.answerText,
//       this.questionRelatedTo,
//       this.fromDomain});

//   QuestionDomain.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     weightage = json['Weightage'];
//     answerText = json['Answer_text'];
//     questionRelatedTo = json['Question_related_to'];
//     fromDomain = json['from_Domain'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['Weightage'] = this.weightage;
//     data['Answer_text'] = this.answerText;
//     data['Question_related_to'] = this.questionRelatedTo;
//     data['from_Domain'] = this.fromDomain;
//     return data;
//   }
// }