class SignupResponseModel {
  final String message;


  SignupResponseModel({
    required this.message,

  });

  // Factory method to create an instance from JSON
  factory SignupResponseModel.fromJson(Map<String, dynamic> json) {
    return SignupResponseModel(
      message: json['message'],

    );
  }
}


