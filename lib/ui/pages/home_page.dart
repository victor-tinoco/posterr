import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posterr/domain/domain.dart';
import 'package:posterr/ui/ui.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TimelineBloc(getContent: context.read<GetTimelineContent>(), sharePost: context.read()) //
        ..add(const TimelineEvent.contentsFetched()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Posterr'),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(90),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: SharePostTextField(
                          onPost: (message) {
                            final bloc = context.read<TimelineBloc>();
                            final event = TimelineEvent.postShared(message);
                            bloc.add(event);
                          },
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      IconButton(
                        icon: const Icon(Icons.person),
                        onPressed: () async {
                          await Navigator.of(context).pushNamed(ProfilePage.routeName);
                          final bloc = context.read<TimelineBloc>();
                          bloc.add(const ContentsFetchedTimelineEvent());
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: const Timeline(),
          );
        },
      ),
    );
  }
}
