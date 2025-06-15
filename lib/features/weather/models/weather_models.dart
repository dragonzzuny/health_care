
/// 날씨 상태 열거형
enum WeatherCondition {
  clear,
  partlyCloudy,
  cloudy,
  rain,
  drizzle,
  thunderstorm,
  snow,
  mist,
  unknown,
}

/// 대기질 등급
enum AirQualityGrade { good, moderate, unhealthy, veryUnhealthy }

/// 날씨 데이터 모델
class WeatherData {
  final double temperature;
  final double feelsLike;
  final int humidity;
  final double windSpeed;
  final String windDirection;
  final int pressure;
  final double visibility;
  final int uvIndex;
  final WeatherCondition condition;
  final String description;
  final String location;
  final DateTime timestamp;

  WeatherData({
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.windDirection,
    required this.pressure,
    required this.visibility,
    required this.uvIndex,
    required this.condition,
    required this.description,
    required this.location,
    required this.timestamp,
  });

  factory WeatherData.fromOpenWeatherMap(Map<String, dynamic> json) {
    final weather = json['weather'][0];
    final main = json['main'];
    final wind = json['wind'];
    return WeatherData(
      temperature: main['temp'].toDouble(),
      feelsLike: main['feels_like'].toDouble(),
      humidity: main['humidity'],
      windSpeed: wind['speed'].toDouble(),
      windDirection: _getWindDirection(wind['deg']),
      pressure: main['pressure'],
      visibility: (json['visibility'] / 1000).toDouble(),
      uvIndex: 0,
      condition: _mapWeatherCondition(weather['id']),
      description: weather['description'],
      location: json['name'],
      timestamp: DateTime.now(),
    );
  }

  static String _getWindDirection(int degrees) {
    const directions = ['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW'];
    final index = ((degrees + 22.5) / 45).floor() % 8;
    return directions[index];
  }

  static WeatherCondition _mapWeatherCondition(int weatherId) {
    if (weatherId >= 200 && weatherId < 300) return WeatherCondition.thunderstorm;
    if (weatherId >= 300 && weatherId < 400) return WeatherCondition.drizzle;
    if (weatherId >= 500 && weatherId < 600) return WeatherCondition.rain;
    if (weatherId >= 600 && weatherId < 700) return WeatherCondition.snow;
    if (weatherId >= 700 && weatherId < 800) return WeatherCondition.mist;
    if (weatherId == 800) return WeatherCondition.clear;
    if (weatherId == 801 || weatherId == 802) return WeatherCondition.partlyCloudy;
    if (weatherId == 803 || weatherId == 804) return WeatherCondition.cloudy;
    return WeatherCondition.unknown;
  }
}

/// 대기질 데이터 모델
class AirQualityData {
  final int aqi;
  final double pm25;
  final double pm10;
  final double o3;
  final double no2;
  final double so2;
  final double co;
  final AirQualityGrade grade;
  final DateTime timestamp;

  AirQualityData({
    required this.aqi,
    required this.pm25,
    required this.pm10,
    required this.o3,
    required this.no2,
    required this.so2,
    required this.co,
    required this.grade,
    required this.timestamp,
  });

  factory AirQualityData.fromOpenWeatherMap(Map<String, dynamic> json) {
    final components = json['list'][0]['components'];
    final aqi = json['list'][0]['main']['aqi'];
    return AirQualityData(
      aqi: aqi,
      pm25: components['pm2_5'].toDouble(),
      pm10: components['pm10'].toDouble(),
      o3: components['o3'].toDouble(),
      no2: components['no2'].toDouble(),
      so2: components['so2'].toDouble(),
      co: components['co'].toDouble(),
      grade: AirQualityGrade.values[aqi - 1],
      timestamp: DateTime.now(),
    );
  }

  factory AirQualityData.fromKoreaAPI(Map<String, dynamic> json) {
    final item = json['response']['body']['items'][0];
    final aqi = int.tryParse(item['khaiValue'] ?? '') ?? 0;
    return AirQualityData(
      aqi: aqi,
      pm25: double.parse(item['pm25Value']),
      pm10: double.parse(item['pm10Value']),
      o3: double.parse(item['o3Value']),
      no2: double.parse(item['no2Value']),
      so2: double.parse(item['so2Value']),
      co: double.parse(item['coValue']),
      grade: AirQualityGrade.values[(aqi.clamp(1, 4)) - 1],
      timestamp: DateTime.now(),
    );
  }
}

class WeatherForecast {
  final DateTime date;
  final int maxTemp;
  final int minTemp;
  final WeatherCondition condition;
  final String description;
  final int precipitationChance;

  WeatherForecast({
    required this.date,
    required this.maxTemp,
    required this.minTemp,
    required this.condition,
    required this.description,
    required this.precipitationChance,
  });

  factory WeatherForecast.fromOpenWeatherMap(Map<String, dynamic> json) {
    return WeatherForecast(
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      maxTemp: (json['temp']['max']).round(),
      minTemp: (json['temp']['min']).round(),
      condition: WeatherCondition.values.first,
      description: json['weather'][0]['description'],
      precipitationChance: (json['pop'] * 100).round(),
    );
  }
}

class AddressInfo {
  final String address;
  final String station;

  AddressInfo({required this.address, required this.station});

  factory AddressInfo.fromKakaoAPI(Map<String, dynamic> json) {
    final doc = json['documents'][0];
    final road = doc['road_address'];
    return AddressInfo(
      address: road != null ? road['address_name'] : doc['address']['address_name'],
      station: road != null ? road['region_2depth_name'] : doc['address']['region_2depth_name'],
    );
  }
}
