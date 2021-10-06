import 'package:flutter/material.dart';
import 'package:personal_activity_app/screen/homescreen_view.dart';
import '/data/activity_data.dart';
import '/provider/activity_notifier.dart';
import '/widget/custom_input.dart';
import 'package:provider/provider.dart';
import 'activity_list_view.dart';

class InputActivity extends StatefulWidget {

  final Activity? activity; // inisalisasi model Activity. untuk melakukan edit data, diberikan ? agar bisa null

  const InputActivity({Key? key, this.activity}) : super(key: key);

  @override
  _InputActivityState createState() => _InputActivityState();
}

class _InputActivityState extends State<InputActivity> {

  String title = ""; // untuk mengubah tulisan pada tombol, "SIMPAN" atau "EDIT"

  List<Activity> activityList = []; // LIST kosong yg akan digunakan

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // global state untuk form

  TextEditingController _namecontroller = TextEditingController(); // controller untuk nama
  TextEditingController _desccontroller = TextEditingController(); // controller untuk deskripsi aktivitas
  TimeOfDay _timeDefault = TimeOfDay(hour: 7, minute: 15); // tanggal default yang ditentukan
  DateTime _dateDefault = DateTime(2021, 09, 12); // waktu default yang ditentukan


  @override
  void initState(){ // initstate digunakan untuk melakukan pendeklarasian paling awal
    super.initState();

    //Pada bagian ini
    //Jika data sudah ada atau tidak kosong, maka kita bisa melakukan edit data
    // widget.activy merupakan lemparan data dari list view yang diklik
    // tapi jika data kosong, maka kita bisa menambahkan data baru

    if(widget.activity != null){
      _namecontroller.text = widget.activity!.name;
      _desccontroller.text = widget.activity!.descActivity;

      title = "EDIT";
    }else{
      title = "SIMPAN";
    }
  }

  void _selectDate() async { // fungsi untuk melakukan pemilihan tanggal
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: _dateDefault,
      firstDate: DateTime(2017, 1),
      lastDate: DateTime(2022, 7),
      helpText: 'Select a date',
    );
    if (newDate != null) {
      setState(() {
        _dateDefault = newDate;
      });
    }
  }

  void _selectTime() async { // fungsi untuk melakukan pemilihan waktu
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _timeDefault,
    );
    if (newTime != null) {
      setState(() {
        _timeDefault = newTime;
      });
    }
  }

  Widget _buildTimePicker(){ // widget untuk tempat melakukan pick waktu
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 8),
        ElevatedButton(
          style: ButtonStyle(
            shadowColor: MaterialStateProperty.all(Colors.yellow),
            backgroundColor: MaterialStateProperty.all(Colors.grey.shade800)
          ),
          onPressed: _selectTime,
          child: Text('PILIH JAM'),
        ),
      ],
    );
  }

  Widget _buildDatePicker(){ // widget untuk melakukan pick tanggal
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 8),
        ElevatedButton(
            style: ButtonStyle(
            shadowColor: MaterialStateProperty.all(Colors.yellow),
            backgroundColor: MaterialStateProperty.all(Colors.grey.shade800)
            ),
          onPressed: _selectDate,
          child: Text('PILIH TANGGAL'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ActivityNotifier activityNotifier = Provider.of<ActivityNotifier>(context);
    return Scaffold(
      body:SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.run_circle_outlined),
                  SizedBox(height: 16),
                  CustomInput(
                      label: 'Jenis Aktifitas',
                      
                      controller: _namecontroller),
                  Icon(Icons.note_alt),    
                  SizedBox(height: 16),
                  CustomInput(
                      label: 'Deskripsi aktifitas',
                      controller: _desccontroller),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _buildTimePicker(),
                      _buildDatePicker(),
                    ],
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                      onPressed: (){
                        if(!_formKey.currentState!.validate()){
                          return;
                        }

                        if(widget.activity != null){
                          activityNotifier.editActivity(
                              widget.activity!,
                              _namecontroller.text,
                              _desccontroller.text,
                              _dateDefault.toString(),
                              _timeDefault.format(context));
                        }else{
                          activityNotifier.addActivity(
                              Activity(
                                  _namecontroller.text,
                                  _desccontroller.text,
                                  _dateDefault.toString(),
                                  _timeDefault.format(context)
                               )
                            );
                          }

                        Navigator.pushAndRemoveUntil(
                            context, MaterialPageRoute(builder: (context) =>
                            HomeScreen()), (Route<dynamic> route) => false);
                      },
                      child: Text(title)
                  ),
                ],
              ),
          ),
        ),
      ),
    );
  }
}
