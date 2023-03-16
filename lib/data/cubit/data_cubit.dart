/*import 'package:bloc/bloc.dart';
import 'package:untitled/data/cubit/data_state.dart';
import 'package:untitled/data/models/server/ApiReturnValue.dart';
import 'package:untitled/data/models/server/data_sensor.dart';
import 'package:untitled/data/services/data_sensor_services.dart';

class DataCubit extends Cubit<DataState> {
  DataCubit() : super(DataInitial());
  Future<void> index() async {
    ApiReturnValue<List<Result>> results = await DataSensorService.index();
    if (results.value != null) {
      emit(DataLoaded(results.value));
    } else {
      emit(DataLoadingFailed("periksa koneksi internet"));
    }
  }
}*/
