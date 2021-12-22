import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sp_login_app/main.dart';

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({Key? key}) : super(key: key);

  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {


String? spKullaniciAdi;
String? spSifre;

Future<void> oturumBilgisiOku() async {

var sp = await SharedPreferences.getInstance();

setState(() {
  spKullaniciAdi= sp.getString("kullaniciAdi") ?? "Kullanıcı Adı Yok";
   spSifre= sp.getString("sifre") ?? "şifre";
});


}

Future<void> cikisYap() async {

var sp = await SharedPreferences.getInstance();

sp.remove("kullaniciAdi");
sp.remove("sifre");

 Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginEkrani()));

}

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    oturumBilgisiOku();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Anasayfa"),
        actions: [
          IconButton(onPressed: (){
cikisYap();
          }, icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              Text("Kullanıcı Adı: $spKullaniciAdi", style: TextStyle(fontSize: 30),),
              Text("Şifre: $spSifre", style: TextStyle(fontSize: 30),),
            ],
          ),
        ),
      ),
    );
  }
}
