import 'package:cancer_detector/screens/detector_screen.dart';
import 'package:cancer_detector/screens/login_screen.dart';
import 'package:cancer_detector/services/fireStoreManager.dart';
import 'package:cancer_detector/utils/extentions/text_styls.dart';
import 'package:cancer_detector/utils/indicators.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../constants/data.dart';
import '../constants/strings.dart';
import '../services/notification_services.dart';

class HomeScreen extends StatefulWidget {
  static const PAGE_ROUTE = "/homeScreen";

  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with Indicators {
  String userDisplayName = "";
  DateTime? _selectedDateTime;
  final notificationService = NotificationService();
  late YoutubePlayerController _controller;
  late NotificationService myNotification;
  final auth = FirebaseAuth.instance;
  @override
  void initState() {
    myNotification = NotificationService();
    final videoId = YoutubePlayer.convertUrlToId(YOUTUBE_VIDEO_URL) ?? "";
    _controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(autoPlay: false));
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    User user = ModalRoute.of(context)!.settings.arguments as User;
    FireStoreManager().getUserName(user.email ?? "").then((value) {
      setState(() {
        userDisplayName = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.green,
          onPressed: () {
            Navigator.of(context).pushNamed(DetectorScreen.PAGE_ROUTE);
          },
          label: const Text("Scan Your X-Ray")),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          _buildCustomSpace(50),
          _aboutBreastCancer(context),
          _buildVideoPlayer(),
          _aboutBreastCancerParagraph(context),
          _buildCustomSpace(60)
        ],
      ),
    );
  }

  SliverPadding _aboutBreastCancerParagraph(BuildContext context) {
    return const SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      sliver: SliverToBoxAdapter(
        child: Text(
          ABOUT_CANCER,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildVideoPlayer() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
        ),
      ),
    );
  }

  SliverPadding _aboutBreastCancer(BuildContext context) {
    return SliverPadding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        sliver: SliverToBoxAdapter(
          child: Text(Strings().aboutBreastCancer)
              .largeHeadline(context, textColor: Colors.black87, fontSize: 30),
        ));
  }

  SliverToBoxAdapter _buildCustomSpace(double height) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: height,
      ),
    );
  }

  SliverAppBar _buildSliverAppBar() {
    return SliverAppBar(
      leading: IconButton(
          onPressed: () async {
            await auth.signOut();
            Navigator.of(context).pushReplacementNamed(LoginScreen.PAGE_ROUTE);
          },
          icon: Icon(Icons.logout_outlined, color: Colors.black, size: 35)),
      actions: [
        IconButton(
            onPressed: checkSchedualedAndPickDateTime,
            icon: const Icon(
              Icons.add_alarm_sharp,
              color: Colors.black,
              size: 35,
            ))
      ],
      expandedHeight: 120,
      pinned: false,
      floating: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          Strings().getWellcome(userDisplayName),
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  void checkSchedualedAndPickDateTime() async {
    if (await myNotification.checkPendingNotifications()) {
      if (await _showOptionsDialog() == false) return;
    }
    await _pickDateTime();
    if (_selectedDateTime == null) return;
    if (!_isDateTimeGreaterThanNow()) {
      // ignore: use_build_context_synchronously
      showSnacBarWithMessage(
          context: context, message: "Please selecte time greater than now");
      return;
    }

    notificationService.scheduleNotification(_getDuration());
  }

  Future<void> _pickDateTime() async {
    DateTime? pickedDateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2050),
    );

    if (pickedDateTime != null) {
      // ignore: use_build_context_synchronously
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(DateTime.now()),
      );

      if (pickedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            pickedDateTime.year,
            pickedDateTime.month,
            pickedDateTime.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  Duration _getDuration() {
    final now = DateTime.now();
    return _selectedDateTime!.difference(now);
  }

  bool _isDateTimeGreaterThanNow() {
    final now = DateTime.now();
    final isGreaterThanNow = _selectedDateTime!.isAfter(now);
    return isGreaterThanNow;
  }

  Future<bool> _showOptionsDialog() async {
    bool cancel = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Cancel notifcation?"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("Close")),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text("Yes")),
        ],
      ),
    );
    if (cancel) {
      await myNotification.cancelNotification();
      setState(() {});
    }
    return cancel;
  }
}
