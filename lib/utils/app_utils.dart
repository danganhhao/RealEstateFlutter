class AppUtils {
  AppUtils._();

  static final AppUtils instance = AppUtils._();

  String getCategoryImageById(int id) {
    switch (id) {
      case 1: return "assets/images/house.png";
      case 2: return "assets/images/department.png";
      case 3: return "assets/images/villa.png";
      case 4: return "assets/images/house.png";
      case 5: return "assets/images/town.png";
      case 6: return "assets/images/resort.png";
      case 7: return "assets/images/kho.png";
      case 8: return "assets/images/other.png";
    }
    return "assets/images/image_placeholder.jpg";
  }
}
