import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/chunky_colors.dart';
import '../widgets/chunky_card.dart';
import '../widgets/chunky_button.dart';
import '../models/activity.dart';
import '../providers/app_state.dart';

class NewQuestScreen extends StatefulWidget {
  final AppState state;
  final VoidCallback onCancel;

  const NewQuestScreen({
    super.key,
    required this.state,
    required this.onCancel,
  });

  @override
  State<NewQuestScreen> createState() => _NewQuestScreenState();
}

class _NewQuestScreenState extends State<NewQuestScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _notesController = TextEditingController();

  String _selectedCategory = 'HEALTH';
  TimeOfDay _selectedTime = const TimeOfDay(hour: 8, minute: 0);
  int _xpReward = 150;

  @override
  void dispose() {
    _nameController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _selectTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: ChunkyColors.primary,
              onPrimary: ChunkyColors.onSurface,
              surface: ChunkyColors.onSurface,
              onSurface: ChunkyColors.onSurface,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _saveQuest() {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: ChunkyColors.errorRed,
          content: Text('Please enter a quest name!', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      );
      return;
    }

    final hourStr = _selectedTime.hour.toString().padLeft(2, '0');
    final minStr = _selectedTime.minute.toString().padLeft(2, '0');

    final newAct = Activity(
      id: 'act_${DateTime.now().millisecondsSinceEpoch}',
      name: _nameController.text.trim(),
      category: _selectedCategory,
      time: '$hourStr:$minStr',
      repeatPattern: 'daily',
      xpReward: _xpReward,
      notes: _notesController.text.trim(),
      createdAt: DateTime.now(),
    );

    widget.state.addActivity(newAct);
    widget.onCancel(); // navigate back
  }

  @override
  Widget build(BuildContext context) {
    final y = DateTime.now().year.toString().padLeft(4, '0');
    final m = DateTime.now().month.toString().padLeft(2, '0');
    final d = DateTime.now().day.toString().padLeft(2, '0');
    final todayStr = '$y-$m-$d';

    return Scaffold(
      backgroundColor: ChunkyColors.background,
      appBar: AppBar(
        backgroundColor: ChunkyColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: ChunkyColors.primary, size: 28.0),
          onPressed: widget.onCancel,
        ),
        title: Text(
          'NEW QUEST',
          style: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.w800,
            fontSize: 20.0,
            color: ChunkyColors.onSurface,
            letterSpacing: 1.0,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              width: 38.0,
              height: 38.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: ChunkyColors.primary, width: 2.0),
                image: const DecorationImage(
                  image: NetworkImage(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuAAcPH8KsDjc80EHZXxfve3z1KCmHRKxbYDvvIWLNcPQWckU71u_7Nv8pGRqfGdi8yrPI0QjgDNDIpMZ44UrUr8qbRjdBlJSflltrW6lNLto9VxscxEInwzfCJUFjYogG-hfXfmm4TJGLBxOWS4z0f1Q32MptONBYsEGlFyD7p9_sCuocJ5VPmeib8Ov5btE9btVZejSJjD1WJrlpKammtOKRhjVbB5wGmO0xzZuTfW13DYelg5FSLeaKLFxHIYjquBiirwqhZGLJQL',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: ChunkyColors.surfaceContainerHighest,
            height: 4.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Quest Name
              Padding(
                padding: const EdgeInsets.only(left: 4.0, bottom: 8.0),
                child: Text(
                  'QUEST NAME',
                  style: TextStyle(
                    fontFamily: 'BeVietnamPro',
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    color: ChunkyColors.onSurfaceVariant,
                  ),
                ),
              ),
              ChunkyCard(
                padding: EdgeInsets.zero,
                borderColor: ChunkyColors.darkBorder,
                shadowHeight: 4,
                child: TextField(
                  controller: _nameController,
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Ex: Slay the Dragon Gym',
                    hintStyle: TextStyle(color: ChunkyColors.outlineVariant),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  ),
                ),
              ),
              const SizedBox(height: 24.0),

              // Category Selector
              Padding(
                padding: const EdgeInsets.only(left: 4.0, bottom: 8.0),
                child: Text(
                  'CATEGORY',
                  style: TextStyle(
                    fontFamily: 'BeVietnamPro',
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    color: ChunkyColors.onSurfaceVariant,
                  ),
                ),
              ),
              Wrap(
                spacing: 10.0,
                runSpacing: 10.0,
                children: [
                  _buildCategoryChip('HEALTH', Icons.favorite, ChunkyColors.errorRed),
                  _buildCategoryChip('WORK', Icons.work, ChunkyColors.primary),
                  _buildCategoryChip('SOCIAL', Icons.group, ChunkyColors.onSurface),
                  _buildCategoryChip('MIND', Icons.auto_awesome, ChunkyColors.primary),
                ],
              ),
              const SizedBox(height: 24.0),

              // Bento Grid for Reminder and XP Reward
              Row(
                children: [
                  // Reminder Time Picker
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0, bottom: 8.0),
                          child: Text(
                            'REMINDER',
                            style: TextStyle(
                              fontFamily: 'BeVietnamPro',
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                              color: ChunkyColors.onSurfaceVariant,
                            ),
                          ),
                        ),
                        ChunkyCard(
                          onTap: _selectTime,
                          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
                          child: Row(
                            children: [
                              const Icon(Icons.schedule, color: ChunkyColors.onSurfaceVariant),
                              const SizedBox(width: 8.0),
                              Text(
                                _selectedTime.format(context),
                                style: const TextStyle(
                                  fontFamily: 'BeVietnamPro',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16.0),

                  // XP Reward difficulty
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0, bottom: 8.0),
                          child: Text(
                            'XP REWARD',
                            style: TextStyle(
                              fontFamily: 'BeVietnamPro',
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                              color: ChunkyColors.onSurfaceVariant,
                            ),
                          ),
                        ),
                        ChunkyCard(
                          onTap: () {
                            setState(() {
                              _xpReward = _xpReward == 100 ? 150 : (_xpReward == 150 ? 200 : 100);
                            });
                          },
                          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.stars, color: ChunkyColors.onSurface),
                              const SizedBox(width: 8.0),
                              Text(
                                '$_xpReward XP',
                                style: GoogleFonts.plusJakartaSans(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 15.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24.0),

              // Tactical notes
              Padding(
                padding: const EdgeInsets.only(left: 4.0, bottom: 8.0),
                child: Text(
                  'QUEST LOG NOTES',
                  style: TextStyle(
                    fontFamily: 'BeVietnamPro',
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    color: ChunkyColors.onSurfaceVariant,
                  ),
                ),
              ),
              ChunkyCard(
                padding: EdgeInsets.zero,
                child: TextField(
                  controller: _notesController,
                  maxLines: 3,
                  style: const TextStyle(fontFamily: 'BeVietnamPro', fontSize: 14.0),
                  decoration: const InputDecoration(
                    hintText: 'Add some tactical advice for your future self...',
                    hintStyle: TextStyle(color: ChunkyColors.outlineVariant),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16.0),
                  ),
                ),
              ),
              const SizedBox(height: 24.0),

              // Illustration box
              Container(
                height: 120.0,
                decoration: BoxDecoration(
                  color: ChunkyColors.primaryContainer.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: ChunkyColors.primary,
                    width: 2.0,
                    style: BorderStyle.solid,
                  ),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.compress, color: ChunkyColors.primary, size: 36.0),
                    SizedBox(height: 8.0),
                    Text(
                      'Complete this quest to expand your territory!',
                      style: TextStyle(
                        fontFamily: 'BeVietnamPro',
                        fontWeight: FontWeight.bold,
                        color: ChunkyColors.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32.0),

              // Create Activity Button
              ChunkyButton(
                backgroundColor: ChunkyColors.primaryContainer,
                shadowColor: ChunkyColors.primary,
                onTap: _saveQuest,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_circle, color: ChunkyColors.onSurface),
                    SizedBox(width: 8.0),
                    Text(
                      'CREATE QUEST',
                      style: TextStyle(
                        fontFamily: 'BeVietnamPro',
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: ChunkyColors.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String cat, IconData icon, Color color) {
    final isSelected = _selectedCategory == cat;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = cat;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: isSelected ? ChunkyColors.onSurface : ChunkyColors.surfaceCard,
          borderRadius: BorderRadius.circular(24.0),
          border: Border.all(
            color: isSelected ? color : ChunkyColors.outline,
            width: 2.0,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color,
                    offset: const Offset(0, 4),
                    blurRadius: 0,
                    spreadRadius: 0,
                  ),
                ]
              : [
                  const BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 4),
                    blurRadius: 0,
                    spreadRadius: 0,
                  ),
                ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? color : ChunkyColors.onSurfaceVariant,
              size: 18.0,
            ),
            const SizedBox(width: 8.0),
            Text(
              cat,
              style: TextStyle(
                fontFamily: 'BeVietnamPro',
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
                color: isSelected ? color : ChunkyColors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
