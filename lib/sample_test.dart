import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'engine/domain/model/git_repository.dart';

class AnimatedListSample extends StatefulWidget {
  @override
  _AnimatedListSampleState createState() => _AnimatedListSampleState();
}

class _AnimatedListSampleState extends State<AnimatedListSample> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  ListModel _list;

  Repository _selectedItem;

  @override
  void initState() {
    super.initState();
    _list = ListModel(
      listKey: _listKey,
      removedItemBuilder: _buildRemovedItem,
    );
  }

  Widget _buildItem(BuildContext context, int index, Animation<double> animation) {
    return CardItem(
      animation: animation,
      item: _list[index],
      selected: _selectedItem == _list[index],
      onTap: () {
        setState(() {
          _selectedItem = _selectedItem == _list[index] ? null : _list[index];
        });
      },
    );
  }

  Widget _buildRemovedItem(Repository item, BuildContext context, Animation<double> animation) {
    return CardItem(
      animation: animation,
      item: item,
      selected: false,
    );
  }

  void _insert(Repository repository) {
    final int index = _selectedItem == null ? _list.length : _list.indexOf(_selectedItem);
    _list.insert(index, repository);
  }

  void _remove(Repository repository) {
    if (_selectedItem != null) {
      _list.removeAt(_list.indexOf(repository));
      setState(() {
        _selectedItem = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('AnimatedList'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add_circle),
              onPressed: (){
                _insert(Repository("name", "workdir"));
                },
              tooltip: 'insert a new item',
            ),
            IconButton(
              icon: const Icon(Icons.remove_circle),
              onPressed: (){
                _remove(Repository("name", "workdir"));
                },
              tooltip: 'remove the selected item',
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AnimatedList(
            key: _listKey,
            initialItemCount: _list.length,
            itemBuilder: _buildItem,
          ),
        ),
      ),
    );
  }
}




class ListModel {
  ListModel({
    @required this.listKey,
    @required this.removedItemBuilder
  }) : assert(listKey != null),
        assert(removedItemBuilder != null),
        _items = List();

  final GlobalKey<AnimatedListState> listKey;
  final dynamic removedItemBuilder;
  final List<Repository> _items;

  AnimatedListState get _animatedList => listKey.currentState;

  void insert(int index, Repository item) {
    _items.insert(index, item);
    _animatedList.insertItem(index);
  }

  Repository removeAt(int index) {
    final Repository removedItem = _items.removeAt(index);
    if (removedItem != null) {
      _animatedList.removeItem(
        index,
            (BuildContext context, Animation<double> animation) => removedItemBuilder(removedItem, context, animation),
      );
    }
    return removedItem;
  }

  int get length => _items.length;

  Repository operator [](int index) => _items[index];

  int indexOf(Repository item) => _items.indexOf(item);
}



class CardItem extends StatelessWidget {
  const CardItem({
    Key key,
    @required this.animation,
    this.onTap,
    @required this.item,
    this.selected: false
  }) : assert(animation != null),
        assert(item != null),
        assert(selected != null),
        super(key: key);

  final Animation<double> animation;
  final VoidCallback onTap;
  final Repository item;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headline4;
    if (selected)
      textStyle = textStyle.copyWith(color: Colors.lightGreenAccent[400]);

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: SizeTransition(
        axis: Axis.vertical,
        sizeFactor: animation,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: SizedBox(
            height: 80.0,
            child: Card(
              color: Colors.black12,
              child: Center(
                child: Text('Item $item', style: textStyle),
              ),
            ),
          ),
        ),
      ),
    );
  }
}