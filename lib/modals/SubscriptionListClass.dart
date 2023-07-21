class SubscriptionListClass {
  bool status;
  OuterData data;

  SubscriptionListClass({this.status, this.data});

  SubscriptionListClass.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new OuterData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class OuterData {
  int currentPage;
  List<Data> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  Null nextPageUrl;
  String path;
  int perPage;
  Null prevPageUrl;
  int to;
  int total;

  OuterData(
      {this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  OuterData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class Data {
  int id;
  int userId;
  int packageId;
  String transactionId;
  String name;
  int paymentType;
  String createdAt;
  String updatedAt;
  String amount;
  String date;
  String time;
  int status;
  Packagedata packagedata;

  Data(
      {this.id,
        this.userId,
        this.packageId,
        this.transactionId,
        this.name,
        this.paymentType,
        this.createdAt,
        this.updatedAt,
        this.amount,
        this.date,
        this.time,
        this.status,
        this.packagedata});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    packageId = json['package_id'];
    transactionId = json['transaction_id'];
    name = json['name'];
    paymentType = json['payment_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    amount = json['amount'];
    date = json['date'];
    time = json['time'];
    status = json['status'];
    packagedata = json['packagedata'] != null
        ? new Packagedata.fromJson(json['packagedata'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['package_id'] = this.packageId;
    data['transaction_id'] = this.transactionId;
    data['name'] = this.name;
    data['payment_type'] = this.paymentType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['amount'] = this.amount;
    data['date'] = this.date;
    data['time'] = this.time;
    data['status'] = this.status;
    if (this.packagedata != null) {
      data['packagedata'] = this.packagedata.toJson();
    }
    return data;
  }
}

class Packagedata {
  int id;
  String name;
  String price;
  int departmentId;
  String description;
  String createdAt;
  String updatedAt;

  Packagedata(
      {this.id,
        this.name,
        this.price,
        this.departmentId,
        this.description,
        this.createdAt,
        this.updatedAt
      });

  Packagedata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    departmentId = json['department_id'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['department_id'] = this.departmentId;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
