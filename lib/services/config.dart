class Config {
  static const apiUrl = "sever-production-2b27.up.railway.app";
  static const paymentBaseUrl = "paymentsever-production.up.railway.app";
  static const String loginUrl = "/api/login";
  static const String paymentUrl = "/stripe/create-checkout-session";
  static const String signupUrl = "/api/register";
  static const String getCartUrl = "/api/cart/find";
  static const String addCartUrl = "/api/cart";
  static const String updateUserUrl = "/api/users/";
  static const String foods = "/api/products";
  static const String orders = "/api/orders";
  static const getFavoritesUrl = "/api/favorites";
  static const addFavoriteUrl = "/api/favorites";
  static const removeFavoriteUrl = "/api/favorites";
  static const String search = "/api/products/search/";
  static const String profile = "/api/users/profile";
  static const String updateprofile = "/api/users/:id";
}
