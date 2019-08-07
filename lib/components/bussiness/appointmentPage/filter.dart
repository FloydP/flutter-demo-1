import 'package:flutter/material.dart';

class FilterView extends StatefulWidget {
  FilterView(
      {Key key,
      this.callback,
      @required this.data,
      @required this.currentIndex})
      : super(key: key);

  final Function(int pos, FilterCondition condition) callback;
  final List<FilterCondition> data;
  int currentIndex;

  @override
  State<StatefulWidget> createState() {
    return _FilterViewState();
  }
}

class _FilterViewState extends State<FilterView> {
  Widget _buildFilterButton(pos, FilterCondition condition) {
    return Expanded(
        flex: 1,
        child: Container(
          height: 41.0,
          child: FlatButton(
            textColor:
                widget.currentIndex == pos ? Color(0xFF00C3AA) : Colors.black,
            child: Text(condition.name),
            onPressed: () {
              setState(() {
                widget.currentIndex = pos;
                if (widget.callback != null) widget.callback(pos, condition);
              });
            },
          ),
        ));
  }

  List<Widget> _buildChildren() {
    var children = new List<Widget>();
    for (int i = 0; i < widget.data.length; i++) {
      children.add(_buildFilterButton(i, widget.data[i]));
      // divider
      if (i < widget.data.length - 1)
        children.add(new Container(
          width: 1.0,
          height: 41.0,
          color: const Color(0xFFE4E4E4),
        ));
    }
    return children;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        children: _buildChildren(),
      ),
    );
  }
}

// 过滤条件
class FilterCondition {
  final String name;
  final int id;

  FilterCondition({@required this.name, @required this.id});
}
