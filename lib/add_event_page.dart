import 'package:flutter/material.dart';
import 'event.dart'; // Import Event class

class AddEventPage extends StatefulWidget {
  final DateTime selectedDate;
  final Function(Event) onEventAdded; // Callback function

  const AddEventPage({Key? key, required this.selectedDate, required this.onEventAdded}) : super(key: key);

  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _eventNameController = TextEditingController();
  TextEditingController _noteController = TextEditingController();
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay.now();
  bool _remindsMe = false;
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Event'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _eventNameController,
                decoration: const InputDecoration(
                  labelText: 'Event name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter event name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _noteController,
                decoration: const InputDecoration(
                  labelText: 'Type the note here...',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              Row(
                children: <Widget>[
                  const Icon(Icons.calendar_today),
                  const SizedBox(width: 10),
                  Text('${widget.selectedDate.day}/${widget.selectedDate.month}/${widget.selectedDate.year}'),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: <Widget>[
                  const Icon(Icons.access_time),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () async {
                      TimeOfDay? selectedTime = await showTimePicker(
                        context: context,
                        initialTime: _startTime,
                      );
                      if (selectedTime != null) {
                        setState(() {
                          _startTime = selectedTime;
                        });
                      }
                    },
                    child: Text('Start time: ${_startTime.format(context)}'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () async {
                      TimeOfDay? selectedTime = await showTimePicker(
                        context: context,
                        initialTime: _endTime,
                      );
                      if (selectedTime != null) {
                        setState(() {
                          _endTime = selectedTime;
                        });
                      }
                    },
                    child: Text('End time: ${_endTime.format(context)}'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: <Widget>[
                  const Text('Reminds me'),
                  const SizedBox(width: 10),
                  Switch(
                    value: _remindsMe,
                    onChanged: (value) {
                      setState(() {
                        _remindsMe = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text('Select Category'),
              Row(
                children: <Widget>[
                  ChoiceChip(
                    label: const Text('Brainstorm'),
                    selected: _selectedCategory == 'Brainstorm',
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = selected ? 'Brainstorm' : null;
                      });
                    },
                  ),
                  const SizedBox(width: 10),
                  ChoiceChip(
                    label: const Text('Design'),
                    selected: _selectedCategory == 'Design',
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = selected ? 'Design' : null;
                      });
                    },
                  ),
                  const SizedBox(width: 10),
                  ChoiceChip(
                    label: const Text('Workout'),
                    selected: _selectedCategory == 'Workout',
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = selected ? 'Workout' : null;
                      });
                    },
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Implement add new category
                    },
                    child: const Text('+ Add new'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Create event
                    final newEvent = Event(
                      name: _eventNameController.text,
                      note: _noteController.text,
                      date: widget.selectedDate,
                      startTime: _startTime,
                      endTime: _endTime,
                      remindsMe: _remindsMe,
                      category: _selectedCategory,
                    );
                    // Pass event back to CalendarScreen
                    widget.onEventAdded(newEvent);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Create Event'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
