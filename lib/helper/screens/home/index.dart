import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mockup_rick/controller/characters.dart';
import 'package:mockup_rick/helper/helper.dart';
import 'package:mockup_rick/helper/screens/character/index.dart';
import 'package:mockup_rick/model/general_class.dart';
import 'package:mockup_rick/model/get_character.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
bool progressCode = true;
String filter = '';
String g_val = '';
String s_val = '';
// final ScrollController _scrollController =  ScrollController();
TextEditingController searchController = TextEditingController();

int numberPages = 1;
String errorMessage = '';

RefreshController _refreshController =  RefreshController(initialRefresh: false);
void _onLoading() async{
  setState(() {
    // selectedPageNumber++;
  });
  await setPref("selectedPageNumber", selectedPageNumber,type: 'int');
  await searchCharacter.onLoadingPaginationCharacter(pageNumber: "$selectedPageNumber",genderValue: g_val,statusValue: s_val,search: searchController.text);
  if(mounted){
    setState(() {

    });
  }
  _refreshController.loadComplete();
}

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
        await setPref("selectedPageNumber", selectedPageNumber,type: 'int');
        await setPref("search", '',type: 'string');
        await setPref("g_val", g_val,type: 'string');
        await setPref("s_val", s_val,type: 'string');

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
        await setPref("selectedPageNumber", selectedPageNumber,type: 'int');
        await setPref("search", search,type: 'string');
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
      errorMessage =  await  searchCharacter.paginationCharacter(pageNumber: pageNumber,genderValue: g_val,statusValue: s_val,search: searchController.text);
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
        await setPref("selectedPageNumber", selectedPageNumber,type: 'int');
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

  getCharactersWidget(){
    if(listCharacters.isNotEmpty){
      return ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        padding: bottomPadding(70),
        children: listCharacters[0].results.map<Widget> ( (getCharacters) {
          return      GestureDetector(
            onTap: (){
              goTo(context, CharacterScreen(getCharacter: getCharacters,));
            },
            child: Container(
              margin: EdgeInsets.only(left: 20,right: 20,bottom: 20),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10)
              ),
              // width: appWidth(context),
              child:  Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),topLeft:  Radius.circular(10)),
                          child: displayImage("${getCharacters.image}",radius: 0,height: 150),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: Container(
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
                  SizedBox(width: 10,),
                  Container(
                    height: 150,
                    // padding: EdgeInsets.only(left: 160),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                              width: 155,
                              child: sText("${getCharacters.status} - ${getCharacters.species}",maxLines: 1,align: TextAlign.start),
                            )
                          ],
                        ),
                        Container(
                          width: 170,
                          child: sText("${getCharacters.name}",weight: FontWeight.bold,maxLines: 1,align: TextAlign.start),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          width: 170,
                          child: sText("Last known location",align: TextAlign.start),
                        ),
                        Container(
                          width: 170,
                          child: sText("${getCharacters.location.name}",weight: FontWeight.bold,maxLines: 1,align: TextAlign.start),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          width: 170,
                          child: sText("First seen in:",align: TextAlign.start),
                        ),
                        Container(
                          width: 170,
                          child: sText("${getCharacters.origin.name}",weight: FontWeight.bold,maxLines: 1,align: TextAlign.start),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          );
        }).toList(),

      )  ;
    }else if(listCharacters.isEmpty && progressCode){
      return Container(height: appHeight(context)/2,child: Center(child: progress(),));
    }else{
      return Container(height: appHeight(context)/2,child: Center(child: sText("No Character was found"),));
    }


  }

