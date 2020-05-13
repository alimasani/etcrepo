class Category {
  String categoryID;
  String category;
  String categoryImageURL;
  String displayOrder;
  String darkTheme;
  String lightTheme;

  Category(
      {this.categoryID,
      this.category,
      this.categoryImageURL,
      this.displayOrder,
      this.darkTheme,
      this.lightTheme});

  Category.fromJson(Map<String, dynamic> json) {
    categoryID = json['categoryID'];
    category = json['category'];
    categoryImageURL = json['categoryImageURL'];
    displayOrder = json['displayOrder'];
    darkTheme = json['darkTheme'];
    lightTheme = json['lightTheme'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryID'] = this.categoryID;
    data['category'] = this.category;
    data['categoryImageURL'] = this.categoryImageURL;
    data['displayOrder'] = this.displayOrder;
    data['darkTheme'] = this.darkTheme;
    data['lightTheme'] = this.lightTheme;
    return data;
  }
}