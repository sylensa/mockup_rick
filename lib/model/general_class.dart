import 'package:mockup_rick/helper/helper.dart';
import 'package:mockup_rick/model/get_character.dart';

class ListNames{
  String name;
  String id;
  ListNames({this.name = '',this.id = ''});
}

List <ListNames> listFilterName = [ListNames(name: "Alive",id: "status"),ListNames(name: "Dead",id: "status"),ListNames(name: "Unknown",id: "status"),ListNames(name: "Female",id: "gender"),ListNames(name: "Male",id: "gender"),ListNames(name: "Genderless",id: "gender")];
List <ListNames> selectedFilterName = [];
