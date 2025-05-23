import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studytools/control/0.dbcontroller.dart';
import 'package:studytools/control/2.pomodoro/2.audio_controller.dart';

class AudioSection extends StatelessWidget {
  const AudioSection({super.key});

  @override
  Widget build(BuildContext context) {
    final DbController controller = Get.find();
    final AudioController audioController = Get.put(AudioController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildVolumeSlider(
          icon: Icons.access_time,
          label: 'Ticking Volume',
          getValue: () => controller.pomodoroSettings[0]['ticking_volume'],
          onChanged: (volume) {
            controller.updateTickingVolume(volume);
            audioController.tickPlayer.setVolume(volume);
          },
        ),
        const SizedBox(height: 20),
        _buildVolumeSlider(
          icon: Icons.notifications,
          label: 'Ringing Volume',
          getValue: () => controller.pomodoroSettings[0]['ringing_volume'],
          onChanged: (volume) {
            controller.updateRingingVolume(volume);
            audioController.ringPlayer.setVolume(volume);
          },
        ),
      ],
    );
  }

  Widget _buildVolumeSlider({
    required IconData icon,
    required String label,
    required double Function() getValue,
    required ValueChanged<double> onChanged,
  }) {
    return Obx(() {
      final value = getValue();
      return Row(
        children: [
          Icon(icon, color: Colors.white70),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: 150,
            child: Slider(
              value: value,
              min: 0,
              max: 1,
              divisions: 10,
              label: "${(value * 100).toInt()}%",
              activeColor: Colors.tealAccent,
              inactiveColor: Colors.teal.shade100,
              thumbColor: Colors.teal,
              onChanged: onChanged,
            ),
          ),
        ],
      );
    });
  }
}
