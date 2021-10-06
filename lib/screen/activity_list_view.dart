import 'package:flutter/material.dart';
import 'package:personal_activity_app/provider/activity_notifier.dart';
import 'package:provider/provider.dart';
import 'input_activity_view.dart';

class ActivityScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    ActivityNotifier activityNotifier = Provider.of<ActivityNotifier>(context);
    //gunanya untuk memilih atau menggunakan data yg secara global setelah dari data provider

    return Scaffold(
      body: SafeArea(
        child: Scrollbar(
          isAlwaysShown: true, // untuk scrool agar selalu muncul
          child: Column(
            children: <Widget>[
              ElevatedButton(onPressed: (){
                //bagian ini jika di klik, akan menuju ke bagian Input form, Tanpa Melempar Data
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return InputActivity();
                }));
              },
                  child: Text("Tambah aktifitas baru")
              ),
              Expanded(
                child: Consumer<ActivityNotifier>( // harus dimasukan ke dalam widget consumer karena, untuk melakukan perubahan data yg akan ditampilkan
                  builder: (context, cnsm, child) => // cnsm merupakan penamaan untuk activityNotifier, CNSM bisa diganti dengan nama apapun
                ListView.builder(
                  shrinkWrap: true, // agar listview ga makan tempat
                  itemBuilder: (context, index) =>
                      InkWell(
                        onTap: (){ // untuk memilih indeks mana yg akan dipilih
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return InputActivity(activity: cnsm.activityList[index]);
                            // disini menambahkan data untuk dilempar kebagian input, karena data akan diedit
                            // cara nya yaitu cnsm.activityList[index]
                          }));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20),
                              ),
                          child: Card(//widget untuk menampilan item
                            child: Padding(
                            padding: EdgeInsets.all(8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                       Text(
                                            'Aktifitas : ${cnsm.activityList[index].name}',
                                            // untuk mengambil nama diperlukan cara seperti diatas
                                            style: TextStyle(fontSize: 17),
                                          ),
                                      Text(
                                          'Deskripsi : ${cnsm.activityList[index].descActivity}',
                                        // untuk mengambil deskripsi aktifitas diperlukan cara seperti diatas
                                          style: TextStyle(fontSize: 17),
                                        ),
                                       Text(
                                          'Tanggal : ${cnsm.activityList[index].date}',
                                         // untuk mengambil tangggal diperlukan cara seperti diatas
                                          style: TextStyle(fontSize: 17),
                                        ),
                                     Text(
                                          'Jam : ${cnsm.activityList[index].time}',
                                       // untuk mengambil waktu diperlukan cara seperti diatas
                                          style: TextStyle(fontSize: 17,),
                                        ),
                                    ],
                                  ),
                                      OutlinedButton(
                                        onPressed: (){
                                        cnsm.deleteActivity(index); // sintaks ini digunakan untuk memanggil fungsi delet yg ada di data,
                                        },
                                        child: Text("Delete",
                                          style: TextStyle(color: Colors.red
                                          ),
                                        ),
                                      ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                  itemCount: activityNotifier.activityList.length, // kita menggunakan activityNotifier karena data sudah menjadi bagian dari provider
                ),
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
