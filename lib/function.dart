String convertDateTime(DateTime dateTime, [bool detikan = false]) {
  String month;
  String jam;
  String menit;
  String detik;
  jam = dateTime.hour.toString().length == 1
      ? "0" + dateTime.hour.toString()
      : dateTime.hour.toString();
  detik = dateTime.second.toString().length == 1
      ? "0" + dateTime.second.toString()
      : dateTime.second.toString();
  menit = dateTime.minute.toString().length == 1
      ? "0" + dateTime.minute.toString()
      : dateTime.minute.toString();
  switch (dateTime.month) {
    case 1:
      month = 'Jan';
      break;
    case 2:
      month = 'Feb';
      break;
    case 3:
      month = 'Mar';
      break;
    case 4:
      month = 'Apr';
      break;
    case 5:
      month = 'Mei';
      break;
    case 6:
      month = 'Jun';
      break;
    case 7:
      month = 'Jul';
      break;
    case 8:
      month = 'Aug';
      break;
    case 9:
      month = 'Sep';
      break;
    case 10:
      month = 'Okt';
      break;
    case 11:
      month = 'Nov';
      break;
    default:
      month = 'Des';
  }
  if (!detikan) {
    return '${dateTime.day} ${month} ${dateTime.year.toString()} , ${jam}:${menit}';
  }
  return '${dateTime.day} ${month} ${dateTime.year.toString()} , ${jam}:${menit}:${detik}';
}
