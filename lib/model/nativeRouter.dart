import 'package:json_annotation/json_annotation.dart';

part 'nativeRouter.g.dart';

@JsonSerializable()

class NativeRouter {

  NativeRouter({this.route, this.arguments});

  String route;
  Map<String,dynamic> arguments;

  //不同的类使用不同的mixin即可
  factory NativeRouter.fromJson(Map<String, dynamic> json) => _$NativeRouterFromJson(json);
  Map<String, dynamic> toJson() => _$NativeRouterToJson(this);
}
