import 'package:flutter/material.dart';
import 'package:climbingpals/models/climber.dart';

class ClimberTile extends StatelessWidget {

  final Climber climber;
  ClimberTile({ this.climber });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Container(
        height: 100,
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.grey[climber.rank],
              backgroundImage: AssetImage('assets/rc.jpg'),
            ),
            title: Text(climber.ages),
            subtitle: Text('Level: ${climber.name}'),


          ),
        ),
      ),
    );
  }
}
