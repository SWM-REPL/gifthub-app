import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VoucherCard extends StatelessWidget {
  final int voucherId;
  final String name;
  final String imageUri;
  final int price;
  final DateTime expiredAt;

  const VoucherCard({
    super.key,
    required this.voucherId,
    required this.name,
    required this.imageUri,
    required this.price,
    required this.expiredAt,
  });

  @override
  Widget build(BuildContext context) {
    final priceText = '${NumberFormat('#,##0', 'en-US').format(price)}원';
    final expiredAtText = DateFormat('yyyy년 MM월 dd일까지').format(expiredAt);

    return SizedBox(
      height: 100,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      imageUri,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          priceText,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          expiredAtText,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
