import 'package:enactusnca/Models/comment_model.dart';
import 'package:enactusnca/Screens/Profile/profile.dart';
import 'package:enactusnca/Widgets/post_image.dart';
import 'package:enactusnca/Models/NewPost.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'CommentsList.dart';

class OpenPost extends StatefulWidget {
  final focus;
  final Post post;
  OpenPost({this.post, this.focus});

  @override
  _OpenPostState createState() => _OpenPostState();
}

class _OpenPostState extends State<OpenPost> {
  CommentModel _commentModel = CommentModel();
  bool showLoading = false;
  String comment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(widget.post.name),
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  userinfo(),
                  widget.post.mediaUrl != null
                      ? PostImage(imageUrl: widget.post.mediaUrl)
                      : Container(),
                  Container(
                    margin: EdgeInsets.all(14.0),
                    child: Text(
                      widget.post.description,
                      // style: TextStyle(fontSize: 16.0, color: blackColor),
                    ),
                  ),
                  buttons(),
                  Container(
                    // color: backgroundColor,
                    height: MediaQuery.of(context).size.height * 0.2,
                  ),
                ],
              ),
            ),
          ),
          commentsSection(),
        ],
      ),
    );
  }

  userinfo() {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(widget?.post?.userProfileImg ??
            'https://cdn.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png'),
      ),
      title: Text(widget.post.name),
      subtitle: Text(widget.post.timeStamp),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Profile(postUserId: widget.post.ownerId),
          ),
        );
      },
    );
  }

  buttons() {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: IconButton(
              icon: Icon(FontAwesomeIcons.thumbsUp),
              onPressed: () {},
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              icon: Icon(FontAwesomeIcons.comments),
              onPressed: () async {},
            ),
          )
        ],
      ),
    );
  }

  commentsSection() {
    return SizedBox.expand(
      child: DraggableScrollableSheet(
        minChildSize: 0.2,
        maxChildSize: 1.0,
        initialChildSize: 0.2,
        builder: (context, scrollController) {
          return CommentsList(
            thisPost: widget.post,
            scrollController: scrollController,
            focus: widget.focus,
          );
        },
      ),
    );
  }
}
