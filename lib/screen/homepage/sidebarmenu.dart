import 'package:flutter/material.dart';
import 'package:online_shop/config/app_routes.dart';

class HoverableListTile extends StatefulWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final VoidCallback? onTap;

  const HoverableListTile({
    super.key,
    required this.icon,
    required this.title,
    this.isSelected = false,
    this.onTap,
  });

  @override
  State<HoverableListTile> createState() => _HoverableListTileState();
}

class _HoverableListTileState extends State<HoverableListTile> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = widget.isSelected
        ? const Color.fromRGBO(167, 23, 23, 1) // активна вкладка
        : (_isHovering ? Colors.grey.shade300 : Colors.transparent); // при hover

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: Container(
        color: backgroundColor,
        child: ListTile(
          leading: Icon(widget.icon),
          title: Text(widget.title),
          onTap: widget.onTap,
        ),
      ),
    );
  }
}
class SidebarMenu extends StatelessWidget {
  const SidebarMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      color: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          SizedBox(height: 24),
          HoverableListTile(icon: Icons.lightbulb_outline, title: 'Нотатки', onTap: () => Navigator.of(context).pushReplacementNamed(AppRoutes.home),),
          HoverableListTile(icon: Icons.delete_outline, title: 'Кошик', onTap: () => Navigator.of(context).pushReplacementNamed(AppRoutes.home)),
        ],
      ),
    );
  }
}


