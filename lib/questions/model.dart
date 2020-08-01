class General {
  List<QuestionList> questionList;

  General({this.questionList});

  General.fromJson(Map<String, dynamic> json) {
    if (json['Question_list'] != null) {
      questionList = new List<QuestionList>();
      json['Question_list'].forEach((v) {
        questionList.add(new QuestionList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.questionList != null) {
      data['Question_list'] = this.questionList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class QuestionList {
  int id;
  List<Question> question;
  String questionText;
  int domain;

  QuestionList({this.id, this.question, this.questionText, this.domain});

  QuestionList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['Question'] != null) {
      question = new List<Question>();
      json['Question'].forEach((v) {
        question.add(new Question.fromJson(v));
      });
    }
    questionText = json['Question_text'];
    domain = json['Domain'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.question != null) {
      data['Question'] = this.question.map((v) => v.toJson()).toList();
    }
    data['Question_text'] = this.questionText;
    data['Domain'] = this.domain;
    return data;
  }
}

class Question {
  int id;
  int weightage;
  String answerText;
  int questionRelatedTo;
  int fromDomain;

  Question(
      {this.id,
      this.weightage,
      this.answerText,
      this.questionRelatedTo,
      this.fromDomain});


   Question.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    weightage = json['Weightage'];
    answerText = json['Answer_text'];
    questionRelatedTo = json['Question_related_to'];
    fromDomain = json['from_Domain'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['id'] = this.id;
    data['Weightage'] = this.weightage.toInt();
  //  if (this.answerText != null) {
  //    data['Answer_text'] = this.answerText.map((v) => v.toJson()).toList();
  //  }
    data['Answer_text'] = this.answerText;
    data['Question_related_to'] = this.questionRelatedTo;
    data['from_Domain'] = this.fromDomain;
    return data;
  }
}
