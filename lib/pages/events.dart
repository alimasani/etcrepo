import 'package:etc/bloc/bloc.dart';
import 'package:etc/components/eventitem.dart';
import 'package:etc/components/linedivider.dart';
import 'package:etc/components/loader.dart';
import 'package:etc/helper/globals.dart';
import 'package:etc/helper/methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

class Events extends StatefulWidget {
  Events({Key key}) : super(key: key);

  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  CalendarController _calendarController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _calendarController.dispose();
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged' +
        first.toString() +
        " --- " +
        last.toString());
    BlocProvider.of<EventsBloc>(context)
      ..add(GetEvents(
          startDateTime: first.toString(), endDateTime: last.toString()));
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
    BlocProvider.of<EventsBloc>(context)
      ..add(GetEvents(
          startDateTime: first.toString(), endDateTime: last.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          child: TableCalendar(
            calendarController: _calendarController,
            events: null,
            holidays: null,
            startingDayOfWeek: StartingDayOfWeek.sunday,
            calendarStyle: CalendarStyle(
              selectedColor: Colors.deepOrange[400],
              todayColor: Colors.deepOrange[200],
              markersColor: Colors.brown[700],
              outsideDaysVisible: false,
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              centerHeaderTitle: true,
            ),
            daysOfWeekStyle: DaysOfWeekStyle(),
            rowHeight: 40.0,
            onDaySelected: null,
            onVisibleDaysChanged: _onVisibleDaysChanged,
            onCalendarCreated: _onCalendarCreated,
            initialCalendarFormat: CalendarFormat.month,
            availableGestures: AvailableGestures.horizontalSwipe,
          ),
        ),
        LineDivider(),
        Container(
          margin: EdgeInsets.fromLTRB(20.0, 0.0, 10.0, 10.0),
          child: Text(
            "Things to do",
            style: TextStyle(
                color: blueColor, fontSize: 18.0, fontWeight: FontWeight.w600),
            textAlign: TextAlign.left,
          ),
        ),
        Expanded(
          child: BlocBuilder<EventsBloc, EventsState>(
            builder: (context, state) {
              if (state is EventsSuccess) {
                final eventList = state.events;
                print(eventList);
                return ListView.builder(
                    itemCount: eventList.length,
                    itemBuilder: (context, index) {
                      var eveItem = eventList[index];
                      return Container(
                          child: EventItem(eItem: eventList[index]));
                    });
              
              } else if (state is EventsError) {
                return Container(
                  width:MediaQuery.of(context).size.width,
                  child: Text("No Events Found",textAlign: TextAlign.center,));
              } else {
                return CustomLoader();
              }
            },
          ),
        ),
      ],
    );
  }
}
