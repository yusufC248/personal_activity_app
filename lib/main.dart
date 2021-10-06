import 'package:flutter/material.dart';
import 'package:provider/single_child_widget.dart';
import '/provider/activity_notifier.dart';
import 'package:provider/provider.dart';
import 'screen/homescreen_view.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider( 
      providers: <SingleChildWidget>[
        ChangeNotifierProvider(
          //ActivityNotivier buat ngatur fungsi fungsi seperti add, edit, delete
            create: (_) => ActivityNotifier(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
