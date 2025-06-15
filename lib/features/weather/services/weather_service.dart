
import 'package:dio/dio.dart';
import '../models/weather_models.dart';

/// 날씨 API 키 (환경 변수에서 가져옴)
const String _openWeatherApiKey = String.fromEnvironment('OPENWEATHER_API_KEY');
const String _airQualityApiKey = String.fromEnvironment('AIRQUALITY_API_KEY');

/// 날씨 서비스 구현
class WeatherService {
  final Dio _dio;
  
  WeatherService(this._dio);

  /// 현재 날씨 가져오기
  Future<WeatherData> getCurrentWeather(double lat, double lon) async {
    try {
      final response = await _dio.get(
        'https://api.openweathermap.org/data/2.5/weather',
        queryParameters: {
          'lat': lat,
          'lon': lon,
          'appid': _openWeatherApiKey,
          'units': 'metric',
          'lang': 'kr',
        },
      );

      return WeatherData.fromOpenWeatherMap(response.data);
    } catch (e) {
      // API 키가 없거나 에러 발생 시 mock 데이터 반환
      return _getMockWeatherData(lat, lon);
    }
  }

  /// 대기질 정보 가져오기
  Future<AirQualityData> getAirQuality(double lat, double lon) async {
    try {
      final response = await _dio.get(
        'https://api.openweathermap.org/data/2.5/air_pollution',
        queryParameters: {
          'lat': lat,
          'lon': lon,
          'appid': _openWeatherApiKey,
        },
      );

      return AirQualityData.fromOpenWeatherMap(response.data);
    } catch (e) {
      // API 키가 없거나 에러 발생 시 mock 데이터 반환
      return _getMockAirQualityData();
    }
  }

  /// 날씨 예보 가져오기 (7일)
  Future<List<WeatherForecast>> getWeatherForecast(double lat, double lon) async {
    try {
      final response = await _dio.get(
        'https://api.openweathermap.org/data/2.5/forecast/daily',
        queryParameters: {
          'lat': lat,
          'lon': lon,
          'appid': _openWeatherApiKey,
          'units': 'metric',
          'lang': 'kr',
          'cnt': 7,
        },
      );

      return (response.data['list'] as List)
          .map((item) => WeatherForecast.fromOpenWeatherMap(item))
          .toList();
    } catch (e) {
      // API 키가 없거나 에러 발생 시 mock 데이터 반환
      return _getMockForecastData();
    }
  }

  /// 한국 기상청 API를 사용한 미세먼지 정보
  Future<AirQualityData> getKoreaAirQuality(double lat, double lon) async {
    try {
      // 좌표를 주소로 변환
      final address = await _getAddressFromCoordinates(lat, lon);
      
      final response = await _dio.get(
        'http://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getMsrstnAcctoRltmMesureDnsty',
        queryParameters: {
          'serviceKey': _airQualityApiKey,
          'returnType': 'json',
          'numOfRows': 1,
          'pageNo': 1,
          'stationName': address.station,
          'dataTerm': 'DAILY',
          'ver': '1.0',
        },
      );

      return AirQualityData.fromKoreaAPI(response.data);
    } catch (e) {
      return _getMockAirQualityData();
    }
  }

  /// 좌표를 주소로 변환
  Future<AddressInfo> _getAddressFromCoordinates(double lat, double lon) async {
    try {
      // Kakao 또는 Naver API 사용
      final response = await _dio.get(
        'https://dapi.kakao.com/v2/local/geo/coord2address.json',
        queryParameters: {
          'x': lon,
          'y': lat,
        },
        options: Options(
          headers: {
            'Authorization': 'KakaoAK ${const String.fromEnvironment('KAKAO_API_KEY')}',
          },
        ),
      );

      return AddressInfo.fromKakaoAPI(response.data);
    } catch (e) {
      return AddressInfo(
        address: '서울특별시 강남구',
        station: '강남구',
      );
    }
  }

  /// Mock 날씨 데이터
  WeatherData _getMockWeatherData(double lat, double lon) {
    return WeatherData(
      temperature: 22 + (lat.round() % 5),
      feelsLike: 25 + (lat.round() % 5),
      humidity: 65,
      windSpeed: 3.2,
      windDirection: 'SW',
      pressure: 1013,
      visibility: 10,
      uvIndex: 6,
      condition: WeatherCondition.partlyCloudy,
      description: '구름 조금',
      location: '서울특별시 강남구',
      timestamp: DateTime.now(),
    );
  }

  /// Mock 대기질 데이터
  AirQualityData _getMockAirQualityData() {
    return AirQualityData(
      aqi: 85,
      pm25: 35,
      pm10: 55,
      o3: 120,
      no2: 25,
      so2: 8,
      co: 0.8,
      grade: AirQualityGrade.moderate,
      timestamp: DateTime.now(),
    );
  }

  /// Mock 예보 데이터
  List<WeatherForecast> _getMockForecastData() {
    final now = DateTime.now();
    return List.generate(7, (index) {
      return WeatherForecast(
        date: now.add(Duration(days: index)),
        maxTemp: 25 + (index % 3),
        minTemp: 15 + (index % 3),
        condition: WeatherCondition.values[index % WeatherCondition.values.length],
        description: ['맑음', '구름 조금', '흐림', '비', '눈'][index % 5],
        precipitationChance: [10, 20, 60, 80, 30][index % 5],
      );
    });
  }
}
