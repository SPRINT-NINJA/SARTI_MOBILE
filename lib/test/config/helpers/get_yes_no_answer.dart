import 'package:dio/dio.dart';
import 'package:sarti_mobile/test/domain/entities/msg.dart';
import 'package:sarti_mobile/test/infrastructure/models/yes_no_model.dart';

class GetYesNoAnswer {
  final _dio = Dio(
    BaseOptions(
      baseUrl: 'https://yesno.wtf/api',
    ),
  );

  Future<Msg> getAnswer() async {
    final response = await _dio.get('/');
    final yesNoModel = YesNoModel.fromJsonMap(response.data);
    return yesNoModel.toMsgEntity();
  }
}
