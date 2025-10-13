import 'package:flutter/material.dart';
import 'github_api.dart'; // ensure the path is correct

class ContributorLeaderboardScreen extends StatefulWidget {
  const ContributorLeaderboardScreen({Key? key}) : super(key: key);

  @override
  State<ContributorLeaderboardScreen> createState() =>
      _ContributorLeaderboardScreenState();
}

class _ContributorLeaderboardScreenState
    extends State<ContributorLeaderboardScreen> {
  late Future<List<Contributor>> _contributorsFuture;

  @override
  void initState() {
    super.initState();
    _contributorsFuture = fetchContributors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contributor Leaderboard'),
      ),
      body: FutureBuilder<List<Contributor>>(
        future: _contributorsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No contributors found.'));
          } else {
            final contributors = snapshot.data!;
            return ListView.builder(
              itemCount: contributors.length,
              itemBuilder: (context, index) {
                final contributor = contributors[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(contributor.avatarUrl),
                  ),
                  title: Text(contributor.login),
                  trailing: Text('${contributor.contributions} Contributions'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
