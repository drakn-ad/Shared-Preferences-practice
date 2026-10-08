import 'package:flutter/material.dart';
import 'package:shared_pref_apps/PreferenceHelper.dart';

class PracticeScreen extends StatefulWidget {
  const PracticeScreen({super.key});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  final TextEditingController _controller = TextEditingController();
  String _savedUsername = 'No data saved yet';
  bool _savedDarkMode = false;
  bool _isSwitchToggled = false;
  @override
  void initState() {
    super.initState();
    _loadStoredData();
  }
  Future<void> _loadStoredData() async {
    String? username = await Preferencehelper.getUsername();
    bool darkMode = await Preferencehelper.getDarkMode();

    setState(() {
      _savedUsername = username ?? 'No username found';
      _savedDarkMode = darkMode;
      _isSwitchToggled = darkMode;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _savedDarkMode ? ThemeData.dark() : ThemeData.light(),
      child: Scaffold(
        appBar: AppBar(title: Text('Shared preferences'),),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Enter Username',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16,),
              SwitchListTile(title: Text('Enable Dark Mode'),value: _isSwitchToggled, onChanged: (bool value){
                setState(() {
                  _isSwitchToggled = value;
                });
              }),
              SizedBox(height: 16,),
              ElevatedButton(onPressed: ()async{
                await Preferencehelper.saveData(username: _controller.text, isDarkMode: _isSwitchToggled, age: 20);
                await _loadStoredData();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data & Theme Saved Successfully')),);
              }, child: Text('Save Data')),
              SizedBox(height: 24,),
              Divider(),
              SizedBox(height: 24,),
              Text('Saved Username: $_savedUsername',style: TextStyle(fontSize: 18),),
              SizedBox(height: 8,),
              Text('Dark Mode Settings: $_savedDarkMode',style: TextStyle(fontSize: 18),),

              Spacer(),

              OutlinedButton(
                style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
                onPressed: ()async{
                  await Preferencehelper.clearData();
                  await _loadStoredData();
                  _controller.clear();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data Saved')));
                },child: Text('Clear All Prefs'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}