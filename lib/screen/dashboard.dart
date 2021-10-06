import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  // membuat dashboard untuk menampilkan deskripsi dari aplikasi AktifitasKu
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(15),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  shape: BoxShape.circle
                ),
                child: const Icon(Icons.star,
                color: Colors.white,
                size: 20,),
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Selamat Datang di AktifitasKu',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  ),
                  const SizedBox(height: 10),
                  Text('Disini anda dapat membuat list\natau daftar aktifitas yang akan\nanda lakukan setiap hari untuk\nmemulai hari agar lebih produktif',
                  style: TextStyle(
                    fontSize: 16, color: Colors.grey[500]
                  ),
                  ),
                ],
              )
            ],
          ),
        ),
        Positioned(
          bottom: 15,
          right: 15,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(15)
            ),
            child: const Icon(Icons.arrow_forward,
            color: Colors.white,),
          ),
        )
      ],
    );
  }
}
