
import 'package:chopper/chopper.dart';
import 'package:chopper_example/model/built_post.dart';
import 'package:chopper_example/data/post_api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SinglePostPage extends StatelessWidget {
  final int postId;
  const SinglePostPage({this.postId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chopper Blog'),
      ),
      body: FutureBuilder<Response<BuiltPost>>(
        future: Provider.of<PostApiService>(context).getPost(postId),
        builder: (context, snapShot) {
          if (snapShot.connectionState == ConnectionState.done) {
            // final Map post = json.decode(snapShot.data.bodyString);
            final post = snapShot.data.body;
            return _buildPost(post);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Padding _buildPost(BuiltPost post) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Text(
            post.title,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 8,
          ),
          Text(post.body),
        ],
      ),
    );
  }
}
