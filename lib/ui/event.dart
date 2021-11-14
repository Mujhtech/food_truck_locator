import 'package:flutter/material.dart';
import 'package:food_truck_locator/controllers/appointment_controller.dart';
import 'package:food_truck_locator/models/meeting_model.dart';
import 'package:food_truck_locator/utils/constant.dart';
import 'package:food_truck_locator/widgets/modals/appointment_modal.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      final appointment = watch(appointmentController);
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.black,
            ),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          centerTitle: true,
          title: Text(
            'Event Calendar',
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SfCalendar(
          onTap: (CalendarTapDetails details) {
            List<dynamic> appointment = details.appointments!;
            DateTime date = details.date!;
            if (appointment.isEmpty) {
              return;
            }
            showCupertinoModalBottomSheet(
                shadow: const BoxShadow(color: Colors.transparent),
                elevation: 0,
                expand: true,
                backgroundColor: Colors.transparent,
                transitionBackgroundColor: Colors.transparent,
                context: context,
                builder: (context) =>
                    AppointmentModal(date: date, item: appointment));
          },
          view: CalendarView.month,
          dataSource: MeetingDataSource(
              appointment.meetings != null && appointment.meetings!.isNotEmpty
                  ? appointment.meetings!
                  : []),
          showNavigationArrow: true,
          headerStyle: CalendarHeaderStyle(
              textAlign: TextAlign.left,
              textStyle: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(fontSize: 24, fontWeight: FontWeight.w600)),
          todayHighlightColor: Commons.primaryColor,
          todayTextStyle: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: Commons.whiteColor),
          appointmentTextStyle: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: Commons.whiteColor),
          monthViewSettings: const MonthViewSettings(
              showAgenda: false,
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
        ),
      );
    });
  }
}

class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<MeetingModel> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  MeetingModel _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final MeetingModel meetingData;
    if (meeting is MeetingModel) {
      meetingData = meeting;
    }

    return meetingData;
  }
}
