// 🐦 Flutter imports:
import 'package:flutter/material.dart';

class Notice extends StatelessWidget {
  const Notice({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Padding(
          padding: MediaQuery.of(context).viewPadding.add(
                const EdgeInsets.all(20),
              ),
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/notice_only-giftishow.png'),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(children: [
                    Flexible(
                      flex: 5,
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        child: const Text('다시보지않기'),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Flexible(
                      flex: 5,
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: OutlinedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          foregroundColor:
                              Theme.of(context).colorScheme.onPrimary,
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        child: const Text('닫기'),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
