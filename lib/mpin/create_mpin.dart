import 'package:dd_shop/otp_generate/otp_generate_controller.dart';
import 'package:dd_shop/utils/components/text_field_curved_edges.dart';
import 'package:dd_shop/utils/constants/app_fonts.dart';
import 'package:dd_shop/utils/constants/colors.dart';
import 'package:dd_shop/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import '../utils/components/elevated_rounded_button.dart';

class CreateMpin extends StatefulWidget {
  CreateMpin({super.key});

  @override
  State<CreateMpin> createState() => _CreateMpinState();
}

class _CreateMpinState extends State<CreateMpin> {
  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());
  final List<FocusNode> reFocusNodes = List.generate(6, (_) => FocusNode());

  final List<TextEditingController> mpinControllers =
  List.generate(6, (_) => TextEditingController());
  final List<TextEditingController> reMpinControllers =
  List.generate(6, (_) => TextEditingController());

  @override
  void initState() {
    super.initState();
    _addFocusListeners();
  }

  void _addFocusListeners() {
    for (int i = 0; i < focusNodes.length; i++) {
      focusNodes[i].addListener(() {
        if (!focusNodes[i].hasFocus && mpinControllers[i].text.isEmpty) {
          // Clear text if the user leaves an empty field
          mpinControllers[i].clear();
        }
      });
    }

    for (int i = 0; i < reFocusNodes.length; i++) {
      reFocusNodes[i].addListener(() {
        if (!reFocusNodes[i].hasFocus && reMpinControllers[i].text.isEmpty) {
          reMpinControllers[i].clear();
        }
      });
    }
  }

  @override
  void dispose() {
    for (var node in focusNodes) {
      node.dispose();
    }
    for (var node in reFocusNodes) {
      node.dispose();
    }
    for (var controller in mpinControllers) {
      controller.dispose();
    }
    for (var controller in reMpinControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _handleTextFieldInput(int index, List<FocusNode> nodes) {
    if (mpinControllers[index].text.isNotEmpty && index < nodes.length - 1) {
      nodes[index + 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(MediaQuery.of(context).size.height * 0.15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: SvgPicture.asset(
                'images/splash_logo.svg',
                fit: BoxFit.fill,
              ),
            ),
            Gap(24),
            _buildTitle(Dd_Strings.enter_new_mpin),
            _buildPinInputRow(focusNodes, mpinControllers),
            Gap(18),
            _buildTitle(Dd_Strings.re_enter_your_mpin),
            _buildPinInputRow(reFocusNodes, reMpinControllers),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: RoundedElevatedButton(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.05,
          text: Dd_Strings.submit_button_text,
          onPressed: () => _compareMpin(context),
          cornerRadius: 6.0,
          buttonColor: AppColors.appSecondaryColor,
          textStyle: AppFonts.title.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Text(
        text,
        textAlign: TextAlign.start,
        style: AppFonts.title.copyWith(
          color: AppColors.appPrimaryColor,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildPinInputRow(List<FocusNode> nodes, List<TextEditingController> controllers) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          6,
              (index) => _buildOtpTextField(nodes[index], controllers[index], index, nodes),
        ),
      ),
    );
  }

  Widget _buildOtpTextField(FocusNode focusNode, TextEditingController controller,
      int index, List<FocusNode> nodes) {
    return SizedBox(
      height: 48.0,
      width: 48.0,
      child: TextFieldCurvedEdges(
        controller: controller,
        focusNode: focusNode,
        backgroundColor: AppColors.white,
        keyboardType: TextInputType.number,
        borderColor: AppColors.grey_dots,
        textAlign: TextAlign.center,
        length: 1,
        borderRadius: 8,
        onChanged: (value) {
          if (value.isNotEmpty) {
            _handleTextFieldInput(index, nodes);
          }
        },
      ),
    );
  }

  void _compareMpin(BuildContext context) async {
    String mpin = mpinControllers.map((e) => e.text).join();
    String re_mpin = reMpinControllers.map((e) => e.text).join();
    print('this is entered mpin : $mpin');
    print('this is entered re mpin : $re_mpin');

    if (mpin == re_mpin) {
      await otp_controller.createMPIN(mpin, context);
    }
  }
}
