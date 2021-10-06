import 'package:flutter/material.dart';
import '/screen/activity_list_view.dart';
import 'dashboard.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Dashboard(),
          Container(
            padding: EdgeInsets.all(15),
            child: Text(
              'AktifitasKu',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ActivityScreen(),
          ),
        ],
      ),
    );
  }

  // membuat Appbar aplikasi
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 2,
      title: Row(
        children: [
          SizedBox(
            height: 45,
            width: 45,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network('https://i.pinimg.com/564x/15/a4/5e/15a45e1342ac7968dd824036a2576132.jpg'),
            ),
          ),
          const SizedBox(width: 10,),
          const Text('Hi, Lisa!',
          style: TextStyle(
            color: Colors.black,
            fontSize: 26,
            fontWeight: FontWeight.bold
          ),
          ),
        ],
      ),
      actions: const [
        Icon(Icons.more_vert,
        color: Colors.black,
        size: 40,
        )
      ],
    );
  }
}
