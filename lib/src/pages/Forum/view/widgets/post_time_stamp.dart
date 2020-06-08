import 'package:flutter/material.dart';
import 'package:flutter_login/src/pages/Forum/model/post_model.dart';
import 'package:flutter_login/src/pages/Forum/view/presentation/themes.dart';
import 'package:flutter_login/src/pages/Forum/view/widgets/inherited_widgets/inherited_post_model.dart';

class PostTimeStamp extends StatelessWidget {
  final Alignment alignment;

  const PostTimeStamp({
    Key key,
    this.alignment = Alignment.centerLeft,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PostModel postData = InheritedPostModel.of(context).postData;
    final TextStyle timeTheme = TextThemes.dateStyle;

    return Container(
      width: double.infinity,
      alignment: alignment,
      child: Text(postData.postTimeFormatted, style: timeTheme),
    );
  }
}
