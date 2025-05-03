import 'package:flutter/material.dart';
import 'package:weather_app/modules/temperature_module/screens/temperature.dart';

// Import your TemperatureScreen here
// import 'package:weather_app/modules/temperature_module/screens/temperature_screen.dart';

class MainSplashScreen extends StatefulWidget {
  const MainSplashScreen({super.key});

  @override
  State<MainSplashScreen> createState() => _MainSplashScreenState();
}

class _MainSplashScreenState extends State<MainSplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              const TemperatureScreen(), // Replace with your actual TemperatureScreen widget
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff303553),
        body: Stack(
          children: [
            // Top cloud
            Positioned(
              top: 80,
              right: 60,
              child: CustomPaint(
                size: const Size(100, 60),
                painter: CloudPainter(),
              ),
            ),
            Positioned(
              top: 0,
              left: 10,
              child: CustomPaint(
                size: const Size(150, 80),
                painter: CloudPainter(),
              ),
            ),
            // Middle clouds
            Positioned(
              top: 180,
              left: 0,
              child: CustomPaint(
                size: const Size(150, 80),
                painter: CloudPainter(),
              ),
            ),
            Positioned(
                bottom: 200,
                left: 10,
                child:
                    CustomPaint(size: const Size(120, 80), painter: CloudPainter())),
            Positioned(
                bottom: 150,
                right: 0,
                child:
                    CustomPaint(size: const Size(80, 50), painter: CloudPainter())),

            Positioned(
              top: 320,
              right: 40,
              child: CustomPaint(
                size: const Size(80, 50),
                painter: CloudPainter(),
              ),
            ),

            Positioned(
              bottom: 0,
              right: 0,
              child: CustomPaint(
                size: const Size(70, 50),
                painter: CloudPainter(),
              ),
            ),
            // Bottom cloud
            Positioned(
              bottom: 80,
              left: 40,
              right: 40,
              child: CustomPaint(
                size: const Size(250, 100),
                painter: CloudPainter(),
              ),
            ),
            // Center content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment:MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'VVeatherly',
                        style: TextStyle(
                          fontSize: 36,
                          fontFamily: 'CrimsonPro',
                          fontWeight: FontWeight.bold,
                          color: Colors.white.withOpacity(0.4),
                        ),
                      ),
                      Icon(Icons.umbrella, color: Colors.white.withOpacity(0.4))
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'an intuitive and minimalistic vveather and uv app',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'CrimsonPro',
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.italic,
                      color: Colors.white.withOpacity(0.4),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom painter for cloud shapes
class CloudPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    final path = Path();

    // Draw a cloud shape
    path.moveTo(size.width * 0.2, size.height * 0.5);
    path.quadraticBezierTo(size.width * 0.1, size.height * 0.2,
        size.width * 0.3, size.height * 0.2);
    path.quadraticBezierTo(size.width * 0.4, size.height * 0.05,
        size.width * 0.5, size.height * 0.2);
    path.quadraticBezierTo(size.width * 0.6, size.height * 0.05,
        size.width * 0.7, size.height * 0.2);
    path.quadraticBezierTo(size.width * 0.9, size.height * 0.2,
        size.width * 0.8, size.height * 0.5);
    path.quadraticBezierTo(size.width * 0.9, size.height * 0.8,
        size.width * 0.6, size.height * 0.8);
    path.quadraticBezierTo(size.width * 0.4, size.height * 0.9,
        size.width * 0.3, size.height * 0.7);
    path.quadraticBezierTo(size.width * 0.1, size.height * 0.7,
        size.width * 0.2, size.height * 0.5);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
