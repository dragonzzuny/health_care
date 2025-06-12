import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherScreen extends ConsumerStatefulWidget {
  const WeatherScreen({super.key});

  @override
  ConsumerState<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends ConsumerState<WeatherScreen> {
  WeatherData? _currentWeather;
  AirQualityData? _airQuality;
  List<WeatherForecast> _forecast = [];
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadWeatherData();
  }

  Future<void> _loadWeatherData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final position = await _getCurrentPosition();
      await Future.wait([
        _loadCurrentWeather(position.latitude, position.longitude),
        _loadAirQuality(position.latitude, position.longitude),
        _loadForecast(position.latitude, position.longitude),
      ]);
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<Position> _getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('위치 서비스가 비활성화되어 있습니다');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('위치 권한이 거부되었습니다');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('위치 권한이 영구적으로 거부되었습니다');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> _loadCurrentWeather(double lat, double lon) async {
    // Simulate weather API call
    await Future.delayed(const Duration(seconds: 1));
    
    // Mock weather data
    setState(() {
      _currentWeather = WeatherData(
        temperature: 22,
        feelsLike: 25,
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
    });
  }

  Future<void> _loadAirQuality(double lat, double lon) async {
    // Simulate air quality API call
    await Future.delayed(const Duration(seconds: 1));
    
    // Mock air quality data
    setState(() {
      _airQuality = AirQualityData(
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
    });
  }

  Future<void> _loadForecast(double lat, double lon) async {
    // Simulate forecast API call
    await Future.delayed(const Duration(seconds: 1));
    
    // Mock forecast data
    final now = DateTime.now();
    setState(() {
      _forecast = List.generate(7, (index) {
        return WeatherForecast(
          date: now.add(Duration(days: index)),
          maxTemp: 25 + (index % 3),
          minTemp: 15 + (index % 3),
          condition: WeatherCondition.values[index % WeatherCondition.values.length],
          description: ['맑음', '구름 조금', '흐림', '비', '눈'][index % 5],
          precipitationChance: [10, 20, 60, 80, 30][index % 5],
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('날씨 & 대기질'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadWeatherData,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? _buildErrorWidget()
              : RefreshIndicator(
                  onRefresh: _loadWeatherData,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (_currentWeather != null) _buildCurrentWeather(),
                        const SizedBox(height: 16),
                        if (_airQuality != null) _buildAirQuality(),
                        const SizedBox(height: 16),
                        _buildHealthRecommendations(),
                        const SizedBox(height: 16),
                        if (_forecast.isNotEmpty) _buildForecast(),
                      ],
                    ),
                  ),
                ),
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            '데이터를 불러올 수 없습니다',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            _error ?? '알 수 없는 오류',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _loadWeatherData,
            child: const Text('다시 시도'),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentWeather() {
    final weather = _currentWeather!;
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  _getWeatherIcon(weather.condition),
                  size: 32,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Text(
                  '현재 날씨',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${weather.temperature}°C',
                        style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Text(
                        weather.description,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        '체감 ${weather.feelsLike}°C',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      weather.location,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${weather.timestamp.hour}:${weather.timestamp.minute.toString().padLeft(2, '0')} 업데이트',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 16),
            
            // Weather details
            Row(
              children: [
                Expanded(
                  child: _buildWeatherDetail('습도', '${weather.humidity}%', Icons.water_drop),
                ),
                Expanded(
                  child: _buildWeatherDetail('바람', '${weather.windSpeed}m/s ${weather.windDirection}', Icons.air),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildWeatherDetail('기압', '${weather.pressure}hPa', Icons.speed),
                ),
                Expanded(
                  child: _buildWeatherDetail('자외선', 'UV ${weather.uvIndex}', Icons.wb_sunny),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherDetail(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Theme.of(context).colorScheme.onSurfaceVariant),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAirQuality() {
    final airQuality = _airQuality!;
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.air,
                  size: 32,
                  color: _getAirQualityColor(airQuality.grade),
                ),
                const SizedBox(width: 12),
                Text(
                  '대기질',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getAirQualityColor(airQuality.grade).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: _getAirQualityColor(airQuality.grade)),
                  ),
                  child: Text(
                    _getAirQualityText(airQuality.grade),
                    style: TextStyle(
                      color: _getAirQualityColor(airQuality.grade),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            Row(
              children: [
                Text(
                  'AQI ${airQuality.aqi}',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: _getAirQualityColor(airQuality.grade),
                  ),
                ),
                const Spacer(),
                Text(
                  '${airQuality.timestamp.hour}:${airQuality.timestamp.minute.toString().padLeft(2, '0')} 업데이트',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 16),
            
            // Air quality details
            Row(
              children: [
                Expanded(
                  child: _buildAirQualityDetail('PM2.5', '${airQuality.pm25}㎍/㎥'),
                ),
                Expanded(
                  child: _buildAirQualityDetail('PM10', '${airQuality.pm10}㎍/㎥'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildAirQualityDetail('오존', '${airQuality.o3}㎍/㎥'),
                ),
                Expanded(
                  child: _buildAirQualityDetail('이산화질소', '${airQuality.no2}㎍/㎥'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAirQualityDetail(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildHealthRecommendations() {
    final recommendations = _getHealthRecommendations();
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.health_and_safety,
                  size: 32,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Text(
                  '건강 권장사항',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...recommendations.map((recommendation) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    recommendation.icon,
                    size: 20,
                    color: recommendation.color,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          recommendation.title,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          recommendation.description,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildForecast() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '7일 예보',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...(_forecast.take(7).map((forecast) => _buildForecastItem(forecast))),
          ],
        ),
      ),
    );
  }

  Widget _buildForecastItem(WeatherForecast forecast) {
    final isToday = forecast.date.day == DateTime.now().day;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            child: Text(
              isToday ? '오늘' : _formatDate(forecast.date),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          Icon(
            _getWeatherIcon(forecast.condition),
            size: 24,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              forecast.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Text(
            '${forecast.precipitationChance}%',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.blue,
            ),
          ),
          const SizedBox(width: 16),
          Text(
            '${forecast.maxTemp}° / ${forecast.minTemp}°',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  List<HealthRecommendation> _getHealthRecommendations() {
    final recommendations = <HealthRecommendation>[];
    
    if (_airQuality != null) {
      switch (_airQuality!.grade) {
        case AirQualityGrade.good:
          recommendations.add(HealthRecommendation(
            icon: Icons.directions_run,
            color: Colors.green,
            title: '야외 활동 좋음',
            description: '대기질이 좋아 야외 운동을 하기에 적합합니다.',
          ));
          break;
        case AirQualityGrade.moderate:
          recommendations.add(HealthRecommendation(
            icon: Icons.warning_amber,
            color: Colors.orange,
            title: '민감군 주의',
            description: '호흡기 질환자는 장시간 야외 활동을 피하세요.',
          ));
          break;
        case AirQualityGrade.unhealthy:
          recommendations.add(HealthRecommendation(
            icon: Icons.masks,
            color: Colors.red,
            title: '마스크 착용 권장',
            description: '외출 시 KF94 이상의 마스크를 착용하세요.',
          ));
          break;
        case AirQualityGrade.veryUnhealthy:
          recommendations.add(HealthRecommendation(
            icon: Icons.home,
            color: Colors.red,
            title: '실내 활동 권장',
            description: '가급적 실내에 머물고 외출을 자제하세요.',
          ));
          break;
      }
    }
    
    if (_currentWeather != null) {
      if (_currentWeather!.uvIndex >= 6) {
        recommendations.add(HealthRecommendation(
          icon: Icons.wb_sunny,
          color: Colors.orange,
          title: '자외선 차단 필요',
          description: '선크림을 발라주시고 모자나 선글라스를 착용하세요.',
        ));
      }
      
      if (_currentWeather!.temperature >= 30) {
        recommendations.add(HealthRecommendation(
          icon: Icons.local_drink,
          color: Colors.blue,
          title: '충분한 수분 섭취',
          description: '더운 날씨로 인한 탈수를 방지하기 위해 물을 자주 마시세요.',
        ));
      }
    }
    
    return recommendations;
  }

  IconData _getWeatherIcon(WeatherCondition condition) {
    switch (condition) {
      case WeatherCondition.sunny:
        return Icons.wb_sunny;
      case WeatherCondition.partlyCloudy:
        return Icons.wb_cloudy;
      case WeatherCondition.cloudy:
        return Icons.cloud;
      case WeatherCondition.rainy:
        return Icons.umbrella;
      case WeatherCondition.snowy:
        return Icons.ac_unit;
      case WeatherCondition.stormy:
        return Icons.thunderstorm;
    }
  }

  Color _getAirQualityColor(AirQualityGrade grade) {
    switch (grade) {
      case AirQualityGrade.good:
        return Colors.green;
      case AirQualityGrade.moderate:
        return Colors.orange;
      case AirQualityGrade.unhealthy:
        return Colors.red;
      case AirQualityGrade.veryUnhealthy:
        return Colors.purple;
    }
  }

  String _getAirQualityText(AirQualityGrade grade) {
    switch (grade) {
      case AirQualityGrade.good:
        return '좋음';
      case AirQualityGrade.moderate:
        return '보통';
      case AirQualityGrade.unhealthy:
        return '나쁨';
      case AirQualityGrade.veryUnhealthy:
        return '매우 나쁨';
    }
  }

  String _formatDate(DateTime date) {
    final weekdays = ['월', '화', '수', '목', '금', '토', '일'];
    return weekdays[date.weekday - 1];
  }
}

enum WeatherCondition { sunny, partlyCloudy, cloudy, rainy, snowy, stormy }
enum AirQualityGrade { good, moderate, unhealthy, veryUnhealthy }

class WeatherData {
  final int temperature;
  final int feelsLike;
  final int humidity;
  final double windSpeed;
  final String windDirection;
  final int pressure;
  final int visibility;
  final int uvIndex;
  final WeatherCondition condition;
  final String description;
  final String location;
  final DateTime timestamp;

  const WeatherData({
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
}

class AirQualityData {
  final int aqi;
  final int pm25;
  final int pm10;
  final int o3;
  final int no2;
  final int so2;
  final double co;
  final AirQualityGrade grade;
  final DateTime timestamp;

  const AirQualityData({
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
}

class WeatherForecast {
  final DateTime date;
  final int maxTemp;
  final int minTemp;
  final WeatherCondition condition;
  final String description;
  final int precipitationChance;

  const WeatherForecast({
    required this.date,
    required this.maxTemp,
    required this.minTemp,
    required this.condition,
    required this.description,
    required this.precipitationChance,
  });
}

class HealthRecommendation {
  final IconData icon;
  final Color color;
  final String title;
  final String description;

  const HealthRecommendation({
    required this.icon,
    required this.color,
    required this.title,
    required this.description,
  });
}

