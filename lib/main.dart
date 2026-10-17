import 'package:flutter/material.dart';
import 'package:weather/model/weather_model.dart';
import 'package:weather/repositories/weather_repositories.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<WeatherModel> _weatherFuture;
  final TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    _weatherFuture = WeatherRepositories(city: 'Osh').getWeather();
  }

  void _search() {
    final shaar = controller.text.trim();
    if (shaar.isEmpty) return;
    setState(() {
      _weatherFuture = WeatherRepositories(city: shaar).getWeather();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: controller,
                onSubmitted: (_) => _search(),
                decoration: const InputDecoration(
                  hintText: 'Шаардын атын жаз',
                  border: OutlineInputBorder(),
                ),
              ),
              Expanded(
                child: FutureBuilder<WeatherModel>(
                  future: _weatherFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Ката: ${snapshot.error}'));
                    }
                    final weather = snapshot.data!;
                    return Center(
                      child: Text(
                        '${weather.temp}',
                        style: const TextStyle(fontSize: 40),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
