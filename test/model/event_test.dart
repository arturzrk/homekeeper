import 'package:test/test.dart';
import 'package:homekeeper/model/event.dart';

const String MAP_TITLE = 'main title';
const String MAP_CATEGORY = 'map_category';
const bool MAP_IS_REOCCURENCE = true;
DateTime mapOccurenceDate =  DateTime.utc(1970);
const int MAP_REOCCURENCEDAYSCOUNT = 50;

void main() {
  test('Given_Map_When_fromMap_CorrectEventCreated', () {
    //given
    Map<String, dynamic> map = new Map();
    map['title'] = MAP_TITLE;
    map['category'] = MAP_CATEGORY;
    map['isReoccurence'] = MAP_IS_REOCCURENCE;
    map['occurenceDate'] = mapOccurenceDate;
    map['reoccurenceDaysCount'] = MAP_REOCCURENCEDAYSCOUNT;

    //When
    var event = Event.fromMap(map);

    //Then
    expect(event.title, equals(MAP_TITLE));
    expect(event.category, equals(MAP_CATEGORY));
    expect(event.isReoccurence, equals(MAP_IS_REOCCURENCE));
    expect(event.occurenceDate, equals(mapOccurenceDate));
    expect(event.reoccurenceDaysCount, equals(MAP_REOCCURENCEDAYSCOUNT));
  });

  test('Given_Event_When_toMap_CorrectMapIsReturned' , () {
    //given
    var event = Event(
      title: MAP_TITLE,
      category: MAP_CATEGORY,
      isReoccurence: MAP_IS_REOCCURENCE,
      occurenceDate: mapOccurenceDate,
      reoccurenceDaysCount: MAP_REOCCURENCEDAYSCOUNT
    );

    //when
    var map = event.toMap();
    expect([map['title'],map['category'],map['isReoccurence'],map['occurenceDate'],map['reoccurenceDaysCount']], 
      equals([MAP_TITLE,MAP_CATEGORY,MAP_IS_REOCCURENCE,mapOccurenceDate,MAP_REOCCURENCEDAYSCOUNT]));
  });
}