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

  @override
  String toString() {
    return "{\"keyword\": $keyword, \"province\": $province, \"district\": $district,"
        " \"ward\": $ward, \"street\": $street, \"estateType\": $estateType, \"sort\": $sort,"
        "\"filterMaxPrice\": $filterMaxPrice,\"filterMinPrice\": $filterMinPrice,"
        "\"filterArea\": $filterArea,\"filterNumberOfRoom\": $filterNumberOfRoom,"
        "\"filterPostTime\": $filterPostTime ,\"deviceId\": $deviceId }";
  }
}
