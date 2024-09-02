import 'package:color_note/main.dart';
import 'package:flutter/material.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({super.key});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {

  var tfController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade700,
        title: Text(
          "Hesabım",
          style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(
            icon: ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  colors: <Color>[Colors.red, Colors.yellow.shade700, Colors.green, Colors.blue],
                  tileMode: TileMode.mirror,
                ).createShader(bounds);
              },
              child: Icon(Icons.palette,color: Colors.white,),
            ),
            onPressed: (){},
          ),
          IconButton(
            icon: Icon(Icons.more_vert,color: Colors.white,),
            onPressed: (){
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: tfController,
              obscureText: true,
              textAlign: TextAlign.start,
              maxLength: 6,
              style: TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                hintStyle: TextStyle(
                  color: Colors.green.shade800,
                  fontSize: 20,
                ),
                hintText: ("Yazınız"),
                labelText: ("Şifre Giriniz"),
                labelStyle: TextStyle(
                  fontSize: 25,
                  color: Colors.green.shade800,
                ),
                //arka plan rengi için
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                suffixIcon: Icon(Icons.account_circle_rounded),
              ),
            ),
            ElevatedButton(
                child: Text("Kayıt Ol"),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
                },
            ),
          ],
        ),
      ),
    );
  }
}
