import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:posterr/domain/entities/user.dart';

part 'content.freezed.dart';

/// An user-generated text-based content.
///
/// There are 3 types of content:
/// * Post: a text-based shared content.
/// * Re-post: a re-posting of an existing post.
/// * Quote-post: a post based in another post, also with a message along with it.
///
/// See more:
/// * [UserContentInfo], where we can provide information about the content shared
/// from a specific user.
@freezed
class Content with _$Content {
  @Assert('message.length > 0', 'Message cannot be empty.')
  @Assert('message.length <= 777', 'Message cannot be greater than 777 characters.')
  const factory Content.post({
    required User author,

    /// The text content of this.
    ///
    /// Must not be non-empty and greater than 777 characters.
    required String message,
    required DateTime postedAt,
  }) = Post;

  const factory Content.repost({
    required User author,
    required Post originalPost,
    required DateTime postedAt,
  }) = Repost;

  @Assert('message.length > 0', 'Message cannot be empty.')
  @Assert('message.length <= 777', 'Message cannot be greater than 777 characters.')
  const factory Content.quotePost({
    required User author,

    /// The post whose this quote-post refers to.
    required Post post,

    /// The text content of this.
    ///
    /// Must not be non-empty and greater than 777 characters.
    required String message,
    required DateTime postedAt,
  }) = QuotePost;
}

/// An object that deal with information about the content from a given user.
///
/// Through this interface is possible to provide how many posts, re-posts and
/// quote-posts were shared.
///
/// See more:
/// * [Content], an user-generated text-based content.
@freezed
class UserContentInfo with _$UserContentInfo {
  const factory UserContentInfo({
    @Default(0) int postsCount,
    @Default(0) int repostsCount,
    @Default(0) int quotePostsCount,
  }) = _UserContentInfo;

  const UserContentInfo._();

  int get totalContentCount => postsCount + repostsCount + quotePostsCount;

  String get describedCount => 'Posts: $postsCount, re-posts: $repostsCount, quotePosts: $quotePostsCount, total: $totalContentCount';
}
