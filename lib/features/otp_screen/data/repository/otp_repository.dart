import '../data_provider/otp_api_provider.dart';

class OtpRepository{
  final OtpApiProvider _apiProvider;

  OtpRepository(this._apiProvider);

  Future<String> sendOTP(String email)async{
    return await _apiProvider.sendOTP(email);
  }
}