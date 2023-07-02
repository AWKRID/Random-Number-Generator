import 'dart:math';

import 'package:flutter/material.dart';

import '../constant/color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<int> randomNumbers = [
    123,
    456,
    789,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: SafeArea(
        child: Padding(
          // padding: const EdgeInsets.all(16.0),
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Header(),
              _Body(randomNumbers: randomNumbers),
              _Footer(onPressed: onRandomNumberGenerated),
            ],
          ),
        ),
      ),
    );
  }

  void onRandomNumberGenerated() {
    final rand = Random();
    final Set<int> newNumbers = {};
    while (newNumbers.length != 3) {
      final number = rand.nextInt(999);
      newNumbers.add(number);
    }
    setState(() {
      randomNumbers = newNumbers.toList();
    });
  }
}

class _Header extends StatelessWidget {
  const _Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '랜덤숫자 생성기',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.settings,
            color: RED_COLOR,
          ),
        ),
      ],
    );
  }
}

class _Body extends StatelessWidget {
  final List<int> randomNumbers;
  const _Body({required this.randomNumbers, super.key});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: randomNumbers
            .asMap()
            .entries
            .map((x) => Padding(
                  padding: EdgeInsets.only(
                    bottom: x.key == 2 ? 0 : 16.0,
                  ),
                  child: Row(
                    children: x.value
                        .toString()
                        .split('')
                        .map(
                          (y) => Image.asset(
                            'asset/img/$y.png',
                            height: 70.0,
                            width: 50.0,
                          ),
                        )
                        .toList(),
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  final VoidCallback onPressed;
  const _Footer({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return // SizedBox로 감싸서 button 크기 늘리기.
        // Row + Expanded로도 가능
        // Container로도 가능하지만 SizedBox가 기능이 제한적 -> 성능이 미세하게 빠르다.
        SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: RED_COLOR),
        onPressed: onPressed,
        child: Text('생성하기'),
      ),
    );
  }
}
