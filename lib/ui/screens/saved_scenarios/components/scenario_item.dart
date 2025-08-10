import 'package:flutter/material.dart';
import 'package:new_wild/models/scenario_result_model.dart';

class ScenarioItem extends StatefulWidget {
  const ScenarioItem({required this.scenario, super.key});
  final ScenarioResultModel scenario;

  @override
  State<ScenarioItem> createState() => _ScenarioItemState();
}

class _ScenarioItemState extends State<ScenarioItem> {
  // состояние карточки(развернута или нет)
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    //карточка с информацией
    return Card(
        elevation: 4,
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            // временно делаем колонке мин
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.scenario.title,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      maxLines: 1, //текст занимает 1 строку и после ...
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          _isExpanded = !_isExpanded;
                        });
                      },
                      icon: Icon(
                        _isExpanded ? Icons.expand_less : Icons.expand_more,
                        color: Colors.grey[600],
                      )),
                ],
              ),
              if (!_isExpanded)
                Text(
                  widget.scenario.body,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14.0, color: Colors.black54),
                ),
              if (_isExpanded)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.scenario.body,
                      style: TextStyle(fontSize: 14.0, color: Colors.black54),
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 0.8,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    _buildDetaliRows(
                        'Platforms', widget.scenario.request.platform.name),
                    _buildDetaliRows(
                        'Theme', widget.scenario.request.videoTheme),
                    _buildDetaliRows('Target Auditory',
                        widget.scenario.request.targetAudience),
                    _buildDetaliRows(
                        'Call To action', widget.scenario.request.callToAction),
                    SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.share, color: Colors.blue),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.delete, color: Colors.red),
                        ),
                      ],
                    )
                  ],
                )
            ],
          ),
        ));
  }

//функция рисует после текста информацию
  Widget _buildDetaliRows(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            '$title ',
            style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 14.0, color: Colors.black54),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
