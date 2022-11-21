import 'package:flutter/material.dart';

class HomeGridCellModel {
  const HomeGridCellModel({
    this.color,
    this.columnStart,
    this.columnSpan = 1,
    this.rowStart,
    this.rowSpan = 1,
    this.href = '',
    required this.index,
    required this.content,
  });

  final Color? color;
  final int? columnStart;
  final int columnSpan;
  final int? rowStart;
  final int rowSpan;
  final int index;
  final String href;
  final String content;
}
