extension FormattedTime on int {
  String toFormattedTime() {
    final hours = Duration(milliseconds: this).inHours;
    final minutes = Duration(milliseconds: this).inMinutes.remainder(60);
    final seconds = Duration(milliseconds: this).inSeconds.remainder(60);

    return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }
}