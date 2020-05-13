class Offer {
  Outlet outlet;
  OfferInfo offerInfo;
  Null vouchers;

  Offer({this.outlet, this.offerInfo, this.vouchers});

  Offer.fromJson(Map<String, dynamic> json) {
    outlet =
        json['outlet'] != null ? new Outlet.fromJson(json['outlet']) : null;
    offerInfo = json['offerInfo'] != null
        ? new OfferInfo.fromJson(json['offerInfo'])
        : null;
    vouchers = json['vouchers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.outlet != null) {
      data['outlet'] = this.outlet.toJson();
    }
    if (this.offerInfo != null) {
      data['offerInfo'] = this.offerInfo.toJson();
    }
    data['vouchers'] = this.vouchers;
    return data;
  }
}

class Outlet {
  String outletID;
  String outletName;
  String displayName;
  String displayInfo;
  Null whyWeLoveItTitle;
  Null whyWeLoveItMessage;
  Null whyWeLoveItAuthor;
  Locality locality;
  String defaultDisplayImage;
  Null displayImages;
  Null workingHours;
  Null communications;
  Null identifiers;

  Outlet(
      {this.outletID,
      this.outletName,
      this.displayName,
      this.displayInfo,
      this.whyWeLoveItTitle,
      this.whyWeLoveItMessage,
      this.whyWeLoveItAuthor,
      this.locality,
      this.defaultDisplayImage,
      this.displayImages,
      this.workingHours,
      this.communications,
      this.identifiers});

  Outlet.fromJson(Map<String, dynamic> json) {
    outletID = json['outletID'];
    outletName = json['outletName'];
    displayName = json['displayName'];
    displayInfo = json['displayInfo'];
    whyWeLoveItTitle = json['whyWeLoveItTitle'];
    whyWeLoveItMessage = json['whyWeLoveItMessage'];
    whyWeLoveItAuthor = json['whyWeLoveItAuthor'];
    locality = json['locality'] != null
        ? new Locality.fromJson(json['locality'])
        : null;
    defaultDisplayImage = json['defaultDisplayImage'];
    displayImages = json['displayImages'];
    workingHours = json['workingHours'];
    communications = json['communications'];
    identifiers = json['identifiers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['outletID'] = this.outletID;
    data['outletName'] = this.outletName;
    data['displayName'] = this.displayName;
    data['displayInfo'] = this.displayInfo;
    data['whyWeLoveItTitle'] = this.whyWeLoveItTitle;
    data['whyWeLoveItMessage'] = this.whyWeLoveItMessage;
    data['whyWeLoveItAuthor'] = this.whyWeLoveItAuthor;
    if (this.locality != null) {
      data['locality'] = this.locality.toJson();
    }
    data['defaultDisplayImage'] = this.defaultDisplayImage;
    data['displayImages'] = this.displayImages;
    data['workingHours'] = this.workingHours;
    data['communications'] = this.communications;
    data['identifiers'] = this.identifiers;
    return data;
  }
}

class Locality {
  Location location;
  String cluster;
  Null subCluster;
  City city;
  Null country;
  String distance;
  String distanceUOM;

  Locality(
      {this.location,
      this.cluster,
      this.subCluster,
      this.city,
      this.country,
      this.distance,
      this.distanceUOM});

  Locality.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    cluster = json['cluster'];
    subCluster = json['subCluster'];
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    country = json['country'];
    distance = json['distance'];
    distanceUOM = json['distanceUOM'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    data['cluster'] = this.cluster;
    data['subCluster'] = this.subCluster;
    if (this.city != null) {
      data['city'] = this.city.toJson();
    }
    data['country'] = this.country;
    data['distance'] = this.distance;
    data['distanceUOM'] = this.distanceUOM;
    return data;
  }
}

class Location {
  Null locationID;
  String locationName;
  GeoLocation geoLocation;

  Location({this.locationID, this.locationName, this.geoLocation});

