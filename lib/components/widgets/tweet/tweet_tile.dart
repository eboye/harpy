import 'package:flutter/material.dart';
import 'package:harpy/api/twitter/data/tweet.dart';
import 'package:harpy/components/widgets/tweet/tweet_tile_content.dart';
import 'package:harpy/models/home_timeline_model.dart';
import 'package:harpy/models/timeline_model.dart';
import 'package:harpy/models/tweet_model.dart';
import 'package:harpy/models/user_timeline_model.dart';
import 'package:provider/provider.dart';

class TweetTile extends StatelessWidget {
  TweetTile({
    @required this.tweet,
    Key key,
  })  : content = TweetTileContent(),
        super(key: key);

  const TweetTile.custom({
    @required this.tweet,
    @required this.content,
    Key key,
  }) : super(key: key);

  final Tweet tweet;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    TimelineModel timelineModel;

    try {
      // use the user timeline model if it exists above the home timeline model
      timelineModel = UserTimelineModel.of(context);
    } on ProviderNotFoundError {
      timelineModel = HomeTimelineModel.of(context);
    }

    return ChangeNotifierProvider<TweetModel>(
      builder: (_) => TweetModel(
        originalTweet: tweet,
      )..replyAuthors = timelineModel.findTweetReplyAuthors(tweet),
      child: content,
    );
  }
}
