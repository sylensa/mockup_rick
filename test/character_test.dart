import 'package:flutter_test/flutter_test.dart';
import 'package:mockup_rick/controller/characters.dart';
import 'package:mockup_rick/helper/helper.dart';

void main(){

  test("Get all characters", ()async{
    var result = await searchCharacter.getCharacter();
    expect(result, "");

  });
  test("Get all interesting characters", ()async{
    var result = await searchCharacter.getInterestingCharacter();
    expect(result, "");

  });

  test("Get all characters base on name search", ()async{
    var result = await searchCharacter.searchCharacter(search: "Rick");
    expect(result, "");
  });

  test("Get all characters base on filter", ()async{
    var result = await searchCharacter.filterSearchCharacter(search: "Rick",genderValue: "male",statusValue: "alive");
    expect(result, "");
  });

  test("Get episodes", ()async{
    await searchCharacter.getCharacter();
    var result = await searchCharacter.getEpisodes(listCharacters[0].results[0]);
    expect(result, "");
  });

  test("Pagination", ()async{
    var result = await searchCharacter.paginationCharacter(pageNumber: "2");
    expect(result, "");
  });
}