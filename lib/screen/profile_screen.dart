import 'package:flutter/material.dart';
import '../services/sharedpref.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _email = '';
  String _nama = '';
  String _dob = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    String? email = await SharedPreferencesService.getEmail();
    String? dob = await SharedPreferencesService.getDateOfBirth();
    String? nama = await SharedPreferencesService.getName();
    setState(() {
      _email = email ?? 'No Email';
      _dob = dob ?? 'No Tanggal Lahir';
      _nama = nama ?? 'No Nama';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Nama: $_nama',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Email: $_email',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Tanggal Lahir: $_dob',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
