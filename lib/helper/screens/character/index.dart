import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:mockup_rick/controller/characters.dart';
import 'package:mockup_rick/helper/helper.dart';
import 'package:mockup_rick/model/getEpisodes.dart';
import 'package:mockup_rick/model/get_character.dart';
import 'package:mockup_rick/model/get_multiple_characters.dart';

class CharacterScreen extends StatefulWidget {
  Result? getCharacter;
   CharacterScreen({this.getCharacter}) ;

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  bool progressCode = true;
  bool progressCodeInterest = true;
  List episodes = [];
  final ScrollController _episdoeScrollController =  ScrollController();
  final ScrollController _interestingScrollController =  ScrollController();

  String errorMessage = '';
  getAllEpisodes()async{
    try{
      errorMessage =  await  searchCharacter.getEpisodes(widget.getCharacter);
        if(mounted){
          setState(() {
            if(listGetEpisodes.isEmpty){
              toast("Error message:$errorMessage");
            }
            progressCode = false;
          });
        }


    }catch(e){
      if(mounted){
        setState(() {
          progressCode = false;
        });
      }
      print("error subscriptions: $e");
    }

  }
  getTopInterestingCharacter()async{
    try{
      errorMessage =  await  searchCharacter.getInterestingCharacter();
      if(mounted){
        setState(() {
          print("listCharactersInterest:${listCharactersInterest.length}");
          if(listCharactersInterest.isEmpty){
            toast("Error message:$errorMessage");
          }
            progressCodeInterest = false;
        });
      }

    }catch(e){
      if(mounted){
        setState(() {
          progressCodeInterest = false;
        });
      }
      print("error subscriptions: $e");
    }

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllEpisodes();
    getTopInterestingCharacter();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Stack(
                    children: [
                      displayImage("${widget.getCharacter!.image}",radius: 0,width: appWidth(context),height: 200),
                      Positioned(
                        top: 30,
                        child: IconButton(onPressed: (){
                          Navigator.pop(context);
                        }, icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),
                      ),
                      Container(
                        height: 200,
                        margin: EdgeInsets.only(top: 200),
                        color: appMainDarkGrey,
                      ),
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 140),
                          child: displayImage("${widget.getCharacter!.image}",radius: 60),
                        ),
                      ),

