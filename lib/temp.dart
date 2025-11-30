import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Temp extends StatelessWidget{
  const Temp({super.key});
@override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.orangeAccent,Colors.orange,Colors.deepOrange,Colors.deepOrangeAccent],
          begin: Alignment.centerLeft,)
        ),
       child: Column(
        
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center( 
            child: Text('Hello  Karan!',
            style: GoogleFonts.sacramento(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Colors.white

            )
            )
            ),
          ],
        ),
      ),
      );
}
}