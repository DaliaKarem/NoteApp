class Note {
  String? notesId;
  String? notesTitle;
  String? notesContent;
  String? notesImg;
  String? notesUsers;

  Note(
      {this.notesId,
        this.notesTitle,
        this.notesContent,
        this.notesImg,
        this.notesUsers});

  Note.fromJson(Map<String, dynamic> json) {
    notesId = json['notes_id'];
    notesTitle = json['notes_title'];
    notesContent = json['notes_content'];
    notesImg = json['notes_img'];
    notesUsers = json['notes_users'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notes_id'] = this.notesId;
    data['notes_title'] = this.notesTitle;
    data['notes_content'] = this.notesContent;
    data['notes_img'] = this.notesImg;
    data['notes_users'] = this.notesUsers;
    return data;
  }
}