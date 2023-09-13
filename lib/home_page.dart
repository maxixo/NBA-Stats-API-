import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model/team.dart';


class HomePage extends StatelessWidget {
   HomePage({super.key});

//List of Teams 
List<Team> teams = [];



// Get Teams 
Future getTeams() async {
  var response = await http.get(Uri.https('balldontlie.io', '/api/v1/teams'));
  var jsonData = jsonDecode(response.body);

// Loop to get each team 
  for (var eachTeam in jsonData['data'] ) {
    final team = Team(
      abbreviation: eachTeam['abbreviation'] ,
       city: eachTeam['city'],
        );
    teams.add(team);

  }
   print(teams.length);

}


  @override
  Widget build(BuildContext context) {
        getTeams();
    return Scaffold(
      body: FutureBuilder(
        future: getTeams(),
        builder: (context, snapshot) {

          // Is it done loading? then show the team daataa
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              
              itemCount:teams.length ,
              itemBuilder: (context, index) {
              
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color : Colors.grey[200],
                    borderRadius:BorderRadius.circular(12.0)
                    
                    ),
                  
                  child: ListTile(
                   
                    
                    title: Text(teams[index].abbreviation),
                    subtitle: Text(teams[index].city),
                
                
                
                
                  ),
                ),
              );
            },
            );


          }
          //If it is still loading , show circular indicator 
           else {
            return const Center( 
              child: CircularProgressIndicator(),
             );


          }


          

        },
        
         )
      
    );
  }
}