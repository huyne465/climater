// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:http/http.dart' as _i519;
import 'package:injectable/injectable.dart' as _i526;

import '../../../features/data/datasources/location_remote_data_source.dart'
    as _i143;
import '../../../features/data/datasources/location_remote_data_source_impl.dart'
    as _i218;
import '../../../features/data/datasources/weather_remote_data_source.dart'
    as _i36;
import '../../../features/data/datasources/weather_remote_data_source_impl.dart'
    as _i642;
import '../../../features/data/repositories/location_repository_impl.dart'
    as _i84;
import '../../../features/data/repositories/weather_repository_impl.dart'
    as _i848;
import '../../../features/data/services/weather/weather_service.dart' as _i536;
import '../../../features/domain/repositories/location_repository.dart'
    as _i1072;
import '../../../features/domain/repositories/weather_repository.dart' as _i827;
import '../../../features/domain/usecases/get_weather_by_city.dart' as _i1069;
import '../../../features/domain/usecases/get_weather_by_current_location.dart'
    as _i122;
import '../../../features/weather/presentation/pages/ui/city_screen/viewModel/city_screen_view_model.dart'
    as _i1028;
import '../../../features/weather/presentation/pages/ui/loading_screen/viewModel/loading_screen_view_model.dart'
    as _i30;
import '../../../features/weather/presentation/pages/ui/location_screen/viewModel/location_screen_view_model.dart'
    as _i7;
import '../module/registerModule.dart' as _i830;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.factory<_i519.Client>(() => registerModule.httpClient);
    gh.singleton<_i536.WeatherService>(() => _i536.WeatherService());
    gh.factory<_i143.LocationRemoteDataSource>(
      () => _i218.LocationRemoteDataSourceImpl(),
    );
    gh.factory<_i1072.LocationRepository>(
      () => _i84.LocationRepositoryImpl(
        remoteDataSource: gh<_i143.LocationRemoteDataSource>(),
      ),
    );
    gh.factory<_i36.WeatherRemoteDataSource>(
      () => _i642.WeatherRemoteDataSourceImpl(client: gh<_i519.Client>()),
    );
    gh.factory<_i827.WeatherRepository>(
      () => _i848.WeatherRepositoryImpl(
        remoteDataSource: gh<_i36.WeatherRemoteDataSource>(),
      ),
    );
    gh.factory<_i1069.GetWeatherByCity>(
      () => _i1069.GetWeatherByCity(gh<_i827.WeatherRepository>()),
    );
    gh.factory<_i1028.CityScreenViewModel>(
      () => _i1028.CityScreenViewModel(
        getWeatherByCity: gh<_i1069.GetWeatherByCity>(),
      ),
    );
    gh.factory<_i122.GetWeatherByCurrentLocation>(
      () => _i122.GetWeatherByCurrentLocation(
        weatherRepository: gh<_i827.WeatherRepository>(),
        locationRepository: gh<_i1072.LocationRepository>(),
      ),
    );
    gh.factory<_i30.LoadingScreenViewModel>(
      () => _i30.LoadingScreenViewModel(
        getWeatherByCity: gh<_i1069.GetWeatherByCity>(),
        getWeatherByCurrentLocation: gh<_i122.GetWeatherByCurrentLocation>(),
      ),
    );
    gh.factory<_i7.LocationViewModel>(
      () => _i7.LocationViewModel(
        getWeatherByCity: gh<_i1069.GetWeatherByCity>(),
        getWeatherByCurrentLocation: gh<_i122.GetWeatherByCurrentLocation>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i830.RegisterModule {}
