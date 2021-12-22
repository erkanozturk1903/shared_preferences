import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sp_login_app/anasayfa.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Future<bool> oturumKontrol() async {
    var sp = await SharedPreferences.getInstance();

    String spKullaniciAdi = sp.getString("kullaniciAdi") ?? "Kullanıcı Adı Yok";
    String spSifre = sp.getString("sifre") ?? "şifre";

    if (spKullaniciAdi == "admin" && spSifre == "123") {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<bool>(future: oturumKontrol(),builder: (context, snpashot){
        if(snpashot.hasData){
          bool? gecisIzni = snpashot.data;
          return gecisIzni! ? const AnaSayfa() : const LoginEkrani();
        }else{
          return Container();
        }
      },),
    );
  }
}

class LoginEkrani extends StatefulWidget {
  const LoginEkrani({Key? key}) : super(key: key);

  @override
  _LoginEkraniState createState() => _LoginEkraniState();
}

class _LoginEkraniState extends State<LoginEkrani> {
  var tfKullaniciAdi = TextEditingController();
  var tfSifre = TextEditingController();

  var scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> girisKontrol() async {
    var ka = tfKullaniciAdi.text;
    var sf = tfSifre.text;

    if (ka == "admin" && sf == "123") {
      var sp = await SharedPreferences.getInstance();
      sp.setString("kullaniciAdi", ka);
      sp.setString("sifre", sf);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => AnaSayfa()));
    } else {
      scaffoldKey.currentState!
          .showSnackBar(SnackBar(content: Text("Giriş Hatalı")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: tfKullaniciAdi,
                decoration: const InputDecoration(hintText: "Kullanıcı Adı"),
              ),
              TextField(
                controller: tfSifre,
                decoration: const InputDecoration(hintText: "Şifre"),
              ),
              ElevatedButton(
                  onPressed: () {
                    girisKontrol();
                  },
                  child: const Text("Giriş Yap"))
            ],
          ),
        ),
      ),
    );
  }
}
