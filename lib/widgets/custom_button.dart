import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final Color color;
  final bool loading;

  const CustomButton({
    Key? key,
    this.label = 'Continue',
    required this.onPressed,
    this.color = Colors.blue,
    this.loading = false,
  }) : super(key: key);

  bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 800;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      width: MediaQuery.of(context).size.width,
      child: TextButton(
        onPressed: onPressed,
        child: loading
            ? const Center(child: CircularProgressIndicator())
            : Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18.0,
                ),
              ),
      ),
    );
  }
}
