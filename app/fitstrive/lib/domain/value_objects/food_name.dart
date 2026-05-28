final class FoodName {
  factory FoodName({required final String foodName}) {
    return FoodName._internal(foodName);
  }

  FoodName._internal(this.foodname);

  final String foodname;
}
