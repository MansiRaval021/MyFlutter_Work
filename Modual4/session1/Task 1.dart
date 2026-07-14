//Create a Flutter app screen that displays a static list of 8 trending IPL teams using a ListView widget, showing each team name as a separate Text widget.

//Modify your ListView to display each IPL team inside a Card widget with padding and a leading Icon (use Icons.sports_cricket), so the list looks similar to a sports app's team list.<br><br><em><strong>Hint:</strong> Use ListView's children property and wrap each Card with Padding for better spacing.</em>
//Replace your static ListView with a ListView.builder that generates the list of IPL teams from a Dart List<String> variable, so you can easily change the team names without editing the UI code.
//Add vertical spacing of 12 pixels between each Card in your ListView.builder to improve readability, similar to how Zomato separates restaurant cards.<br><br><em><strong>Hint:</strong> You can use the separatorBuilder property of ListView.separated for this effect.</em>

import 'package:flutter/material.dart';

class IPLTeamsScreen extends StatelessWidget {
  const IPLTeamsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> teams = [
      "Chennai Super Kings",
      "Mumbai Indians",
      "Royal Challengers Bengaluru",
      "Kolkata Knight Riders",
      "Rajasthan Royals",
      "Sunrisers Hyderabad",
      "Delhi Capitals",
      "Gujarat Titans",
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Trending IPL Teams"),
        backgroundColor: Colors.blue,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: teams.length,

        // Creates each card
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            child: ListTile(
              leading: const Icon(
                Icons.sports_cricket,
                color: Colors.blue,
              ),
              title: Text(
                teams[index],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },

        // Adds 12 pixels of vertical space between cards
        separatorBuilder: (context, index) {
          return const SizedBox(height: 12);
        },
      ),
    );
  }
}
