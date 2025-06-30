import 'package:tractian_challenge/core/domain/entities/asset.dart';
import 'package:tractian_challenge/core/domain/entities/location.dart';

enum TreeNodeType { location, asset, component }

class TreeNode {
  final String id;
  final String name;
  final TreeNodeType type;
  final Location? location;
  final Asset? asset;
  final String? parentId;
  final String? sensorType;
  final String? status;
  final List<TreeNode> children;
  bool isExpanded;

  TreeNode({
    required this.id,
    required this.name,
    required this.type,
    this.location,
    this.asset,
    this.parentId,
    this.sensorType,
    this.status,
    this.children = const [],
    this.isExpanded = false,
  });

  factory TreeNode.fromLocation(Location location) {
    return TreeNode(
      id: location.id,
      name: location.name,
      type: TreeNodeType.location,
      location: location,
      parentId: location.parentId,
      children: [],
    );
  }

  factory TreeNode.fromAsset(Asset asset) {
    final isComponent = asset.sensorType != null && asset.sensorType!.isNotEmpty;
    return TreeNode(
      id: asset.id,
      name: asset.name,
      type: isComponent ? TreeNodeType.component : TreeNodeType.asset,
      asset: asset,
      parentId: asset.parentId ?? (asset.locationId),
      sensorType: asset.sensorType,
      status: asset.status,
      children: [],
    );
  }

  void addChild(TreeNode child) {
    children.add(child);
  }

  bool get hasChildren => children.isNotEmpty;

  bool get isComponent => type == TreeNodeType.component;
  bool get isAsset => type == TreeNodeType.asset;
  bool get isLocation => type == TreeNodeType.location;

  bool get isEnergyComponent => isComponent && sensorType?.toLowerCase() == 'energy';

  bool get isCriticalComponent => isComponent && status?.toLowerCase() == 'alert';

  bool matchesFilter({String? searchText, bool energyFilter = false, bool criticalFilter = false}) {
    bool matches = true;

    if (searchText != null && searchText.isNotEmpty) {
      matches = matches && name.toLowerCase().contains(searchText.toLowerCase());
    }

    if (energyFilter) {
      matches = matches && isEnergyComponent;
    }

    if (criticalFilter) {
      matches = matches && isCriticalComponent;
    }

    return matches;
  }

  TreeNode? filterTree({
    String? searchText,
    bool energyFilter = false,
    bool criticalFilter = false,
  }) {
    List<TreeNode> filteredChildren = [];

    for (TreeNode child in children) {
      TreeNode? filteredChild = child.filterTree(
        searchText: searchText,
        energyFilter: energyFilter,
        criticalFilter: criticalFilter,
      );
      if (filteredChild != null) {
        filteredChildren.add(filteredChild);
      }
    }

    bool shouldInclude = false;

    if ((searchText?.isEmpty ?? true) && !energyFilter && !criticalFilter) {
      shouldInclude = true;
    } else {
      shouldInclude =
          matchesFilter(
            searchText: searchText,
            energyFilter: energyFilter,
            criticalFilter: criticalFilter,
          ) ||
          filteredChildren.isNotEmpty;
    }

    if (shouldInclude) {
      return TreeNode(
        id: id,
        name: name,
        type: type,
        location: location,
        asset: asset,
        parentId: parentId,
        sensorType: sensorType,
        status: status,
        children: filteredChildren,
        isExpanded: isExpanded,
      );
    }

    return null;
  }
}
