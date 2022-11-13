class ImageModel {
  String? imagePath;
  String? imageName;

  ImageModel({
    this.imageName,
    this.imagePath,
  });

  ImageModel.fromJSON(Map<dynamic, String>json){
    imageName = json["ImageName"];
    imagePath = json["imagePath"];
  }

}
