

import 'package:json_annotation/json_annotation.dart';

//part 'page.g.dart';

@JsonSerializable()
class Page<T>{

  Page(this.empty, this.first, this.last, this.number,
      this.numberOfElements, this.size, this.totalElements, this.totalPages);

   bool empty;
   bool first;
   bool last;
   int number;
   int numberOfElements;
   //@JsonKey(fromJson: _dataFromJson, toJson: _dataToJson)
   //List<T> content;
   int size;
   int totalElements;
   int totalPages;

  //factory Page.fromJson(Map<String, dynamic> json) => _$PageFromJson<T>(json);

}