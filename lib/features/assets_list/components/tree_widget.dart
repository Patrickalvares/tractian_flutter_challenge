import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tractian_challenge/features/assets_list/components/tree_node.dart';
import 'package:tractian_challenge/utils/app_colors.dart';
import 'package:tractian_challenge/utils/app_svg.dart';

class TreeWidget extends StatefulWidget {
  const TreeWidget({super.key, required this.nodes, this.onNodeTap});

  final List<TreeNode> nodes;
  final Function(TreeNode)? onNodeTap;

  @override
  State<TreeWidget> createState() => _TreeWidgetState();
}

class _TreeWidgetState extends State<TreeWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.nodes.length,
      itemBuilder: (context, index) {
        return _TreeNodeWidget(
          node: widget.nodes[index],
          level: 0,
          isLast: index == widget.nodes.length - 1,
          parentLines: [],
          onNodeTap: widget.onNodeTap,
          onExpandToggle: _toggleExpansion,
        );
      },
    );
  }

  void _toggleExpansion(TreeNode node) {
    setState(() {
      node.isExpanded = !node.isExpanded;
    });
  }
}

class _TreeNodeWidget extends StatelessWidget {
  const _TreeNodeWidget({
    required this.node,
    required this.level,
    required this.isLast,
    required this.parentLines,
    this.onNodeTap,
    this.onExpandToggle,
  });

  final TreeNode node;
  final int level;
  final bool isLast;
  final List<bool> parentLines;
  final Function(TreeNode)? onNodeTap;
  final Function(TreeNode)? onExpandToggle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_buildNodeRow(), if (node.isExpanded && node.hasChildren) ..._buildChildren()],
    );
  }

  Widget _buildNodeRow() {
    return InkWell(
      onTap: () {
        if (node.hasChildren) {
          onExpandToggle?.call(node);
        }
        onNodeTap?.call(node);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: [
            SizedBox(
              width: level * 24.0 + 24.0,
              height: 24.0,
              child: CustomPaint(
                painter: _TreeLinePainter(
                  level: level,
                  isLast: isLast,
                  hasChildren: node.hasChildren,
                  isExpanded: node.isExpanded,
                  parentLines: parentLines,
                ),
              ),
            ),
            if (node.hasChildren)
              Icon(
                node.isExpanded ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_right,
                size: 16,
                color: AppColor.lightFont,
              )
            else
              const SizedBox(width: 16),
            const SizedBox(width: 4),
            _buildNodeIcon(),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                node.name,
                style: const TextStyle(fontSize: 14, color: AppColor.darkFont),
              ),
            ),
            if (node.isEnergyComponent)
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: SvgPicture.asset(
                  AppSvg.lightning,
                  width: 12,
                  height: 12,
                  colorFilter: const ColorFilter.mode(Colors.green, BlendMode.srcIn),
                ),
              ),
            if (node.isCriticalComponent)
              const Padding(
                padding: EdgeInsets.only(left: 4),
                child: Icon(Icons.circle, size: 8, color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildNodeIcon() {
    String iconPath;
    Color iconColor = AppColor.primary;

    switch (node.type) {
      case TreeNodeType.location:
        iconPath = AppSvg.localization;
        break;
      case TreeNodeType.asset:
        iconPath = AppSvg.asset;
        break;
      case TreeNodeType.component:
        iconPath = AppSvg.component;
        break;
    }

    return SvgPicture.asset(
      iconPath,
      width: 20,
      height: 20,
      colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
    );
  }

  List<Widget> _buildChildren() {
    return node.children.asMap().entries.map((entry) {
      final index = entry.key;
      final child = entry.value;
      final isLastChild = index == node.children.length - 1;

      final updatedParentLines = [...parentLines, !isLast];

      return _TreeNodeWidget(
        node: child,
        level: level + 1,
        isLast: isLastChild,
        parentLines: updatedParentLines,
        onNodeTap: onNodeTap,
        onExpandToggle: onExpandToggle,
      );
    }).toList();
  }
}

class _TreeLinePainter extends CustomPainter {
  const _TreeLinePainter({
    required this.level,
    required this.isLast,
    required this.hasChildren,
    required this.isExpanded,
    required this.parentLines,
  });

  final int level;
  final bool isLast;
  final bool hasChildren;
  final bool isExpanded;
  final List<bool> parentLines;

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = AppColor.lightFont.withValues(alpha: 0.3)
          ..strokeWidth = 1.0
          ..style = PaintingStyle.stroke;

    const double centerY = 12.0;
    const double lineOffset = 12.0;

    for (int i = 0; i < parentLines.length; i++) {
      if (parentLines[i]) {
        final x = (i + 1) * 24.0 + lineOffset;
        canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
      }
    }

    if (level > 0) {
      final startX = level * 24.0 + lineOffset;
      final endX = startX + 12.0;
      canvas.drawLine(Offset(startX, centerY), Offset(endX, centerY), paint);

      final verticalStartY = isLast ? 0.0 : centerY;
      final verticalEndY = isLast ? centerY : size.height;
      canvas.drawLine(Offset(startX, verticalStartY), Offset(startX, verticalEndY), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
