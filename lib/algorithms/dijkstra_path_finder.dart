import 'dart:async';
import 'package:algorithm_visualizer/path_finders/base_path_finder.dart';
import 'package:algorithm_visualizer/path_finders/node.dart';

class DijkstraPathFinder extends BasePathFinder {
  DijkstraPathFinder() : super('Dijkstra Path Finder');

  @override
  Stream<List<List<Node>>> call(
      List<List<Node>> graph,
      Node start,
      Node end, [
        Duration delay = const Duration(milliseconds: 10),
      ]) async* {
    final List<Node> queue = <Node>[start];
    start.g = 0;

    while (queue.isNotEmpty) {
      queue.sort((a, b) => a.g.compareTo(b.g));
      final Node node = queue.removeAt(0);

      if (node == end) {
        return;
      }

      node.visited = true;

      final List<Node> neighbors = getNeighbors(graph, node);

      for (final Node neighbor in neighbors) {
        if (neighbor.visited) {
          continue;
        }

        final double tentativeG = node.g + 1;
        if (tentativeG < neighbor.g || neighbor.g == 0) {
          neighbor
            ..g = tentativeG
            ..previous = node;

          if (!queue.contains(neighbor)) {
            queue.add(neighbor);
          }
        }
      }

      await Future<void>.delayed(delay);
      yield graph;
    }
  }
}
