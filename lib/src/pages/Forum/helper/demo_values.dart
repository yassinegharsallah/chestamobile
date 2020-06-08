

import 'package:flutter_login/src/pages/Forum/model/comment_model.dart';
import 'package:flutter_login/src/pages/Forum/model/post_model.dart';
import 'package:flutter_login/src/pages/Forum/model/user_model.dart';

class DemoValues {
  static final List<UserModel> users = [
    UserModel(
      id: "1",
      name: "Ishfar",
      email: "ishfar@gmail.com",
      image: "assets/images/images.png",
      followers: 2,
      joined: DateTime(2020, 5, 3),
      posts: 12,
    ),
    UserModel(
      id: "2",
      name: "Ishrak",
      email: "ishrak@gmail.com",
      image: "assets/images/images.png",
      followers: 456,
      joined: DateTime(2020, 5, 22),
      posts: 13,
    ),
    UserModel(
      id: "3",
      name: "Shakleen",
      email: "shakleen@gmail.com",
      image: "assets/images/images.png",
      followers: 789,
      joined: DateTime(2020, 5, 25),
      posts: 14,
    ),
  ];

  static final String _body =
      """La pneumonie est définie comme une inflammation d’origine microbienne qui, contrairement à la bronchite, n’affecte pas uniquement les voies respiratoires profondes, mais aussi directement le parenchyme pulmonaire. Les pneumonies sont traditionnellement subdivisées en pneumonies communautaires, en pneumonies nosocomiales et en pneumonies chez le patient immunodéprimé sévère, en fonction du lieu de survenue (ambulatoire ou à l’hôpital) et du statut immunitaire du patient""";

  static final List<CommentModel> _comments = <CommentModel>[
    CommentModel(
      comment:
          "tres bien  ",
      user: users[0],
      time: DateTime(2019, 4, 30),
    ),
    CommentModel(
      comment: "merci pour l information  ",
      user: users[1],
      time: DateTime(2018, 5, 30),
    ),
    CommentModel(
      comment: "3eme commentaire  ",
      user: users[0],
      time: DateTime(2017, 6, 30),
    ),
    CommentModel(
      comment: "merci  ",
      user: users[2],
      time: DateTime(2019, 4, 30),
    ),

    CommentModel(
      comment:
          "Hic accusantium minus fuga exercitationem id aut expedita doloribus. ",
      user: users[1],
      time: DateTime(2017, 6, 30),
    ),
  ];

  static final List<PostModel> posts = [
    PostModel(
      id: "1",
      author: users[0],
      title: "New Case of Pneumoinia",
      summary: "An in-depth study on pneumonia.",
      body: "This is a short body.",
      imageURL: "assets/images/chest.jpg",
      postTime: DateTime(2020, 05, 1, 7, 36),
      reacts: 3,
      views: 5,
      comments: _comments,
    ),
    PostModel(
      id: "2",
      author: users[1],
      title: "Recent study on Pneumonia",
      summary: "Preaching about Pneumonia",
      body: _body,
      imageURL: "assets/images/chest.jpg",
      postTime: DateTime(2020, 4, 29),
      reacts: 1,
      views: 4,
      comments: _comments,
    ),
    PostModel(
      id: "3",
      author: users[2],
      title: "Pneumoinia in Tunisia",
      summary: "Gives shadow and fruit. Absolute win, no?",
      body: _body * 2,
      imageURL: "assets/images/chest.jpg",
      postTime: DateTime(2020, 4, 29),
      reacts: 5,
      views: 3,
      comments: _comments,
    ),
    PostModel(
      id: "4",
      author: users[1],
      title: "Recent study on Pneumonia",
      summary: "Preaching about Pneumonia",
      body: _body,
      imageURL: "assets/images/chest.jpg",
      postTime: DateTime(2020, 4, 29),
      reacts: 5,
      views: 2,
      comments: _comments,
    ),
    PostModel(
      id: "5",
      author: users[1],
      title: "Recent study on Pneumonia",
      summary: "Preaching about Pneumonia",
      body: _body,
      imageURL: "assets/images/chest.jpg",
      postTime: DateTime(2020, 4, 29),
      reacts: 0,
      views: 1,
      comments: _comments,
    ),
    PostModel(
      id: "6",
      author: users[1],
      title: "Recent study on Pneumonia",
      summary: "Preaching about Pneumonia",
      body: _body,
      imageURL: "assets/images/chest.jpg",
      postTime: DateTime(2019, 4, 13),
      reacts: 0,
      views: 1,
      comments: _comments,
    ),
  ];
}
