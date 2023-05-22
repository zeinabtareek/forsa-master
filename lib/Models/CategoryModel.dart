class CategoryModel {
  dynamic id;
  dynamic image;
  dynamic name;

  CategoryModel({this.id, this.image, this.name});
}

List<CategoryModel> categories = [
  CategoryModel(
    id: 1,
    image: 'images/car.png',
    name: 'Cars',
  ),
  CategoryModel(
    id: 2,
    image: 'images/mobbile.png',
    name: 'Electronics',
  ),
  CategoryModel(
    id: 2,
    image: 'images/bed.png',
    name: 'furniture',
  ),
];
