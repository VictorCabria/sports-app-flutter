class Comment {
  final String? commentsTime;
  final String? commentsText;
  final String? commentsStateInfo;
  final int? matchId;

  Comment({
    required this.commentsTime,
    required this.commentsText,
    required this.commentsStateInfo,
    required this.matchId,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      commentsTime: json['comments_time'],
      commentsText: json['comments_text'],
      commentsStateInfo: json['comments_state_info'],
      matchId: json['match_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'comments_time': commentsTime,
      'comments_text': commentsText,
      'comments_state_info': commentsStateInfo,
      'match_id': matchId,
    };
  }

  static List<Comment> parseComments(List<dynamic> commentsList) {
    return commentsList.map((json) => Comment.fromJson(json)).toList();
  }
}

class CommentResponse {
  List<Comment>? result;

  CommentResponse({required this.result});

  factory CommentResponse.fromJson(Map<String, dynamic> json, String matchId) {
    List<dynamic> commentsList = json['result'][matchId];
    return CommentResponse(
      result: Comment.parseComments(commentsList),
    );
  }
}
