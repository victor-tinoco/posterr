import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:posterr/domain/entities/user.dart';

part 'content.freezed.dart';

/// An user-generated text-based content.
///
/// There are 3 types of content:
/// * Post: a text-based shared content.
/// * Repost: a re-posting of an existing post.
/// * Quote-post: a post based in another post, also with a message along with it.
@freezed
class Content with _$Content {
  @Assert('message.isNotEmpty', 'Message cannot be empty.')
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

  @Assert('message.isNotEmpty', 'Message cannot be empty.')
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
  }) = PostReply;
}
