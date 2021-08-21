class SearchRequest {
  String keyword;

  String province;

  String district;

  String ward;

  String street;

  String estateType;

  String sort;

  String filterMaxPrice;

  String filterMinPrice;

  String filterArea;

  String filterNumberOfRoom;

  String filterPostTime;

  String deviceId;

  SearchRequest(
      {this.keyword = "",
      this.province = "",
      this.district = "",
      this.ward = "",
      this.street = "",
      this.estateType = "",
      this.sort = "",
      this.filterMaxPrice = "",
      this.filterMinPrice = "",
      this.filterArea = "",
      this.filterNumberOfRoom = "",
      this.filterPostTime = "",
      this.deviceId = ""});
}
