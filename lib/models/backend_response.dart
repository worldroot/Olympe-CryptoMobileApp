class BackendResponse {
  String? message;
  bool? error;

  BackendResponse({message});

  BackendResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    return data;
  }

  BackendResponse.withError() {
    message = "";
    error = true;
  }
}
