class RestaurantFilter {
  int maxTime;
  int minRating;
  int maxPrice;
  bool onlyDelivery;
  bool onlyFavorite;
  bool useFilter;
  bool useTime;

  RestaurantFilter({
    required this.maxTime,
    required this.minRating,
    required this.maxPrice,
    required this.onlyDelivery,
    required this.onlyFavorite,
    required this.useFilter,
    required this.useTime,
  });
}
