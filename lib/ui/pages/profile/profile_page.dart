import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:posterr/domain/domain.dart';
import 'package:posterr/ui/widgets/timeline/timeline.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  static const routeName = '/profile';

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final sharePostTextController = TextEditingController();

  @override
  void dispose() {
    sharePostTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TimelineBloc(getContent: context.read<GetLoggedUserContent>(), sharePost: context.read()) //
        ..add(const TimelineEvent.contentsFetched()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Profile'),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: ValueListenableBuilder<User?>(
                    valueListenable: context.read<AuthRepository>().loggedUser,
                    builder: (context, user, child) {
                      final joinedAt = user?.joinedAt;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Username', style: TextStyle(color: Colors.grey)),
                          Text(user?.username ?? ''),
                          const SizedBox(height: 8.0),
                          const Text('Joined at', style: TextStyle(color: Colors.grey)),
                          Text(joinedAt != null ? DateFormat.yMMMd().format(joinedAt) : ''),
                        ],
                      );
                    },
                  ),
                ),
                const Divider(thickness: 1.0, height: 1.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: sharePostTextController,
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
                      const Expanded(child: Timeline())
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
