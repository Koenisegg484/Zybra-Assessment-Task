import 'package:flutter/material.dart';


class SortChip extends StatelessWidget {
  const SortChip({
    super.key,
    required this.title,
    required this.nums,
  });

  final String title;
  final int nums;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Chip(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        shape: const RoundedRectangleBorder(side: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(100))),
        label: Row(
          children: [
            Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),),
            const SizedBox(width: 20,),
            Container(
              height: 30,
              width: 30,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(100))
              ),
              child: Text(nums.toString(), style: const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w400), textAlign: TextAlign.center,),
            )
          ],
        ),
      ),
    );
  }
}