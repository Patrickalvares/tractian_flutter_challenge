import 'package:tractian_challenge/core/domain/entities/asset.dart';
import 'package:tractian_challenge/core/domain/entities/location.dart';
import 'package:tractian_challenge/features/assets_list/components/tree_node.dart';

class TreeBuilder {
  static List<TreeNode> buildTreeFromData({
    required List<Location> locations,
    required List<Asset> assets,
  }) {
    final Map<String, TreeNode> allNodes = {};
    final List<TreeNode> rootNodes = [];

    for (final location in locations) {
      final node = TreeNode.fromLocation(location);
      allNodes[location.id] = node;
    }

    for (final asset in assets) {
      final node = TreeNode.fromAsset(asset);
      allNodes[asset.id] = node;
    }

    for (final node in allNodes.values) {
      if (node.parentId != null && allNodes.containsKey(node.parentId!)) {
        allNodes[node.parentId!]!.addChild(node);
      } else {
        rootNodes.add(node);
      }
    }

    rootNodes.sort(_compareNodes);

    _sortChildrenRecursively(rootNodes);

    return rootNodes;
  }

  static void _sortChildrenRecursively(List<TreeNode> nodes) {
    for (final node in nodes) {
      if (node.children.isNotEmpty) {
        node.children.sort(_compareNodes);
        _sortChildrenRecursively(node.children);
      }
    }
  }

  static int _compareNodes(TreeNode a, TreeNode b) {
    final typeOrder = {TreeNodeType.location: 0, TreeNodeType.asset: 1, TreeNodeType.component: 2};

    final aOrder = typeOrder[a.type] ?? 3;
    final bOrder = typeOrder[b.type] ?? 3;

    if (aOrder != bOrder) {
      return aOrder.compareTo(bOrder);
    }

    return a.name.compareTo(b.name);
  }

  static List<TreeNode> filterTree({
    required List<TreeNode> nodes,
    String? searchText,
    bool energyFilter = false,
    bool criticalFilter = false,
  }) {
    final List<TreeNode> filteredNodes = [];

    for (final node in nodes) {
      final filteredNode = node.filterTree(
        searchText: searchText,
        energyFilter: energyFilter,
        criticalFilter: criticalFilter,
      );

      if (filteredNode != null) {
        if (searchText?.isNotEmpty == true || energyFilter || criticalFilter) {
          _expandNodeAndChildren(filteredNode);
        }
        filteredNodes.add(filteredNode);
      }
    }

    return filteredNodes;
  }

  static void _expandNodeAndChildren(TreeNode node) {
    node.isExpanded = true;
    for (final child in node.children) {
      _expandNodeAndChildren(child);
    }
  }

  static void expandAllNodes(List<TreeNode> nodes) {
    for (final node in nodes) {
      _expandNodeAndChildren(node);
    }
  }

  static void collapseAllNodes(List<TreeNode> nodes) {
    for (final node in nodes) {
      _collapseNodeAndChildren(node);
    }
  }

  static void _collapseNodeAndChildren(TreeNode node) {
    node.isExpanded = false;
    for (final child in node.children) {
      _collapseNodeAndChildren(child);
    }
  }
}
