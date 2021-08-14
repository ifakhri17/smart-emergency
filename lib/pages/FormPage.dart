import 'package:flutter/material.dart';
import 'package:smart_emergency/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class FormPage extends StatefulWidget { // contructor buat ambil nim dri page sblmnya 
  final String inputNIM;
  const FormPage({Key? key, required this.inputNIM}) : super(key: key);

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> { 
  TextEditingController inputSuhu = new TextEditingController();
  TextEditingController inputJantung = new TextEditingController();
  TextEditingController inputo2 = new TextEditingController();
  TextEditingController inputGejala = new TextEditingController();

  final firestoreInstance = FirebaseFirestore.instance; // komunikasi buat ke firestore na 
  String nama = ''; // di inisialisasi harus di isi 0 biar ngecocokin lsg tampil kepanggil ke form page
  String NIM = '';
  String prodi = '';
  String jurusan = '';
  String kelas = '';

  final databaseInstance = FirebaseDatabase.instance.reference();

  Future<void> getDatabase() async {
    await databaseInstance.once().then((result) => print('result = $result'));
  }

  void getData() async{ // muat ngedapatin data dri firestore
    final data = await firestoreInstance.collection('users').doc(widget.inputNIM).get();
    DocumentSnapshot snapshot = data;
    setState(() { // U I dibangun ulang semua tampilan
      nama = snapshot['Nama'];
      NIM = snapshot['NIM'];
      prodi = snapshot['Prodi'];
      jurusan = snapshot['Jurusan'];
      kelas = snapshot['Kelas'];
    });
  }

  void updateData() async { // input pengiriman menuju firrestore
    firestoreInstance.collection('users').doc(widget.inputNIM).update(
      {
        'Suhu Tubuh': inputSuhu.text,
        'Denyut Jantung' : inputJantung.text,
        'Saturasi O2' : inputo2.text,
        'Gejala Lain' : inputGejala.text
      }
    );
    print('Berhasil'); // notif terkirim
  }

  @override
  void initState() { // fungsi yg dijalanin pertamakali saat program dipanggil (buat ngedapetin data)
    super.initState();
    getData();
    getDatabase();
  }

  @override //fungsi buat menyelesaikan program kalo sudah tidak dipakai
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override // interface
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_outlined
          ),
        ),
        title: Text(
          'Smart Emergency'
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[200],
      ),
      backgroundColor: Colors.blue,
      body: ListView(
        children: [
          SizedBox(
            height: screenHeight(context)*(1/12),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.all(10),
              height: screenHeight(context)*(1/1.5),
              width: screenWidth(context)*(1/1.25),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: Text(
                      'FORMULIR KONDISI KESEHATAN',
                      style: TextStyle(
                          fontSize: screenHeight(context)*(1/43),
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight(context)*(1/20),
                  ),
                  formUdahKeisi('Nama', nama),
                  formUdahKeisi('NIM', NIM),
                  formUdahKeisi('Prodi', prodi),
                  formUdahKeisi('Jurusan', jurusan),
                  formUdahKeisi('Kelas', kelas),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Suhu Tubuh',
                        style: TextStyle(
                            fontSize: screenHeight(context)*(1/45),
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Container(
                        width: screenWidth(context)*(1/2),
                        child: TextFormField(
                          controller: inputSuhu,
                          maxLines: 1,
                          decoration: InputDecoration(
                            isDense: true,
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Suhu tubuh',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            contentPadding:EdgeInsets.all(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Denyut Jantung',
                        style: TextStyle(
                            fontSize: screenHeight(context)*(1/55),
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Container(
                        width: screenWidth(context)*(1/2),
                        child: TextFormField(
                          controller: inputJantung,
                          maxLines: 1,
                          decoration: InputDecoration(
                            isDense: true,
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Denyut jantung',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            contentPadding:EdgeInsets.all(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Saturasi O2',
                        style: TextStyle(
                            fontSize: screenHeight(context)*(1/45),
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Container(
                        width: screenWidth(context)*(1/2),
                        child: TextFormField(
                          controller: inputo2,
                          maxLines: 1,
                          decoration: InputDecoration(
                            isDense: true,
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Saturasi O2',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            contentPadding:EdgeInsets.all(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Gejala lain',
                        style: TextStyle(
                            fontSize: screenHeight(context)*(1/45),
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Container(
                        width: screenWidth(context)*(1/2),
                        height: screenHeight(context)*(1/7),
                        child: TextFormField(
                          controller: inputGejala,
                          maxLines: 5,
                          decoration: InputDecoration(
                            isDense: true,
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Gejala lain',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            contentPadding:EdgeInsets.all(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () { // ketika di tekan ngejalani fungsi data untuk update
                      updateData(); // jika update data selesai langsung nampilindialog
                      showDialog(context: context, builder: (_) => dialogBerhasil(context));
                    },
                    child: Container(
                      width: screenWidth(context)*(1/5),
                      height: screenWidth(context)*(1/10),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(8)
                      ),
                      child: Center(
                        child: Text(
                          'KIRIM',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: screenHeight(context)*(1/50)
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget formUdahKeisi(String judul, String hasil){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          judul,
          style: TextStyle(
              fontSize: screenHeight(context)*(1/45),
              fontWeight: FontWeight.bold
          ),
        ),
        Container(
          padding: EdgeInsets.only(
            top: 5,
            left: 10
          ),
          width: screenWidth(context)*(1/2),
          height: screenHeight(context)*(1/30),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              color: Colors.white
          ),
          child: Text(
            hasil
          ),
        ),
      ],
    );
  }

  Widget dialogBerhasil(BuildContext context){
    return AlertDialog(
      title: Text(
        'BERHASIL'
      ),
      content: Text(
        'Data kamu berhasil dikirim',
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
}