  Location.fromJson(Map<String, dynamic> json) {
    locationID = json['locationID'];
    locationName = json['locationName'];
    geoLocation = json['geoLocation'] != null
        ? new GeoLocation.fromJson(json['geoLocation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['locationID'] = this.locationID;
    data['locationName'] = this.locationName;
    if (this.geoLocation != null) {
      data['geoLocation'] = this.geoLocation.toJson();
    }
    return data;
  }
}

class GeoLocation {
  String latitude;
  String longitude;

  GeoLocation({this.latitude, this.longitude});

  GeoLocation.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}

class City {
  Null cityID;
  String cityName;
  String cityCode;
  String cityImageURL;
  String displayOrder;

  City(
      {this.cityID,
      this.cityName,
      this.cityCode,
      this.cityImageURL,
      this.displayOrder});

  City.fromJson(Map<String, dynamic> json) {
    cityID = json['cityID'];
    cityName = json['cityName'];
    cityCode = json['cityCode'];
    cityImageURL = json['cityImageURL'];
    displayOrder = json['displayOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cityID'] = this.cityID;
    data['cityName'] = this.cityName;
    data['cityCode'] = this.cityCode;
    data['cityImageURL'] = this.cityImageURL;
    data['displayOrder'] = this.displayOrder;
    return data;
  }
}

class OfferInfo {
  String offerID;
  String validFrom;
  String validUntil;
  Null priceGuideURL;
  String isNewOffer;
  String maxAvgSavings;
  String isBookmarked;
  String isFeaturedOffer;
  String isUserEntitledOffer;
  String utilizationCount;
  Brand brand;
  Null primarycategory;
  Null otherCategories;
  List<String> subscriptionTypes;

  OfferInfo(
      {this.offerID,
      this.validFrom,
      this.validUntil,
      this.priceGuideURL,
      this.isNewOffer,
      this.maxAvgSavings,
      this.isBookmarked,
      this.isFeaturedOffer,
      this.isUserEntitledOffer,
      this.utilizationCount,
      this.brand,
      this.primarycategory,
      this.otherCategories,
      this.subscriptionTypes});

  OfferInfo.fromJson(Map<String, dynamic> json) {
    offerID = json['offerID'];
    validFrom = json['validFrom'];
    validUntil = json['validUntil'];
    priceGuideURL = json['priceGuideURL'];
    isNewOffer = json['isNewOffer'];
    maxAvgSavings = json['maxAvgSavings'];
    isBookmarked = json['isBookmarked'];
    isFeaturedOffer = json['isFeaturedOffer'];
    isUserEntitledOffer = json['isUserEntitledOffer'];
    utilizationCount = json['utilizationCount'];
    brand = json['brand'] != null ? new Brand.fromJson(json['brand']) : null;
    primarycategory = json['primarycategory'];
    otherCategories = json['otherCategories'];
    subscriptionTypes = json['subscriptionTypes'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['offerID'] = this.offerID;
    data['validFrom'] = this.validFrom;
    data['validUntil'] = this.validUntil;
    data['priceGuideURL'] = this.priceGuideURL;
    data['isNewOffer'] = this.isNewOffer;
    data['maxAvgSavings'] = this.maxAvgSavings;
    data['isBookmarked'] = this.isBookmarked;
    data['isFeaturedOffer'] = this.isFeaturedOffer;
    data['isUserEntitledOffer'] = this.isUserEntitledOffer;
    data['utilizationCount'] = this.utilizationCount;
    if (this.brand != null) {
      data['brand'] = this.brand.toJson();
    }
    data['primarycategory'] = this.primarycategory;
    data['otherCategories'] = this.otherCategories;
    data['subscriptionTypes'] = this.subscriptionTypes;
    return data;
  }
}

class Brand {
  Null brandID;
  String brandName;
  String brandLogoURL;
  Null brandDescription;
  String isPopularBrand;
  Null popularityOrder;

  Brand(
      {this.brandID,
      this.brandName,
      this.brandLogoURL,
      this.brandDescription,
      this.isPopularBrand,
      this.popularityOrder});

  Brand.fromJson(Map<String, dynamic> json) {
    brandID = json['brandID'];
    brandName = json['brandName'];
    brandLogoURL = json['brandLogoURL'];
    brandDescription = json['brandDescription'];
    isPopularBrand = json['isPopularBrand'];
    popularityOrder = json['popularityOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brandID'] = this.brandID;
    data['brandName'] = this.brandName;
    data['brandLogoURL'] = this.brandLogoURL;
    data['brandDescription'] = this.brandDescription;
    data['isPopularBrand'] = this.isPopularBrand;
    data['popularityOrder'] = this.popularityOrder;
    return data;
  }
}