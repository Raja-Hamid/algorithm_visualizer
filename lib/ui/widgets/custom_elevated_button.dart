import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  const CustomElevatedButton({super.key, required this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
          elevation: 6,
          shadowColor: Colors.black.withValues(alpha: 0.4),
        ),
        onPressed: onPressed,
        child: Ink(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF56CCF2), Color(0xFF2F80ED)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
