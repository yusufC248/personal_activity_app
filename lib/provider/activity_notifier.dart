import 'package:flutter/foundation.dart';
import '/data/activity_data.dart';

//Nah ini bagian providernya
// disini bagian yg ngatur untuk menambahkan data, menghapus data, mengedit data

class ActivityNotifier extends ChangeNotifier{
  final List<Activity> _activityList = <Activity>[]; // ini kita bikin list kosong yg nanti bakal digunain

  List<Activity> get activityList => _activityList; // Setelah itu list yg tadi kita get, dikasih nama lagi activityList

  addActivity(Activity act){ // ini parameternya Activty atau model yg di file activity_data.dart
    //bagian ini buat menambahkan data
    _activityList.add(act); // penjelasan : ini sama kayak add list biasa
    notifyListeners(); // ini bagian terpenting, sebenernya saya kurang paham konsepnya wkwk
  }


  editActivity(Activity act, String name, String desc, String date, String time){// parameternya mengikuti data apa aja yg diubah
    //bagian ini untuk edit data
    //jadi data yg udah di edit, bakal nge save ulang dengan indeks yg sama,

    act.name = name; // ini mengubah nama yg sebelum menjadi sesudah diedit
    act.descActivity = desc;  // ini mengubah deskripsi aktivity yg sebelum menjadi sesudah diedit
    act.date = date;  // ini mengubah tanggal yg sebelum menjadi sesudah diedit
    act.time = time;  // ini mengubah waktu yg sebelum menjadi sesudah diedit
    notifyListeners();
  }

  deleteActivity(index){// bagian fungsi apus data, kita tinggal mengambil parameter index
    _activityList.removeWhere((_activity) => _activity.name == activityList[index].name);
    //disini primary key nya menggunakan nama aktivitas. jadi dihapus berdasarkan nama indeks ke berapa

    notifyListeners();
  }
}