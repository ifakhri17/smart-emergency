import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_emergency/constant.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:smart_emergency/pages/FormPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> { //fungsi logic cek 
  String hasilScan = '';
  TextEditingController inputNIMManual = new TextEditingController();

  void checkData(String nimUser) async{
    final snapshot = await FirebaseFirestore.instance.collection('users').doc(nimUser).get();
    if (snapshot.exists){
      Navigator.push(context, MaterialPageRoute(builder: (context) => FormPage(inputNIM: nimUser),));
    }
    else{
      showDialog(context: context, builder: (_)=>dialogGagal(context, nimUser));
    }
  } // akhir kesatuan

  Widget dialogGagal(BuildContext context, String nimGagal){
    return AlertDialog(
      title: Text(
          'GAGAL'
      ),
      content: Text(
        'Maaf NIM kamu '+nimGagal+' belum terdaftar',
        textAlign: TextAlign.center,
      ),
      actions: [
        FlatButton(
          onPressed: (){
            Navigator.pop(context);
          },
          child: Text(
              'OK'
          ),
        )
      ],
    );
  }

  @override // intercae
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Smart Emergency',
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 2
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.blue[200],
      ),
      body: Center(
        child: Container(
          height: screenHeight(context)*(1/1.2),
          width: screenWidth(context)*(1/1.2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Selamat Datang',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: screenHeight(context)*(1/25),
                  letterSpacing: 2
                ),
              ),
              Center(
                child: GestureDetector( // button kamera
                  onTap: ()async{
                    hasilScan = await scanner.scan();
                    if(hasilScan != ''){ // hasil cek valid lsg muncul dadat nim dll
                      checkData(
                        hasilScan
                      );
                    }
                  },
                  child: Container(
                    height: screenHeight(context)*(1/8),
                    width: screenHeight(context)*(1/8),
                    decoration: BoxDecoration(
                        color: Colors.blue[200],
                        borderRadius: BorderRadius.circular(40),
                        boxShadow: [BoxShadow(
                            color: Colors.grey,
                            blurRadius: 2,
                            spreadRadius: 2,
                            offset: Offset(0,2)
                        )]
                    ),
                    child: Icon(
                      Icons.camera_alt_outlined,
                      size: screenHeight(context)*(1/15),
                      color: Colors.deepPurple,
                    ),
                  ),
                )
              ),
              Center(
                child: Container(
                  child: Text(
                    'Scan barcode KTM mu\nuntuk dapat melanjutkan\natau input manual NIM bila KTM tidak terbaca',
                    style: TextStyle(
                      fontSize: screenHeight(context)*(1/40),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: screenWidth(context)*(1/2.3), // input manual berupa angka
                  child: TextFormField(
                    controller: inputNIMManual,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      isDense: true,
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'NIM kamu',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      contentPadding:EdgeInsets.all(10),
                    ),
                  ),
                ),
              ),
              Center(
                child: GestureDetector( // kirim
                  onTap: (){
                    if (inputNIMManual.text.length == 9){
                      checkData(inputNIMManual.text);
                    }
                  },
                  child: Container(
                    width: screenWidth(context)*(1/6),
                    height: screenWidth(context)*(1/6),
                    decoration: BoxDecoration(
                        color: Colors.blue[200],
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [BoxShadow(
                            color: Colors.grey,
                            blurRadius: 2,
                            spreadRadius: 2,
                            offset: Offset(0,2)
                        )]
                    ),
                    child: Icon(
                        Icons.navigate_next_outlined
                    ),
                  ),
                ),
              ),
              Center(
                child: Text(
                  '*Harap scan barcode dahulu atau isi NIM dengan benar',
                  style: TextStyle(
                    color: Colors.brown
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
