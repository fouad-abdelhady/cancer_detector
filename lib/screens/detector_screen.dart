import 'dart:io';

import 'package:cancer_detector/utils/extentions/text_styls.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../constants/colors.dart';
import '../constants/strings.dart';

class DetectorScreen extends StatefulWidget {
  static const PAGE_ROUTE = "/detectorScreen";
  const DetectorScreen({super.key});

  @override
  State<DetectorScreen> createState() => _DetectorScreenState();
}

class _DetectorScreenState extends State<DetectorScreen> {
  final ImagePicker picker = ImagePicker();
  var _imageSelected = false;
  XFile? image;

  @override
  void initState() {
    //initTflite();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          if (!_imageSelected) _buildUnpickedImageImage(context),
          if (_imageSelected) _buildSelectedImage(),
          if (_imageSelected) ..._buidImagePickedBody(),
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildUnpickedImageImage(BuildContext context) {
    return SliverToBoxAdapter(
      child: InkWell(
        onTap: _pickImage,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          alignment: Alignment.center,
          width: double.infinity,
          height: MediaQuery.of(context).size.height - 180,
          child: Column(
            children: [
              Image.asset(
                'assets/pickImage.png',
                fit: BoxFit.contain,
              ),
              const Text("Press To pick Image")
                  .largeHeadline(context, fontSize: 25)
            ],
          ),
        ),
      ),
    );
  }

  SliverAppBar _buildAppBar() {
    return const SliverAppBar(
      expandedHeight: 120,
      pinned: false,
      floating: true,
      leading: Icon(
        Icons.arrow_back_ios,
        color: Colors.black,
        size: 25,
      ),
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          "Detector",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  void _pickImage() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      setState(() {
        _imageSelected = false;
      });
    } else {
      setState(() {
        _imageSelected = true;
      });
    }
  }

  SliverToBoxAdapter _buildSelectedImage() {
    return SliverToBoxAdapter(
      child: Image.file(File(image!.path)),
    );
  }

  List<SliverToBoxAdapter> _buidImagePickedBody() => [
        SliverToBoxAdapter(
          child: _buildAnaliysButton(),
        ),
        SliverToBoxAdapter(
          child: _buildSelectAnotherImageButton(),
        )
      ];
  Widget _buildAnaliysButton() {
    return InkWell(
      onTap: () {},
      child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: AppColors.mainButtonsColor),
          child: Text(Strings().analyse).largeHeadline(context,
              fontSize: 25, textColor: AppColors.mainButtonsLableColor)),
    );
  }

  Widget _buildSelectAnotherImageButton() {
    return TextButton(
        onPressed: _pickImage, child: Text(Strings().selectAnotherImage));
  }

  /*void _scanImageAndDisplayResult() {
    Object output = Object();
    _interpreter.run(image!.path, output);
    print("The value is ${output.toString()}");
  }

  void initTflite() async {
    /*interpreter = await tfl.Interpreter.fromAsset('model_unquant.tflite');
    print("The value is ---- ready");*/
    try {
      final interpreterOptions = InterpreterOptions()..threads = 2;
      final interpreter = await Interpreter.fromAsset('model.tflite',
          options: interpreterOptions);
      _interpreter = interpreter;
    } catch (e) {
      print('Failed to load model: $e');
    }
  }*/

  void scanImageMethod2() {}
}
