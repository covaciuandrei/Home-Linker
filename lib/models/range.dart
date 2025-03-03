import 'package:equatable/equatable.dart';

class Range extends Equatable {
  const Range({required this.min, required this.max});
  final double min;
  final double max;

  @override
  List<Object?> get props => [min, max];
}
