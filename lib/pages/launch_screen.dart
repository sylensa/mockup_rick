import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mockup_rick/helper/helper.dart';
import 'package:mockup_rick/helper/screens/home/index.dart';

class LaunchScreen extends StatefulWidget {
  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {





  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 70),
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage("assets/images/Fondo imagen.png")
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  child: Image.asset("assets/images/Logo.png"),
                ),
                Container(
                  child: Image.asset("assets/images/Rick-And-Morty-Logo 1.png"),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: sText("Bienvenido a Rick and Morty",color: Colors.white,size: 30,align: TextAlign.center),
                ),
                SizedBox(height: 20,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  child: sText("En esta prueba, evaluaremos su capacidad para construit la aplicación mediante el análisis de código y la reproducción del siquiente diseño.",color: Colors.white,align: TextAlign.center),
                ),
              ],
            ),

            SizedBox(height: 50,),
            GestureDetector(
              onTap: (){
                goTo(context, Home(),replace: true);
              },
              child: Container(
                child: sText("Continuar",weight: FontWeight.bold,color: Colors.white),
                padding: EdgeInsets.symmetric(horizontal: 60,vertical: 15),
                decoration: BoxDecoration(
                  color: buttonColor,
                    borderRadius: BorderRadius.circular(30),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
