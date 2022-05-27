import 'package:flutter_test/flutter_test.dart';
import 'package:mockup_rick/controller/characters.dart';
import 'package:mockup_rick/helper/helper.dart';

void main(){
  test("title", (){
    // setup

    // run

    // verify
  });

  test("Get all characters", ()async{
    var result = await searchCharacter.getCharacter();
    expect(result, "");

  });
  test("Get all interesting characters", ()async{
    var result = await searchCharacter.getInterestingCharacter();
    expect(result, "");

  });
}