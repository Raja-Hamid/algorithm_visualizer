import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:algorithm_visualizer/path_finders/path_finder_painter.dart';
import 'package:algorithm_visualizer/algorithms/astar_path_finder.dart';
import 'package:algorithm_visualizer/algorithms/dijkstra_path_finder.dart';
import 'package:algorithm_visualizer/path_finders/base_path_finder.dart';
import 'package:algorithm_visualizer/path_finders/node.dart';

const int size = 17;
const int walls = 100;

class ExecutionScreen extends StatefulWidget {
  final BasePathFinder pathFinder;
  const ExecutionScreen({super.key, required this.pathFinder});

  @override
  State<ExecutionScreen> createState() => _ExecutionScreenState();
}

class _ExecutionScreenState extends State<ExecutionScreen> {
  late Offset startPosition;
  late Offset endPosition;
  late List<List<Node>> nodes;

  @override
  void initState() {
    super.initState();
    _generateNewBoard();
  }

  void _generateNewBoard() {
    startPosition = Offset(
      Random().nextInt(size).toDouble(),
      Random().nextInt(size).toDouble(),
    );
    endPosition = Offset(
      Random().nextInt(size).toDouble(),
      Random().nextInt(size).toDouble(),
    );
    nodes = _generateNodes(size, walls, startPosition, endPosition);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          widget.pathFinder.name,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24.sp,
          ),
        ),
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 24.sp,
          ),
          onTap: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: GestureDetector(
              child: Icon(
                Icons.refresh,
                color: Colors.white,
                size: 24.sp,
              ),
              onTap: () {
                setState(() {
                  _generateNewBoard();
                });
              }
            ),
          )
        ],
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.black,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(8.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20.h),
                Expanded(
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(24.r),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.08),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.25),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          )
                        ],
                      ),
                      child: StreamBuilder<List<List<Node>>>(

                        stream: _executePathfindingAlgorithm(
                          nodes,
                          startPosition,
                          endPosition,
                        ),
                        initialData: nodes,
                        builder: (BuildContext context,
                            AsyncSnapshot<List<List<Node>>> finderSnapshot) {
                          return StreamBuilder<List<Node>>(
                            key: ValueKey('$startPosition-$endPosition'),
                            stream: widget.pathFinder.getPath(
                                nodes[endPosition.dy.floor()]
                                    [endPosition.dx.floor()]),
                            initialData: const <Node>[],
                            builder: (BuildContext context,
                                AsyncSnapshot<List<Node>> pathSnapshot) {
                              return CustomPaint(
                                size: Size(size * 20.0.w, size * 20.0.w),
                                painter: PathFinderPainter(
                                  finderSnapshot.data!,
                                  pathSnapshot.data!,
                                  nodes[startPosition.dy.floor()]
                                      [startPosition.dx.floor()],
                                  nodes[endPosition.dy.floor()]
                                      [endPosition.dx.floor()],
                                ),
                              );
                            },
                          );
                        },
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

  Stream<List<List<Node>>> _executePathfindingAlgorithm(
    List<List<Node>> nodes,
    Offset startPosition,
    Offset endPosition,
  ) {
    final startNode = nodes[startPosition.dy.floor()][startPosition.dx.floor()];
    final endNode = nodes[endPosition.dy.floor()][endPosition.dx.floor()];

    if (widget.pathFinder is AStarPathFinder) {
      final astarPathFinder = widget.pathFinder as AStarPathFinder;
      return astarPathFinder(nodes, startNode, endNode);
    } else if (widget.pathFinder is DijkstraPathFinder) {
      final dijkstraPathFinder = widget.pathFinder as DijkstraPathFinder;
      return dijkstraPathFinder(nodes, startNode, endNode);
    } else {
      throw UnsupportedError('Unsupported pathfinding algorithm');
    }
  }

  List<List<Node>> _generateNodes(
      int size, int walls, Offset start, Offset end) {
    final List<List<Node>> nodes = <List<Node>>[];
    for (int i = 0; i < size; i++) {
      final List<Node> row = <Node>[];

      for (int j = 0; j < size; j++) {
        row.add(Node(Offset(j.toDouble(), i.toDouble())));
      }
      nodes.add(row);
    }
    for (int i = 0; i < walls; i++) {
      final int row = Random().nextInt(size);
      final int column = Random().nextInt(size);

      final int startX = start.dx.floor();
      final int startY = start.dy.floor();

      final int endX = end.dx.floor();
      final int endY = end.dy.floor();

      if (nodes[row][column] == nodes[startY][startX] ||
          nodes[row][column] == nodes[endY][endX]) {
        i--;
        continue;
      }
      nodes[row][column].isWall = true;
    }
    return nodes;
  }
}
