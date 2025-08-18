import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GenerateScenarioTile extends StatefulWidget {
  const GenerateScenarioTile({
    super.key,
    required this.backgroundColor,
    required this.iconBackgroundColor,
    required this.assetPath,
    required this.title,
    required this.description,
    this.onTap,
  });

  final Color backgroundColor;
  final Color? iconBackgroundColor;
  final String assetPath;
  final String title;
  final String description;
  final VoidCallback? onTap; // для GestureDetector
  @override
  State<GenerateScenarioTile> createState() => _GenerateScenarioTileState();
}

class _GenerateScenarioTileState extends State<GenerateScenarioTile> {
  bool isPressed = false; //по умолчанию, не нажата
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // виджет, который ловит события по нажатию
      onTap: widget.onTap,
      onTapDown: (_) => setState(() {
        // когда нажата на экране(любое место) меняется на тру
        isPressed = true;
      }),
      onTapUp: (_) => setState(() {
        // когда отжата на экране(любое место) меняется на фолс
        isPressed = false;
      }),
      onTapCancel: () => setState(() {
        // когда отжтянем по экране(любое место) меняется на фолс
        isPressed = false;
      }),
      child: AnimatedScale(
        duration: Duration(milliseconds: 100),
        scale: isPressed ? 0.95 : 1.0, //при нажатии уменьшается

        child: DecoratedBox(
          decoration: BoxDecoration(
            //Цвет, если нажата, то карточка осветляется

            color: isPressed
                ? widget.backgroundColor.withValues(alpha: 90)
                : widget.backgroundColor,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withValues(alpha: 76),
                  spreadRadius: 3.0,
                  blurRadius: 5.0,
                  offset: const Offset(0, 3)),
            ],
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.iconBackgroundColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SvgPicture.asset(
                      widget.assetPath,
                      width: 32,
                      height: 32,
                    ),
                  ),
                ),
                const SizedBox(width: 20.0),
                Expanded(
                  //оборачиваем в експандедт виджет, чтобы занимала все пространство
                  child: Column(
                    mainAxisSize: MainAxisSize
                        .min, // чтобы карточка была маленькой, а не на весь экран
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // текст начинается справа
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      ),
                      Text(
                        widget.description,
                        style: TextStyle(fontSize: 16.0, color: Colors.black54),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
