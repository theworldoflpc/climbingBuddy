import 'package:flutter/material.dart';
import 'package:climbingpals/models/climber.dart';
import 'package:provider/provider.dart';
import 'package:climbingpals/screens/home/climber_tile.dart';

class ClimberList extends StatefulWidget {
  @override
  _ClimberListState createState() => _ClimberListState();
}

class _ClimberListState extends State<ClimberList> {
  @override
  Widget build(BuildContext context) {

    // accessing climber and printing out properties of climber
    final climbers = Provider.of<List<Climber>>(context) ?? [];

    return ListView.builder(
      itemCount: climbers.length,
      itemBuilder: (context, index) {
        return ClimberTile(climber: climbers[index]);
      },
    );
  }
}
