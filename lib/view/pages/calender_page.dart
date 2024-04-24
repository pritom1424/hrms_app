import 'package:flutter/material.dart';
import 'package:hrms_app/view/widgets/appbar_default_widget.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends StatefulWidget {
  String? title;
  CalendarScreen({super.key, this.title});
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _selectedDate = DateTime.now();
  List<DateTime> _selectedDates = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (widget.title == null)
          ? null
          : AppbarDefault(
              appbarName: widget.title,
            ),
      body: Column(
        children: [
          _buildMonthHeader(),
          _buildCalendarGrid(),
          _buildSelectedDates(),
        ],
      ),
    );
  }

  Widget _buildMonthHeader() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              setState(() {
                _selectedDate =
                    DateTime(_selectedDate.year, _selectedDate.month - 1);
              });
            },
          ),
          Text(
            DateFormat.yMMMM().format(_selectedDate),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: Icon(Icons.chevron_right),
            onPressed: () {
              setState(() {
                _selectedDate =
                    DateTime(_selectedDate.year, _selectedDate.month + 1);
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarGrid() {
    final List<DateTime> daysInMonth =
        _getDaysInMonth(_selectedDate.year, _selectedDate.month);
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
      ),
      itemCount: daysInMonth.length,
      itemBuilder: (context, index) {
        final day = daysInMonth[index];
        return GestureDetector(
          onTap: () {
            setState(() {
              if (_selectedDates.contains(day)) {
                _selectedDates.remove(day);
              } else {
                _selectedDates.add(day);
              }
            });
          },
          child: Container(
            alignment: Alignment.center,
            child: Text(
              day.day.toString(),
              style: TextStyle(
                fontWeight: _selectedDates.contains(day)
                    ? FontWeight.bold
                    : FontWeight.normal,
                color: _selectedDates.contains(day) ? Colors.blue : null,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSelectedDates() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selected Dates:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Wrap(
            spacing: 8.0,
            children: _selectedDates
                .map((date) => Chip(
                      label: Text(DateFormat('MMM dd, yyyy').format(date)),
                      onDeleted: () {
                        setState(() {
                          _selectedDates.remove(date);
                        });
                      },
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  List<DateTime> _getDaysInMonth(int year, int month) {
    final int daysInMonth = DateTime(year, month + 1, 0).day;
    return List<DateTime>.generate(
        daysInMonth, (index) => DateTime(year, month, index + 1));
  }
}
