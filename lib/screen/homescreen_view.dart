import 'package:flutter/material.dart';
import 'package:personal_activity_app/provider/activity_notifier.dart';
import 'package:provider/provider.dart';

import 'activity_list_view.dart';

class HomeScreen extends StatelessWidget {


  // halaman dashboard ini boleh diubah desainnya, jadi ini yg tampilan pertama kali muncul

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: OutlinedButton(
          onPressed: (){
            //bagian ini tombol buat pindah ke ListView, ini jangan dihapus
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ActivityScreen();
            }));
          },
          child: Text("Ini Ceritanya Dashboard"),
        ),
      ),
    );
  }
}
