import 'package:flutter/material.dart';
import 'package:weather_app/modules/splash_module/screens/new_splash_screen.dart';
import 'package:audioplayers/audioplayers.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideRightAnimation;
  final AudioPlayer _audioPlayer = AudioPlayer();
  
  @override
  void initState(){
    super.initState();
    _playAudio();
    _controller = AnimationController(
    duration: const Duration(seconds: 5),
    vsync: this,);

    _slideAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: const Offset(1.0, 0.0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic));
    
    _slideRightAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: const Offset(-1.0, 0.0) ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic));

    _fadeAnimation = Tween<double>(
      begin: 1.0, 
      end: 0.0, 
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInCubic));
    _controller.forward();
    _controller.addStatusListener((status) {
      if (status==AnimationStatus.completed){
        _stopAudio();
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const MainSplashScreen(),
            transitionDuration: Duration.zero,
          ),
        );
      }
    },);
  }
  void _playAudio() async {
    await _audioPlayer.play(AssetSource('weather_app/assets/audio/distant-breeze-241047.mp3')); // Play background music
  }

  void _stopAudio() async {
    await _audioPlayer.stop(); // Stop music when screen transitions
  }

  @override
  void dispose(){
    _controller.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
    backgroundColor:  const Color(0xff303553),
    body: SingleChildScrollView(
        child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Opacity(
              opacity: 0.2,
              child: SlideTransition(
                position: _slideAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation, 
                  child: Image.asset('assets/images/cloud_1.png')),
              ),
            ),
            Opacity(
              opacity: 0.2,
              child: SlideTransition(
                position: _slideAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation, 
                  child: Image.asset('assets/images/BIG_CLOUD.png')),
              ),
            ),
            Opacity(
              opacity: 0.2,
              child: SlideTransition(
                position: _slideRightAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation, 
                  child: Image.asset('assets/images/BIG_CLOUD.png')),
              ),
            ),
            Opacity(
              opacity: 0.2,
              child: SlideTransition(
                position: _slideRightAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation, 
                  child: Image.asset('assets/images/cloud_5.png')),
              ),
            ),
            Opacity(
              opacity: 0.2,
              child: SlideTransition(
                position: _slideAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation, 
                  child: Image.asset('assets/images/BIG_CLOUD.png')),
              ),
            ),
          ],
        ),),
    )
   );
  }
}

