import 'dart:math';

import 'package:mockup_rick/helper/helper.dart';
import 'package:mockup_rick/model/general_class.dart';
import 'package:mockup_rick/model/getEpisodes.dart';
import 'package:mockup_rick/model/get_character.dart';
import 'package:mockup_rick/model/get_multiple_characters.dart';
List<GetCharacters> listCharacters = [];
List<GetEpisodes> listGetEpisodes = [];
List<GetMultipleCharacters> listCharactersInterest = [];
int selectedPageNumber = 0;
class CharacterPage{

   searchCharacter({String search = ''} )async{
    try{
      listCharacters.clear();
      var js = await doGet('api/character/?name=$search');
      print("res search: $js");
      if(js["results"].isNotEmpty){
        GetCharacters dataData = GetCharacters.fromJson(js);
        listCharacters.add(dataData);
        return "";
      }
      return "The results is empty";
    }catch(e){
      print("error subscriptions: $e");
      return  e.toString();

    }

}

   getCharacter()async{
     try{
       listCharacters.clear();
       var js = await doGet('api/character');
       print("res character: $js");
       if(js["results"].isNotEmpty){
         GetCharacters dataData = GetCharacters.fromJson(js);
         listCharacters.add(dataData);
         return "";
       }
       return "The results is empty";
     }catch(e){
       print("error subscriptions: $e");
       return "$e";
     }

   }

   paginationCharacter({String pageNumber = '',String genderValue = '',String statusValue = '',String search = ''})async{
     try{
     listCharacters.clear();
     var js = await doGet('api/character/?page=${int.parse(pageNumber) + 1}&name=$search&status=$statusValue&gender=$genderValue');
     print("res search: $js");
     if(js.containsKey("error")){
       selectedPageNumber--;
      await  paginationCharacter(pageNumber: "1",genderValue: genderValue,statusValue: statusValue,search: search);
     }else{
       if(js["results"].isNotEmpty){
         GetCharacters dataData = GetCharacters.fromJson(js);
         listCharacters.add(dataData);
         return "";
       }
     }

     return "The results is empty";
     }catch(e){
       print("error subscriptions: $e");
       return "$e";
     }

   }
   onLoadingPaginationCharacter({String pageNumber = '',String genderValue = '',String statusValue = '',String search = ''})async{
     try{
       var js = await doGet('api/character/?page=$pageNumber&name=$search&status=$statusValue&gender=$genderValue');
     print("res search: $js");
     if(js["results"].isNotEmpty){
       GetCharacters dataData = GetCharacters.fromJson(js);
       for(int i = 0; i < dataData.results.length; i++){
         listCharacters[0].results.add(dataData.results[i]);
       }
       return "";
     }
     return "The results is empty";
     }catch(e){
       print("error subscriptions: $e");
       return "$e";
     }

   }

   filterSearchCharacter({String genderValue = '',String statusValue = '',String search = ''} )async{
     try{
       listCharacters.clear();
       var js = await doGet('api/character/?name=$search&status=$statusValue&gender=$genderValue');
       print("res search: $js");
       if(js["results"].isNotEmpty){
         GetCharacters dataData = GetCharacters.fromJson(js);
         listCharacters.add(dataData);
         return "";
       }
       return "The results is empty";
     }catch(e){
       print("error subscriptions: $e");
       return "$e";
     }

   }

   getInterestingCharacter()async{
     try{
       listCharactersInterest.clear();
     var rng = Random();
     List randomNumbers = [];
     for (var i = 0; i < 3; i++) {
       print(rng.nextInt(100));
       randomNumbers.add((rng.nextInt(100)));
     }
     print("randomNumbers: ${randomNumbers.join(",")}");
     var js = await doGet('api/character/${randomNumbers.join(",")}');
     print("res character: ${js.length}");
     if(js.isNotEmpty){
       for(int i = 0; i < js.length; i++){
         GetMultipleCharacters dataData = GetMultipleCharacters.fromJson(js[i]);
         listCharactersInterest.add(dataData);
       }
       return "";
     }
     return "Empty Results";

     }catch(e){
       print("error subscriptions: $e");

       return "$e";
     }

   }

   getEpisodes( Result? getCharacter)async{
     try{
    List episodes = [];
    listGetEpisodes.clear();
     print("no of ${getCharacter!.episode.length}");
     for(int i = 0; i < getCharacter.episode.length; i++){
       var res = getCharacter.episode[i].toString().split("/").last;
       episodes.add(res);
     }
     print("${episodes.join(',')}");
     var js = await doGet('api/episode/${episodes.join(',')},');
     print("res search: $js");
     if(js.isNotEmpty){
       for(int i = 0; i < js.length; i++){
         GetEpisodes dataData = GetEpisodes.fromJson(js[i]);
         listGetEpisodes.add(dataData);
       }
       return "";
     }
    return "Empty Results";
     }catch(e){
       print("error subscriptions: $e");
       return "$e";
     }

   }

   IsChecked(int index){
     if(selectedFilterName.isNotEmpty){
       if(selectedFilterName.contains(listFilterName[index])){
         selectedFilterName.remove(listFilterName[index]);
       }else{
         for(int i= 0; i < selectedFilterName.length; i++){
           if(selectedFilterName[i].id == listFilterName[index].id){
             selectedFilterName.remove(selectedFilterName[i]);
             selectedFilterName.add( listFilterName[index]);
             return;
           }
         }
         selectedFilterName.add( listFilterName[index]);
       }
     }
     else{
       selectedFilterName.add( listFilterName[index]);
     }
   }

}