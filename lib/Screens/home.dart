// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:shopping_app/Screens/Drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  //   final auth = FirebaseAuth.instance;
  // @override
  // void initState() {
  //   super.initState();
  //   userAuth();
  // }

  // userAuth() async {
  //   final user = auth.currentUser;
  //   if (user != null) {
  //     print('Home');
  //     Timer(const Duration(milliseconds: 50), () {
  //       Navigator.push(context,
  //           MaterialPageRoute(builder: (context) => const HomeScreen()));
  //     });
  //   } else {
  //     print('Login');
  //     Timer(const Duration(milliseconds: 50), () {
  //       Navigator.push(context,
  //           MaterialPageRoute(builder: (context) => const LoginScreen()));
  //     });
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Grocery Store"),
        centerTitle: true,
        actions: const [],
      ),
      drawer: const CustomDrawer(),
      body:  Column(
        children: [Text("Drawer"),
       Center(child: CustomPaint(
  size: Size(500,380), 
  painter: RPSCustomPainter(),
),)],
      
      ),
    );
  }

  
}


  class RPSCustomPainter extends CustomPainter{
  
  @override
  void paint(Canvas canvas, Size size) {
    
    

  // Layer 1
  
  Paint paint_fill_0 = Paint()
      ..color = const Color.fromARGB(255, 4, 46, 186)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width*0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;
     
         
    Path path_0 = Path();
    path_0.moveTo(size.width*0.0032000,size.height*0.0031579);
    path_0.lineTo(0,size.height*0.0052632);
    path_0.lineTo(0,size.height*0.7921053);
    path_0.quadraticBezierTo(size.width*0.0545000,size.height*0.5723684,size.width*0.4588000,size.height*0.4584211);
    path_0.quadraticBezierTo(size.width*0.7685000,size.height*0.3214474,size.width*0.9972200,size.height*-0.0051842);
    path_0.lineTo(size.width*0.0032000,size.height*0.0031579);
    path_0.close();

    canvas.drawPath(path_0, paint_fill_0);
  

  // Layer 1
  
  Paint paint_stroke_0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width*0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;
     
         
    
    canvas.drawPath(path_0, paint_stroke_0);
  
    
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
  
}
  
  

