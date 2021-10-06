import 'package:flutter/material.dart';

// bagian ini adalah custom widget input yg bisa disesuaikan
//Bagian ini bisa di ubah desainnya
//kalo ada widget yg mau ditambahin kayak padding atau yg lain, boleh


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
