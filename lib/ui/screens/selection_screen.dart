import 'package:algorithm_visualizer/ui/screens/execution_screen.dart';
import 'package:algorithm_visualizer/ui/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:algorithm_visualizer/algorithms/astar_path_finder.dart';
import 'package:algorithm_visualizer/algorithms/dijkstra_path_finder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Algorithm Visualizer',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24.sp,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(24.w),
            margin: EdgeInsets.symmetric(horizontal: 24.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                  color: Colors.white.withValues(alpha: 0.1), width: 1.w),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Choose Algorithm',
                  style: TextStyle(color: Colors.white, fontSize: 24.sp),
                ),
                SizedBox(height: 20.h),
                CustomElevatedButton(
                  title: 'A* Algorithm',
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExecutionScreen(
                        pathFinder: AStarPathFinder(),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
                CustomElevatedButton(
                  title: 'Dijkstra Algorithm',
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExecutionScreen(
                        pathFinder: DijkstraPathFinder(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
