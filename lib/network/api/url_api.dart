class BASEURL {
  static String ipAddress = "";
  static String apiRegister = "http://$ipAddress/medicine_db/register_api.php";
  static String apiLogin = "http://$ipAddress/medicine_db/login_api.php";
  static String categoryWithProduct =
      "http://$ipAddress/medicine_db/get_product_with_category.php";
  static String getProduct = "http://$ipAddress/medicine_db/get_product.php";
  static String addToCart = "http://$ipAddress/medicine_db/add_to_cart.php";
  static String getProductCart =
      "http://$ipAddress/medicine_db/get_cart.php?userID=";
  static String updateQuantityProductCart =
      "http://$ipAddress/medicine_db/update_quantity.php";
  static String totalPriceCart =
      "http://$ipAddress/medicine_db/get_total_price.php?userID=";
  static String getTotalCart =
      "http://$ipAddress/medicine_db/total_cart.php?userID=";
  static String checkout = "http://$ipAddress/medicine_db/checkout.php";
  static String historyOrder =
      "http://$ipAddress/medicine_db/get_history.php?id_user=";
}
