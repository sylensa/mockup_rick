import 'package:flutter/material.dart';
import 'package:mockup_rick/helper/helper.dart';
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
  getCharacter()async{
    try{
      var js = await doGet('api/character');
      print("res character: $js");
      if(js["results"].isNotEmpty){
          GetCharacters dataData = GetCharacters.fromJson(js);
            listCharacters.add(dataData);
            numberPages = dataData.info.pages;


      }
      if(mounted){
        setState(() {
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
  searchCharacter({String search = ''} )async{
    // try{
      var js = await doGet('api/character/?name=$search');
      print("res search: $js");
      if(js["results"].isNotEmpty){
          GetCharacters dataData = GetCharacters.fromJson(js);
          listSearchCharacters.add(dataData);
          numberPages = dataData.info.pages;
      }
      if(mounted){
        setState(() {
          progressCode = false;
          selectedPageNumber = 0;
        });
      }

    // }catch(e){
    //   if(mounted){
    //     setState(() {
    //       progressCode = false;
    //     });
    //   }
    //   print("error subscriptions: $e");
    // }

  }
  paginationCharacter({String pageNumber = ''} )async{
    // try{
    listCharacters.clear();
      var js = await doGet('api/character/?page=$pageNumber');
      print("res search: $js");
      if(js["results"].isNotEmpty){
          GetCharacters dataData = GetCharacters.fromJson(js);
          if(searchController.text.isNotEmpty){
            listSearchCharacters.add(dataData);
          }else{
            listCharacters.add(dataData);
          }

          numberPages = dataData.info.pages;
      }
      if(mounted){
        setState(() {
          progressCode = false;
        });
      }

    // }catch(e){
    //   if(mounted){
    //     setState(() {
    //       progressCode = false;
    //     });
    //   }
    //   print("error subscriptions: $e");
    // }

  }
  filterCharacter({String filter = '',String value = ''} )async{
    // try{
      var js = await doGet('api/character/?$filter=$value');
      print("res search: $js");
      if(js["results"].isNotEmpty){
          GetCharacters dataData = GetCharacters.fromJson(js);
          listCharacters.add(dataData);
          numberPages = dataData.info.pages;
      }
      if(mounted){
        setState(() {
          progressCode = false;
          selectedPageNumber = 0;
        });
      }

    // }catch(e){
    //   if(mounted){
    //     setState(() {
    //       progressCode = false;
    //     });
    //   }
    //   print("error subscriptions: $e");
    // }

  }

  getAllCharacters(){
     if(listCharacters.isNotEmpty){
       return ListView(
         controller: _scrollController,
         scrollDirection: Axis.vertical,
         shrinkWrap: true,
         padding: bottomPadding(70),
         children: listCharacters[0].results.map<Widget> ( (getCharacters) {
           return      Container(
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
                 Container(
                   width: 180,
                   padding: EdgeInsets.only(top: 7,right: 5,left: 5),
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
                 )
               ],
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

  getSearchCharacters(){
     if(listSearchCharacters.isNotEmpty){
       return ListView(
         controller: _scrollController,
         scrollDirection: Axis.vertical,
         shrinkWrap: true,
         padding: bottomPadding(70),
         children: listSearchCharacters[0].results.map<Widget> ( (getCharacters) {
           return      Container(
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
                 Container(
                   width: 180,
                   padding: EdgeInsets.only(top: 7,right: 5,left: 5),
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
                 )
               ],
             ),
           );
         }).toList(),

       );
     }else if(listSearchCharacters.isEmpty && progressCode){
       return Container(height: appHeight(context)/2,child: Center(child: progress(),));
     }else{
       return Container(height: appHeight(context)/2,child: Center(child: sText("No Character was found"),));
     }


  }



filterPopUpMenu(){
  return  PopupMenuButton(onSelected: (result) {

  },
    // color:  Color(0xFF253341),

    icon: Image.asset("assets/images/bars.png"),

    // add this line
    itemBuilder: (_) => <PopupMenuItem<String>>[
      PopupMenuItem<String>(
        child: Container(
            width: 100,
            // height: 30,
            child: Row(
              children: [
                sText("All",),
                filter == 'All' ? Icon(Icons.check,color: Colors.green,) : Container()
              ],
            )
        )
        , value: 'all',
        onTap: ()async{
         setState(() {
           listCharacters.clear();
           progressCode = true;
           filter = 'All';
           print("selectedPageNumber:$selectedPageNumber");
         });
         await  getCharacter();
        },

      ),
      PopupMenuItem<String>(
        child: Container(
            width: 100,
            // height: 30,
            child: Row(
              children: [
                sText("Alive",),
                filter == 'Alive' ? Icon(Icons.check,color: Colors.green,) : Container()

              ],
            )
        )
        , value: 'alive',
        onTap: ()async{
         setState(() {
           listCharacters.clear();
           progressCode = true;
           filter = 'Alive';
         });
         await filterCharacter(filter: 'status',value: 'alive');
        },

      ),
      PopupMenuItem<String>(
        child: Container(
            width: 100,
            // height: 30,
            child: Row(
              children: [
                sText("Dead",),
                filter == 'Dead' ? Icon(Icons.check,color: Colors.green,) : Container()

              ],
            )
        )
        , value: 'dead',
        onTap: ()async{
         setState(() {
           listCharacters.clear();
           progressCode = true;
           filter = 'Dead';
         });
         await filterCharacter(filter: 'status',value: 'dead');
        },

      ),
      PopupMenuItem<String>(
        child: Container(
            width: 100,
            // height: 30,
            padding: appPadding(5),
            child: Row(
              children: [
                sText("Unknown",),
                filter == 'unknown_s' ? Icon(Icons.check,color: Colors.green,) : Container()
              ],
            )
        )
        , value: 'unknown_s',
        onTap: ()async{
         setState(() {
           listCharacters.clear();
           progressCode = true;
           filter = 'unknown_s';
         });
         await filterCharacter(filter: 'status',value: 'unknown');
        },

      ),
        PopupMenuItem<String>(

          child: Container(
              width: 100,
              // height: 30,
              child: Row(
                children: [
                  sText("Female",),
                  filter == 'Female' ? Icon(Icons.check,color: Colors.green,) : Container()

                ],
              )
          )
          , value: 'female',
          onTap: ()async{
            setState(() {
              listCharacters.clear();
              progressCode = true;
              filter = 'Female';
            });
            await filterCharacter(filter: 'gender',value: 'female');
          },

        ),
        PopupMenuItem<String>(

          child: Container(
              width: 100,
              // height: 30,
              child: Row(
                children: [
                  sText("Male",),
                  filter == 'Male' ? Icon(Icons.check,color: Colors.green,) : Container()

                ],
              )
          )
          , value: 'male',
          onTap: ()async{
            setState(() {
              listCharacters.clear();
              progressCode = true;
              filter = 'Male';
            });
            await filterCharacter(filter: 'gender',value: 'male');
          },

        ),
        PopupMenuItem<String>(

          child: Container(
              width: 120,
              // height: 30,
              child: Row(
                children: [
                  sText("Genderless",),
                  filter == 'Genderless' ? Icon(Icons.check,color: Colors.green,) : Container()

                ],
              )
          )
          , value: 'genderless',
          onTap: ()async{
            setState(() {
              listCharacters.clear();
              progressCode = true;
              filter = 'Genderless';
            });
            await filterCharacter(filter: 'gender',value: 'genderless');
          },

        ),
        PopupMenuItem<String>(

          child: Container(
              width: 100,
              // height: 30,
              child: Row(
                children: [
                  sText("Unknown",),
                  filter == 'unknown_g' ? Icon(Icons.check,color: Colors.green,) : Container()

                ],
              )
          )
          , value: 'unknown_g',
          onTap: ()async{
            setState(() {
              listCharacters.clear();
              progressCode = true;
              filter = 'unknown_g';
            });
            await filterCharacter(filter: 'gender',value: 'unknown');
          },

        ),


    ],
  );
}
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCharacter();
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
                            SizedBox(width: 20,),
                            Expanded(
                              child: TextFormField(
                                textInputAction: TextInputAction.search,
                                controller: searchController,
                                onFieldSubmitted: (String value){
                                  filter = '';
                                  setState(() {
                                    progressCode = true;
                                    listSearchCharacters.clear();
                                  });
                                  if(value.isNotEmpty){
                                    searchCharacter(search: value);
                                  }else{
                                    setState(() {
                                      searchController.clear();
                                      progressCode = true;
                                    });
                                    getCharacter();
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
                            Container(
                              child: filterPopUpMenu(),
                            ),
                            SizedBox(width: 20,),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                listCharacters.isNotEmpty || listSearchCharacters.isNotEmpty ?
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      NumberPaginator(
                        numberPages: numberPages,
                        onPageChange: (int index) {
                          setState(() {
                            listCharacters.clear();
                            listSearchCharacters.clear();
                            selectedPageNumber = index;
                            progressCode = true;
                          });

                          paginationCharacter(pageNumber:"${ selectedPageNumber + 1}");
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


                searchController.text.isNotEmpty ?
                    getSearchCharacters() :
                    getAllCharacters()

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