void _settingModalBottomSheet(context, List <ListNames> filterData){
  //
  // if(filterData.contains(listFilterName[0].name)){
  //   print("filterData::${filterData[0].name}");
  //   print("listFilterName::${listFilterName[0].name}");
  // }else{
  //   print("hmm::${filterData[0].name}");
  //   print("hmm1::${listFilterName[0].name}");
  // }
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
                                              value: filterData.contains(listFilterName[index]) ? true : false,
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
                        setState(() {
                          reset();
                        });
                        Navigator.pop(context);
                        if(selectedFilterName.isNotEmpty){
                          for(int i = 0; i < selectedFilterName.length; i++){
                            if(selectedFilterName[i].id == "status"){
                              s_val = selectedFilterName[i].name.toLowerCase();
                            }else{
                              g_val =  selectedFilterName[i].name.toLowerCase();
                            }
                          }
                          await setPref("g_val", g_val,type: 'string');
                          await setPref("s_val", s_val,type: 'string');
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

initialCall()async{
  var p_number = await getPref("selectedPageNumber",type: 'int');
  var gender_val = await getPref("g_val",type: 'string');
  var status_val = await getPref("s_val",type: 'string');
  var search_val = await getPref("search",type: 'string');
  p_number != null ? selectedPageNumber = p_number : selectedPageNumber = 0;
  gender_val != null ? g_val = gender_val : g_val = '';
  status_val != null ? s_val = status_val : s_val = '';
  search_val != null ? search_val = search_val : search_val = '';
  print("s_val:${properCase(s_val)}");
  print("g_val:${properCase(g_val)}");
  print("p_number:$p_number");
  print("selectedPageNumber:$selectedPageNumber");
  ListNames newStatusListNames = ListNames(name: "${s_val.isNotEmpty ? properCase(s_val.trim()) : s_val}",id: "status");
  ListNames newGenderListNames = ListNames(name: "${g_val.isNotEmpty ? properCase(g_val.trim()) : g_val}",id: "gender");
  selectedFilterName.add(newStatusListNames);
  selectedFilterName.add(newGenderListNames);
  for(int i =0; i < selectedFilterName.length; i++){
    for(int t =0; t < listFilterName.length; t++){
      if(selectedFilterName[i].name == listFilterName[t].name){
        selectedFilterName.removeAt(i);
        selectedFilterName.add(listFilterName[t]);
      }
    }

  }
  searchController.text = search_val;
  setState(() {
  print("newStatusListNames:${newStatusListNames.id}");
  print("newGenderListNames:${newGenderListNames.id}");
  });
  if(selectedPageNumber == 0 && selectedFilterName.isEmpty){
    await getAllCharacter();
  }else{
    await getPaginationCharacter(pageNumber: "${selectedPageNumber}");
  }
}

reset(){
  listCharacters.clear();
  progressCode = true;
}
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialCall();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child:SmartRefresher(
      reverse: false,
          physics: ClampingScrollPhysics(),
          enablePullDown: false,
          enablePullUp: true,
          footer: CustomFooter(
            builder: (BuildContext context,LoadStatus? mode){
              Widget body ;
              if(mode==LoadStatus.idle){
                body =  Text("No more Data");
              }
              else if(mode==LoadStatus.loading){
                body =  CupertinoActivityIndicator();
              }
              else if(mode == LoadStatus.failed){
                body = Text("Load Failed!Click retry!");
              }
              else if(mode == LoadStatus.canLoading){
                body = Text("release to load more");
              }
              else{
                body = Text("No more Data");
              }
              return Container(
                height: 55.0,
                child: Center(child:body),
              );
            },
          ),
          controller: _refreshController,
          onLoading: _onLoading,
          child :ListView(
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
                                    selectedFilterName.clear();
                                    progressCode = true;
                                    searchController.clear();
                                    s_val = '';
                                    g_val = '';
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
                              _settingModalBottomSheet(context,selectedFilterName);
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
                      onPageChange: (int index) async{
                        setState(() {
                          print("index:$index");
                          listCharacters.clear();
                          selectedPageNumber = index;
                          progressCode = true;
                        });
                        await setPref("selectedPageNumber", selectedPageNumber,type: 'int');
                        // selectedPageNumber++;

                        getPaginationCharacter(pageNumber:"${ selectedPageNumber}");
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
              getCharactersWidget()
            ],
          ),
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
