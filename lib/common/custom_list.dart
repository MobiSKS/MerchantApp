// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomList<T> extends StatelessWidget {
  Widget Function(T, int)? child;
  List<T>? list;
  double? itemSpace;
  Widget? seprator;
  ScrollController? controller;
  ScrollPhysics physics;
  Axis axis;
  int? itemCount;
  CustomList(
      {super.key, 
      this.child,
      this.itemCount,
      this.seprator,
      this.list = const [],
      this.physics = const ScrollPhysics(),
      this.controller,
      this.itemSpace = 0.0,
      this.axis = Axis.vertical})
      ;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: controller,
      physics: physics,
      scrollDirection: axis,
      shrinkWrap: true,

      separatorBuilder: (context, index) =>
          seprator ??
          SizedBox(
            width: axis == Axis.horizontal ? itemSpace : 0.0,
            height: axis == Axis.horizontal ? 0.0 : itemSpace,
          ),
      itemBuilder:
          (context, index) => 
              Container(child: child!(list![index], index)),
      itemCount: list!.length,
    );
  }
}
