
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class ILoginRepository {
  Future<dynamic> getLoginServices(serviceUrl);
  Future<dynamic> getLoginServices1(serviceUrl);
}

final  loginRepositoryProvider = Provider((ref) => LoginRepository());

class LoginRepository extends ILoginRepository {
  @override
  Future<dynamic> getLoginServices(serviceUrl) async{
    return "";
  }

  @override
  Future<dynamic> getLoginServices1(serviceUrl) async{
    return "";
  }
}