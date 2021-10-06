import 'package:flutter/material.dart';
import '/data/activity_data.dart';
import '/provider/activity_notifier.dart';
import '/widget/custom_input.dart';
import 'package:provider/provider.dart';
import 'activity_list_view.dart';

class InputActivity extends StatefulWidget {

  final Activity? activity; // inisalisasi model Activity. untuk melakukan edit data, diberika ? agar bisa null

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

      //kak dimas bisa bantu
      //mengambil data dari widget.activy.date lalu menampilkannya pada bagian tanggal
      // mengambil data dari widget.activity.time lalu menampilkannya pada bagian waktu
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
        Text(
          'Selected time: ${_timeDefault.format(context)}',
        ),
        SizedBox(height: 8),
        ElevatedButton(
          onPressed: _selectTime,
          child: Text('SELECT TIME'),
        ),
      ],
    );
  }

  Widget _buildDatePicker(){ // widget untuk melakukan pick tanggal
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$_dateDefault',
        ),
        SizedBox(height: 8),
        ElevatedButton(
          onPressed: _selectDate,
          child: Text('SELECT DATE'),
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    ActivityNotifier activityNotifier = Provider.of<ActivityNotifier>(context);

    //kak dimas bisa bantu ubah tampilan widget agar lebih rapih dan tidak telalu banyak baris

    return Scaffold(
      body:SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 16),
                CustomInput(
                    label: 'Name of Activity',

                    controller: _namecontroller),
                SizedBox(height: 16),
                CustomInput(
                    label: 'Activity Description',
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

                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return ActivityScreen();
                      }));
                },
                    child: Text(title)
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
