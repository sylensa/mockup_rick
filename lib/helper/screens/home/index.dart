import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mockup_rick/controller/characters.dart';
import 'package:mockup_rick/helper/helper.dart';
import 'package:mockup_rick/helper/screens/character/index.dart';
import 'package:mockup_rick/model/general_class.dart';
import 'package:mockup_rick/model/get_character.dart';
import 'package:number_paginator/number_paginator.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
bool progressCode = true;
String filter = '';
final ScrollController _scrollController =  ScrollController();
TextEditingController searchController = TextEditingController();
int selectedPageNumber = 0;
int numberPages = 1;

String errorMessage = '';



  getAllCharacter()async{
    try{
      errorMessage =  await  searchCharacter.getCharacter();
      if(mounted){
        setState(() {
          if(listCharacters.isNotEmpty){
            numberPages = listCharacters[0].info.pages;
          }else{
            toast("Error message:$errorMessage");
          }
          progressCode = false;
          selectedPageNumber = 0;
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

  searchAllCharacter({String search = ''} )async{
    try{
      errorMessage =  await  searchCharacter.searchCharacter(search: search);
      if(mounted){
        setState(() {
          if(listCharacters.isNotEmpty){
            numberPages = listCharacters[0].info.pages;
          }else{
            toast("Error message:$errorMessage");
          }
          progressCode = false;
          selectedPageNumber = 0;
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

  getPaginationCharacter({String pageNumber = ''} )async{
    try{
      errorMessage =  await  searchCharacter.paginationCharacter(pageNumber: pageNumber);
      if(mounted){
        setState(() {
          if(listCharacters.isNotEmpty){
            numberPages = listCharacters[0].info.pages;
          }else{
            toast("Error message:$errorMessage");
          }
          progressCode = false;
          // selectedPageNumber = 0;
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


  getFilterSearchCharacter({String genderValue = '',String statusValue = ''} )async{
    try{
      errorMessage =  await  searchCharacter.filterSearchCharacter(search: searchController.text,genderValue: genderValue,statusValue: statusValue);
      if(mounted){
        setState(() {
          if(listCharacters.isNotEmpty){
            numberPages = listCharacters[0].info.pages;
          }else{
            toast("Error message:$errorMessage");
          }
          progressCode = false;
          selectedPageNumber = 0;
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


  getSearchCharacters(){
    if(listCharacters.isNotEmpty){
      return ListView(
        controller: _scrollController,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: bottomPadding(70),
        children: listCharacters[0].results.map<Widget> ( (getCharacters) {
          return      GestureDetector(
            onTap: (){
              goTo(context, CharacterScreen(getCharacter: getCharacters,));
            },
            child: Container(
              margin: EdgeInsets.only(left: 20,right: 20,bottom: 20),
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
                  SizedBox(width: 0,),
                  Expanded(
                    child: Container(
                      height: 148,
                      padding: EdgeInsets.only(left: 5,top: 3,right: 5,bottom: 3),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // SizedBox(height: 5,),
                          Row(
                            children: [
                              Container(
                                padding: appPadding(5),
                                decoration: BoxDecoration(
                                  color: getStatus(getCharacters.status),
                                  shape: BoxShape.circle,

                                ),

                              ),
                              SizedBox(width: 5,),
                              Container(
                                width: 150,
                                child: sText("${getCharacters.status} - ${getCharacters.species}",maxLines: 1),
                              )
                            ],
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
            ),
          );
        }).toList(),

      );
    }else if(listCharacters.isEmpty && progressCode){
      return Container(height: appHeight(context)/2,child: Center(child: progress(),));
    }else{
      return Container(height: appHeight(context)/2,child: Center(child: sText("No Character was found"),));
    }


  }




void _settingModalBottomSheet(context){
  showModalBottomSheet(
      isDismissible: true,
      context: context,
      isScrollControlled: true,

      builder: (BuildContext context){
        return Container(
          height: 400,
          child: StatefulBuilder(
            builder: (BuildContext context,StateSetter stateSetter){
              return Container(
                child: Column(
                  children: [
                    Container(
                      padding: appPadding(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: sText("Filter by (Status/Gender)",color: Colors.black,family: "Brand-Bold",align: TextAlign.center,size: 20,weight: FontWeight.bold),
                          )

                        ],
                      ),
                    ),
                    Divider(color: Colors.grey,),
                    Expanded(
                      child:ListView.builder(
                          itemCount: listFilterName.length,
                          itemBuilder: (BuildContext context, int index){
                            return  GestureDetector(
                              onTap: ()async{
                                await searchCharacter.IsChecked(index);
                                stateSetter(() {

                                });
                              },
                              child: Column(
                                children: [
                                  Container(
                                    padding:EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            child: sText("${listFilterName[index].name}",color: Colors.black,family: "Brand-Bold",align: TextAlign.left,size: 20),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color:  appMainDarkGrey,
                                                width: 2.3),
                                          ),
                                          width: 24,
                                          height: 24,
                                          child: Theme(
                                            data: ThemeData(unselectedWidgetColor: Colors.white),
                                            child: Checkbox(
                                              checkColor: appMainDarkGrey,
                                              activeColor: Colors.transparent,
                                              value: selectedFilterName.contains(listFilterName[index]) ? true : false,
                                              tristate: false,
                                              onChanged: (bool? isChecked) async{
                                                print("hi");
                                                await searchCharacter.IsChecked(index);
                                                stateSetter(() {

                                                });

                                              },
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                  Divider(color: Colors.grey,),
                                ],
                              ),
                            );
                          }),
                    ),
                    SizedBox(height: 10,),
                    GestureDetector(
                      onTap: ()async{
                        String g_val = '';
                        String s_val = '';
                        setState(() {
                          reset();
                        });
                        if(selectedFilterName.isNotEmpty){
                          for(int i = 0; i < selectedFilterName.length; i++){
                            if(selectedFilterName[i].id == "status"){
                              s_val = selectedFilterName[i].name.toLowerCase();
                            }else{
                              g_val =  selectedFilterName[i].name.toLowerCase();
                            }
                          }
                          Navigator.pop(context);
                          await getFilterSearchCharacter(genderValue: g_val,statusValue: s_val);
                        }else{
                          getAllCharacter();
                        }
                      },
                      child: Container(
                        padding: appPadding(20),
                        color: appMainDarkGrey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Icon(Icons.search,color:Colors.white,size: 30,),
                            ),
                            SizedBox(width: 10,),
                            Container(
                              child: sText("Filter",color: Colors.white,family: "Brand-Bold",align: TextAlign.center,size: 20,weight: FontWeight.bold),
                            )                        ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },

          ),
        );
      }
  );
}

reset(){
  listCharacters.clear();

  progressCode = true;
  // searchController.clear();
}
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllCharacter();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  height: 280,
                  width: appWidth(context),
                  decoration: const BoxDecoration(

                      image: DecorationImage(
                        fit: BoxFit.fill,
                          image: AssetImage("assets/images/Fondo imagen home.png")
                      )
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Image.asset("assets/images/Rick-And-Morty-Logo 1.png"),
                      ),
                      Container(
                        width: appWidth(context),
                        height: 70,
                        color: appMainDarkGrey,
                        child: Row(
                          children: [
                            SizedBox(width: 15,),
                            Expanded(
                              child: TextFormField(
                                textInputAction: TextInputAction.search,
                                controller: searchController,
                                onFieldSubmitted: (String value){
                                  if(value.isNotEmpty){
                                    setState(() {
                                      selectedFilterName.clear();
                                      progressCode = true;
                                      listCharacters.clear();
                                    });
                                    searchAllCharacter(search: value);
                                  }else{
                                    setState(() {
                                      listCharacters.clear();
                                      progressCode = true;
                                      searchController.clear();
                                    });
                                    getAllCharacter();
                                  }
                                },

                                style: appStyle(col: Colors.white),
                                decoration: textDecorNoBorder(
                                 hint: "Search here",
                                  hintColor: Colors.white,
                                  fill: appMainDarkGrey,


                                  prefixIcon: Image.asset("assets/images/search.png")
                                ),
                              ),
                            ),
                            SizedBox(width: 20,),
                            GestureDetector(
                              onTap: (){
                                _settingModalBottomSheet(context);
                              },
                              child: Container(
                                margin: rightPadding(20),
                                child:  Image.asset("assets/images/bars.png"),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                listCharacters.isNotEmpty  ?
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      NumberPaginator(
                        numberPages: numberPages,
                        onPageChange: (int index) {
                          setState(() {
                            listCharacters.clear();
                            selectedPageNumber = index;
                            progressCode = true;
                          });

                          getPaginationCharacter(pageNumber:"${ selectedPageNumber + 1}");
                        },
                        // initially selected index
                        initialPage: selectedPageNumber,
                        // default height is 48
                        height: 50,
                        buttonShape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        buttonSelectedForegroundColor: Colors.yellow,
                        buttonUnselectedForegroundColor: Colors.white,
                        buttonUnselectedBackgroundColor: Colors.grey,
                        buttonSelectedBackgroundColor: Colors.blueGrey,
                      ),
                      SizedBox(height: 10,),
                    ],
                  ),
                ) :Container(),

                    getSearchCharacters()


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
    );
  }
}
