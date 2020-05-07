import 'package:climbingpals/screens/home/settings_form.dart';
import 'package:climbingpals/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:climbingpals/services/database.dart';
import 'package:provider/provider.dart';
import 'package:climbingpals/screens/home/climber_list.dart';
import 'package:climbingpals/models/climber.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    
    void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    }
    
    return StreamProvider<List<Climber>>.value(
      value: DatabaseService().climbers,
      child: Scaffold(
        backgroundColor: Colors.blueGrey[50],
        appBar: AppBar(
          title: Text('Climbing Buddies'),
          backgroundColor: Colors.blueGrey[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Logout'),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text('Settings'),
              onPressed: () => _showSettingsPanel(),
            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/climbingguy.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: ClimberList(

          ),
        ),
      ),
    );
  }
}
