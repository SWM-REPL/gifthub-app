// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:barcode_widget/barcode_widget.dart';
import 'package:screen_brightness/screen_brightness.dart';

// 🌎 Project imports:
import 'package:gifthub/utility/navigator.dart';
import 'package:gifthub/utility/show_snack_bar.dart';

class VoucherBarcodeView extends StatefulWidget {
  final String barcode;

  const VoucherBarcodeView(this.barcode, {super.key});

  @override
  State<VoucherBarcodeView> createState() => _VoucherBarcodeViewState();
}

class _VoucherBarcodeViewState extends State<VoucherBarcodeView> {
  double lastBrightness = 0.5;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.leanBack,
    );
    _setMaxScreenBrightness();
  }

  @override
  void dispose() {
    _revertScreenBrightness();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  void _setMaxScreenBrightness() async {
    try {
      lastBrightness = await ScreenBrightness().current;
      await ScreenBrightness().setScreenBrightness(1.0);
    } catch (error) {
      showSnackBar(const Text('화면 밝기 조절에 실패했습니다.'));
    }
  }

  void _revertScreenBrightness() async {
    try {
      await ScreenBrightness().setScreenBrightness(lastBrightness);
    } catch (error) {
      showSnackBar(const Text('화면 밝기 조절에 실패했습니다.'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
      backgroundColor: Theme.of(context).colorScheme.surface,
    );
  }

  Widget _buildBody(BuildContext context) {
    return TapRegion(
      onTapInside: (event) => navigateBack(),
      onTapOutside: (event) => navigateBack(),
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.height / 2,
          child: BarcodeWidget(
            data: widget.barcode,
            barcode: Barcode.code128(),
          ),
        ),
      ),
    );
  }
}
