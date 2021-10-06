import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String label; // inisialisasi label
  final TextEditingController controller; // inisialisasi controller

  const CustomInput({Key? key,
    required this.label,
   required this.controller, }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: this.label, // buat nanti mengisi label yg beda beda
        border: OutlineInputBorder(),
      ),
      validator: (String? value){
        if(value!.isEmpty){
          return '$label tidak boleh kosong'; // jadi bisa langsung validator
        }
        return null;
      },
    controller: this.controller, // buat menyimpan datanya
    );
  }
}
