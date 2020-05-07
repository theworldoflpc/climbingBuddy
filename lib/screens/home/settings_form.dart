import 'package:climbingpals/models/user.dart';
import 'package:climbingpals/services/database.dart';
import 'package:climbingpals/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:climbingpals/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> ages = ['0', '1', '2', '3', '4'];
  final List<int> rank = [100, 200, 300, 400, 500, 600, 700, 800, 900];


  // form values
  String _currentName;
  String _currentAges;
  int _currentRank;

  @override
  Widget build(BuildContext context) {

    User user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData userData = snapshot.data;

          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  'Update your personal settings.',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  initialValue: userData.name,
                  decoration: textInputDecoration,
                  validator: (val) => val.isEmpty ? 'Please enter a name:': null,
                  onChanged: (val) => setState(() => _currentName = val),
                ),
                SizedBox(height: 20.0),
                DropdownButtonFormField(
                  value: _currentAges ?? userData.ages,
                  decoration: textInputDecoration,
                  items: ages.map((age) {
                    return DropdownMenuItem(
                      value: age,
                      child: Text('$age age'),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => _currentAges = val),
                ),
                SizedBox(height: 10.0),
                // slider
                Slider(
                  value: (_currentRank ?? userData.rank).toDouble(),
                  activeColor: Colors.blue[_currentRank ?? userData.rank],
                  inactiveColor: Colors.blue[_currentRank ?? userData.rank],
                  min: 100.0,
                  max: 900.0,
                  divisions: 8,
                  onChanged: (val) => setState(() => _currentRank = val.round()),
                ),
                RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      await DatabaseService(uid: user.uid).updateUserData(
                        _currentName ?? snapshot.data.name,
                        _currentAges ?? snapshot.data.ages,
                        _currentRank ?? snapshot.data.rank
                      );
                      Navigator.pop(context);
                    }
                  }
                ),
              ],
            ),
          );
        } else {
          return Loading();
        }
      }
    );
  }
}
