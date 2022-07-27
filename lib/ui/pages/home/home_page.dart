import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posterr/data/repositories/auth.dart';
import 'package:posterr/data/repositories/content.dart';
import 'package:posterr/domain/domain.dart';
import 'package:posterr/ui/blocs/timeline/timeline_bloc.dart';
import 'package:posterr/ui/blocs/timeline/timeline_event.dart';
import 'package:posterr/ui/blocs/timeline/timeline_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final contentRepository = ContentRepositoryMock();
  final authRepository = AuthRepositoryMock();

  late final getTimelineContent = GetTimelineContent(contentRepository: contentRepository);
  late final sharePost = SharePost(contentRepository: contentRepository, authRepository: authRepository, getLoggedUserContent: GetLoggedUserContent(contentRepository: contentRepository, authRepository: authRepository));

  final sharePostTextController = TextEditingController();

  @override
  void dispose() {
    sharePostTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TimelineBloc(getTimelineContent: getTimelineContent, sharePost: sharePost) //
        ..add(const TimelineEvent.contentsFetched()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Posterr'),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(58),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: sharePostTextController,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                          final bloc = context.read<TimelineBloc>();
                          final event = TimelineEvent.postShared(sharePostTextController.text);
                          bloc.add(event);
                          sharePostTextController.clear();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: BlocBuilder<TimelineBloc, TimelineState>(
              builder: (context, state) {
                if (state.contentList.isEmpty) {
                  switch (state.status) {
                    case TimelineStatus.loading:
                      return const Center(child: CircularProgressIndicator());
                    case TimelineStatus.failure:
                      return const Center(child: Text('Something went wrong, try again later.'));
                    case TimelineStatus.success:
                      return const Center(child: Text('Empty timeline, try sharing some content.'));
                  }
                } else {
                  return ListView.separated(
                    itemCount: state.contentList.length,
                    separatorBuilder: (context, index) => const Divider(height: 1, thickness: 1),
                    itemBuilder: (context, index) {
                      return state.contentList[index].map(
                        post: PostCard.new,
                        repost: RepostCard.new,
                        quotePost: PostCard.quote,
                      );
                    },
                  );
                  // TODO(victor-tinoco): Add pagination.
                }
              },
            ),
          );
        },
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  const PostCard(this.post, {Key? key, this.child}) : super(key: key);

  PostCard.quote(
    QuotePost quotePost, {
    Key? key,
  })  : post = Post(author: quotePost.author, message: quotePost.message, postedAt: quotePost.postedAt),
        child = DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.5),
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          ),
          child: PostCard(quotePost.post),
        ),
        super(key: key);

  final Post post;

  // An optional middle widget, placed between the message and the post time.
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final child = this.child;

    return Padding(
      padding: const EdgeInsets.all(24.0) - const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(style: const TextStyle(color: Colors.black), children: [
              TextSpan(
                text: post.message,
              ),
              TextSpan(
                text: ' - @${post.author.username}',
                style: const TextStyle(color: Colors.grey),
              ),
            ]),
          ),
          if (child != null) ...[
            const SizedBox(height: 16.0),
            child,
          ],
          const SizedBox(height: 8.0),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              // TODO(victor-tinoco): Improve this formatting instead of jus take seconds.
              '${DateTime.now().difference(post.postedAt).inSeconds}s ago',
              style: const TextStyle(fontSize: 12.0, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}

class RepostCard extends StatelessWidget {
  const RepostCard(this.repost, {Key? key}) : super(key: key);

  final Repost repost;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '@${repost.author.username} reposted',
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(width: 4.0),
              const Icon(Icons.restart_alt, color: Colors.grey, size: 16.0),
            ],
          ),
          const SizedBox(height: 8.0),
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 0.5),
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            ),
            child: PostCard(repost.originalPost),
          ),
        ],
      ),
    );
  }
}
