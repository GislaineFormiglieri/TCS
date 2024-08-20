import 'package:flutter/material.dart';

class CPFMask extends StatefulWidget {
  final TextEditingController controller;

  CPFMask({required this.controller});

  @override
  _CPFMaskState createState() => _CPFMaskState();
}

class _CPFMaskState extends State<CPFMask> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_formatCPF);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_formatCPF);
    super.dispose();
  }

  void _formatCPF() {
    String text = widget.controller.text;
    String formatted = _applyCPFFormat(text);
    if (formatted != text) {
      widget.controller
        ..text = formatted
        ..selection = TextSelection.collapsed(offset: formatted.length);
    }
  }

  String _applyCPFFormat(String value) {
    value = value.replaceAll(RegExp(r'\D'), ''); // Remove non-numeric characters
    if (value.length > 9) {
      value = value.substring(0, 9) + '-' + value.substring(9);
    }
    if (value.length > 6) {
      value = value.substring(0, 6) + '.' + value.substring(6);
    }
    if (value.length > 3) {
      value = value.substring(0, 3) + '.' + value.substring(3);
    }
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextField(
        controller: widget.controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: 'CPF',
          border: OutlineInputBorder(),
          counterText: '',
        ),
      ),
      );
  }
}
