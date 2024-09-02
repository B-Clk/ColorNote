import 'package:color_note/NotesPage.dart';
import 'package:color_note/PasswordPage.dart';
import 'package:color_note/main_light.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'ColorNote'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int myIndex = 0;
  List<Widget> barItems = const [
    NotesPage(),// Icon(Icons.notes),
    PasswordPage(),// Icon(Icons.notifications_active_rounded),
  ];
  bool temaValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade700,
        title: Text(
            widget.title,
            style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(
            // burda ShaderMask icon ummuzun rengarenk olmasını sağlar
            icon: ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  colors: <Color>[Colors.red, Colors.yellow.shade700, Colors.green, Colors.blue],
                  tileMode: TileMode.mirror,
                ).createShader(bounds);
              },
              child: Icon(Icons.palette,color: Colors.white,),
            ), // Renk paleti ikonu
            onPressed: (){}, // İkon tıklandığında yapılacak işlemler
          ),
          IconButton(
            icon: Icon(Icons.account_circle_rounded,color: Colors.white,),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => PasswordPage()));
            },
          ),
          IconButton(
              icon: Icon(Icons.more_vert,color: Colors.white,),// Üç nokta ikonu
              onPressed: (){
                // İkon tıklandığında yapılacak işlemler
              },
          ),
          Switch(
            value: temaValue,
            activeTrackColor: Colors.white,
            //yuvarlağın rengi
            activeColor: Colors.blueGrey,
            inactiveTrackColor: Colors.black38,
            inactiveThumbColor: Colors.black54,
            onChanged: (veri){
              setState(() {
                temaValue  = veri;
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyLightHomePage(title: ' ')));
              });
            },
          ),
        ],
      ),
      body: IndexedStack(
        children: barItems,
        index: myIndex,
      ),
        bottomNavigationBar : BottomNavigationBar(
          showSelectedLabels: true,
          backgroundColor: Colors.grey.shade700,
          type: BottomNavigationBarType.fixed,
          currentIndex: myIndex,
          onTap: (int newIndex) {
            setState(() {
              myIndex = newIndex;
              print("${newIndex} is selected");
            });
          },
          items: const[
            BottomNavigationBarItem(
                label: 'Notes',
                icon: Icon(Icons.note_alt_outlined,color: Colors.white,),
                backgroundColor: Colors.amber
            ),
            BottomNavigationBarItem(
                label: 'To Do List',
                icon: Icon(Icons.notifications_active_rounded,color: Colors.white,),
                backgroundColor: Colors.cyan

            ),
          ],
        ),
    );
  }
}
