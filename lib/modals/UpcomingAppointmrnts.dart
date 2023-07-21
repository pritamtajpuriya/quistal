class UpcomingAppointments {
  bool status;
  List<InnerData> data;

  UpcomingAppointments({this.status, this.data});

  UpcomingAppointments.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['appointment'] != null) {
      data = <InnerData>[];
      json['appointment'].forEach((v) {
        data.add(new InnerData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['appointment'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int currentPage;
  List<InnerData> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  String nextPageUrl;
  String path;
  int perPage;
  String prevPageUrl;
  int to;
  int total;

  Data(
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

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['appointment'] != null) {
      data = <InnerData>[];
      json['appointment'].forEach((v) {
        data.add(new InnerData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'].toString();
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'].toString();
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['appointment'] = this.data.map((v) => v.toJson()).toList();
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

class InnerData {
  int userId;
  int departmentId;
  int id;
  String name;
  String date;
  String time;
  String phoneNo;
  String status;
  String messages;
  String departmentName;
  int serviceId;
  String doctorName;
  String image;
  String serviceName;
  Patient patient;
  Doctors doctors;

  InnerData(
      {this.userId,
      this.departmentId,
      this.id,
      this.name,
      this.date,
      this.time,
      this.phoneNo,
      this.status,
      this.doctorName,
      this.messages,
      this.serviceId,
      this.departmentName,
      this.image,
      this.serviceName,
      this.patient,
      this.doctors});

  InnerData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    departmentId = json['department_id'];
    id = json['id'];
    doctorName = json['doctor_name'];
    name = json['name'];
    date = json['date'];
    time = json['time'].toString();
    phoneNo = json['phone_no'];
    status = json['status'];
    messages = json['messages'];
    serviceId = json['service_id'];
    departmentName = json['department_name'];
    image = json['image'];
    serviceName = json['service_name'];
    patient = Patient.fromJson(json['patient']);
    doctors = Doctors.fromJson(json['doctors']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['department_id'] = this.departmentId;
    data['id'] = this.id;
    data['name'] = this.name;
    data['date'] = this.date;
    data['time'] = this.time;
    data['phone_no'] = this.phoneNo;
    data['status'] = this.status;
    data['messages'] = this.messages;
    data['service_id'] = this.serviceId;
    data['department_name'] = this.departmentName;
    data['image'] = this.image;
    data['service_name'] = this.serviceName;
    return data;
  }
}

class Patient {
  int id;
  int userId;
  String firstName;
  String lastName;
  int age;
  String dob;
  String gender;
  String location;
  String relation;
  String phone;
  String email;
  String address;
  String createdAt;
  String updatedAt;

  Patient(
      {this.id,
      this.userId,
      this.firstName,
      this.lastName,
      this.age,
      this.dob,
      this.gender,
      this.location,
      this.relation,
      this.phone,
      this.email,
      this.address,
      this.createdAt,
      this.updatedAt});

  Patient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    age = json['age'];
    dob = json['dob'];
    gender = json['gender'];
    location = json['location'];
    relation = json['relation'];
    phone = json['phone'];
    email = json['email'];
    address = json['address'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['age'] = this.age;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['location'] = this.location;
    data['relation'] = this.relation;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['address'] = this.address;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Doctors {
  int id;
  int userId;
  int departmentId;
  String name;
  String email;
  String password;
  String phoneNo;
  String nmc;
  int appointmentFee;
  String experience;
  String aboutUs;
  String service;
  String image;
  String status;
  String createdAt;
  String updatedAt;

  Doctors(
      {this.id,
      this.userId,
      this.departmentId,
      this.name,
      this.email,
      this.password,
      this.phoneNo,
      this.nmc,
      this.appointmentFee,
      this.experience,
      this.aboutUs,
      this.service,
      this.image,
      this.status,
      this.createdAt,
      this.updatedAt});

  Doctors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    departmentId = json['department_id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phoneNo = json['phone_no'];
    nmc = json['nmc'];
    appointmentFee = json['appointment_fee'];
    experience = json['experience'];
    aboutUs = json['about_us'];
    service = json['service'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['department_id'] = this.departmentId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phone_no'] = this.phoneNo;
    data['nmc'] = this.nmc;
    data['appointment_fee'] = this.appointmentFee;
    data['experience'] = this.experience;
    data['about_us'] = this.aboutUs;
    data['service'] = this.service;
    data['image'] = this.image;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
