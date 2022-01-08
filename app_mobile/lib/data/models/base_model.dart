class BaseModel {
  Map<String, dynamic> data;

  BaseModel({
    this.data,
  });

  static dynamic defaultJson(Map<String, dynamic> jsonMap){
    return BaseModel(data: jsonMap['data']??'',);
  }

  static dynamic fromJson(Map<String, dynamic> jsonMap) {
    if(jsonMap['data'] != null){
      return BaseModel(
        data: jsonMap['data']
      );
    }
    return null;
  }
}
