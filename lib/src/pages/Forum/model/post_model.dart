import 'package:flutter/material.dart';
import 'package:flutter_login/src/pages/Forum/model/user_model.dart';
import 'package:intl/intl.dart';
import 'package:flutter_login/src/pages/Forum/model/comment_model.dart';
import 'package:flutter_login/src/pages/Forum/model/post_model.dart';
import 'package:flutter_login/src/pages/Forum/model/user_model.dart';


class PostModel {
  final String id, title, summary, body, imageURL;
  final DateTime postTime;
  final int reacts, views;
  final UserModel author;
  final List<CommentModel> comments;

  const PostModel({
    @required this.id,
    @required this.title,
    @required this.summary,
    @required this.body,
    @required this.imageURL,
    @required this.author,
    @required this.postTime,
    @required this.reacts,
    @required this.views,
    @required this.comments,
  });

  String get postTimeFormatted => DateFormat.yMMMMEEEEd().format(postTime);
}