                      Center(
                        child: Container(
                          margin: EdgeInsets.only(left: 10,top: 240),
                          padding: appPadding(10),
                          child: Image.asset("assets/images/Vector.png",color: Colors.yellow,),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10,top: 300),
                        child: Center(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("assets/images/Ellipse 1.png",),
                                  SizedBox(width: 10,),
                                  sText("${widget.getCharacter!.status.toUpperCase()}",color: Colors.white)
                                ],
                              ),
                              SizedBox(height: 10,),
                              Container(
                                child:  sText("${widget.getCharacter!.name}",color: Colors.white,weight: FontWeight.bold,size: 20),
                              ),
                              SizedBox(height: 10,),
                              sText("${widget.getCharacter!.species.toUpperCase()}",color: Colors.white)
                            ],
                          ),
                        ),
                      ),


                    ],
                  ),
                  Container(
                    padding: appPadding(20),
                    child: sText("Information",weight: FontWeight.bold,color: Colors.grey,size: 20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(top: 0,bottom: 10,right: 10,left: 20),
                          padding: appPadding(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Icon(Icons.info,color: Colors.grey,),
                                    SizedBox(width: 5,),
                                    sText("Gender:")
                                  ],
                                ),

                              ),
                              SizedBox(height: 5,),
                              sText("${widget.getCharacter!.gender.toUpperCase()}",weight: FontWeight.bold,color: Colors.black)
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(top: 0,bottom: 10,right: 20,left: 10),
                          padding: appPadding(10),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Icon(Icons.info,color: Colors.grey,),
                                    SizedBox(width: 5,),
                                    sText("Origin:")
                                  ],
                                ),

                              ),
                              SizedBox(height: 5,),
                              sText("${widget.getCharacter!.origin.name.toUpperCase()}",weight: FontWeight.bold,color: Colors.black,maxLines: 1)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(top: 0,bottom: 0,right: 10,left: 20),
                          padding: appPadding(10),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Icon(Icons.info,color: Colors.grey,),
                                    SizedBox(width: 5,),
                                    sText("Type:")
                                  ],
                                ),

                              ),
                              SizedBox(height: 5,),
                              sText("${widget.getCharacter!.type.isEmpty ? "N/A" : widget.getCharacter!.type}",weight: FontWeight.bold,color: Colors.black,)
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(),
                      ),
                    ],
                  ),

                  Container(
                    padding: appPadding(20),
                    child: sText("Episodes",weight: FontWeight.bold,color: Colors.grey,size: 20),
                  ),
                  listGetEpisodes.isNotEmpty ?
                  Column(
                    children: [
                      StaggeredGridView.countBuilder(
                        padding: EdgeInsets.only(left: 15,right: 15),
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        controller: _episdoeScrollController,
                        itemCount:listGetEpisodes.length > 3 ? 4 : listGetEpisodes.length,
                        itemBuilder: (BuildContext context, int index) =>
                            GestureDetector(
                              onTap: (){
                              },
                              child:  Container(
                                margin: EdgeInsets.only(top: 5,bottom: 5,right: 5,left: 5),
                                padding: appPadding(5),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        child: sText("${listGetEpisodes[index].name}:",maxLines: 1)
                                    ),
                                    SizedBox(height: 5,),
                                    sText("${listGetEpisodes[index].episode}",weight: FontWeight.bold,color: Colors.black),
                                    SizedBox(height: 10,),
                                    sText("${DateFormat.yMMMMd().format(listGetEpisodes[index].created)}",color: Colors.grey,)
                                  ],
                                ),
                              ),
                            ),
                        staggeredTileBuilder: (int index) =>
                        new StaggeredTile.fit(1),
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0,
                      ),
                      Center(
                        child: Container(
                          padding: EdgeInsets.only(left: 20,right: 20,top: 10),
                          child: sText("Ver más",weight: FontWeight.bold,color: appMainDarkGrey,size: 20),
                        ),
                      ),
                    ],
                  ) : listGetEpisodes.isEmpty && progressCode ? Container(child: Center(child: progress(),),) :Container(child: Center(child: sText("No Episdoes for this Character"),),) ,



                  Container(
                    padding: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
                    child: sText("Personajes interesantes",weight: FontWeight.bold,color: Colors.grey,size: 20),
                  ),
                  listCharactersInterest.isNotEmpty ?
                  Column(
                    children: [
                      ListView(
                controller: _interestingScrollController,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: bottomPadding(0),
                children: listCharactersInterest.map<Widget> ( (getCharacters) {
              return      Container(
                margin: EdgeInsets.only(left: 15,right: 15,bottom: 20),
                width: appWidth(context),
                child: Row(
                      children: [
                        Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),topLeft:  Radius.circular(10)),
                                child: displayImage("${getCharacters.image}",radius: 0,height: 150),
                              ),
                            ),
                            Positioned(
                              right: 10,
                              bottom: 10,
                              child:   Container(
                                padding: appPadding(10),
                                child: Image.asset("assets/images/Vector.png",color: Colors.yellow,),
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    shape: BoxShape.circle
                                ),
                              ),
                            )
                          ],
                        ),
                        // SizedBox(width: 5,),
                        Expanded(
                          child: Container(
                            // width: 200,
                            padding: EdgeInsets.only(top: 7,right: 5,left: 10),
                            height: 150,
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(color: Colors.black),
                                bottom: BorderSide(color: Colors.black),
                                right: BorderSide(color: Colors.black,
                                ),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        child: Image.asset("assets/images/Ellipse 1.png"),
                                      ),
                                      SizedBox(width: 5,),
                                      Container(
                                        width: 150,

                                        child: sText("${getCharacters.status} - ${getCharacters.species}",maxLines: 1),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  child: sText("${getCharacters.name}",weight: FontWeight.bold,maxLines: 1),
                                ),
                                SizedBox(height: 10,),
                                Container(
                                  child: sText("Last known location"),
                                ),
                                Container(
                                  child: sText("${getCharacters.location.name}",weight: FontWeight.bold,maxLines: 1),
                                ),
                                SizedBox(height: 10,),
                                Container(
                                  child: sText("First seen in:"),
                                ),
                                Container(
                                  child: sText("Never Ricking Morty Morty Morty Morty",weight: FontWeight.bold,maxLines: 1),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                ),
              );
            }).toList(),

      ),
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: appMainDarkGrey
                          ),
                          padding: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
                          margin: bottomPadding(20),
                          child: sText("Compartir personaje",weight: FontWeight.bold,color: Colors.white,size: 20),
                        ),
                      ),
                    ],
                  ): listCharactersInterest.isEmpty && progressCodeInterest ? Container(height: 100,child: Center(child: sText("Fetching"),),) : Container(height: 100,child: Center(child: sText("Empty Interesting Characters"),),),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 120,
              decoration:  BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/footer_image.png")
                  )
              ),
              child: Container(

                child: Image.asset("assets/images/Logo.png"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
