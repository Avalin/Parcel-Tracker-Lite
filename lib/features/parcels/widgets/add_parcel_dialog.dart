import 'package:flutter/material.dart';

class AddParcelDialog extends StatefulWidget {
  const AddParcelDialog({
    super.key,
    required this.onAddParcel,
  });

  final Future<String?> Function({
    required String trackingNumber,
    required int postcode,
  }) onAddParcel;

  @override
  State<AddParcelDialog> createState() => _AddParcelDialogState();
}

class _AddParcelDialogState extends State<AddParcelDialog> {
  late final TextEditingController _trackingController;
  late final TextEditingController _postcodeController;

  @override
  void initState() {
    super.initState();
    _trackingController = TextEditingController();
    _postcodeController = TextEditingController();
  }

  @override
  void dispose() {
    _trackingController.dispose();
    _postcodeController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final postcode = int.tryParse(_postcodeController.text.trim());

    if (postcode == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Postnummer skal være et gyldigt tal.'),
        ),
      );
      return;
    }

    final errorMessage = await widget.onAddParcel(
      trackingNumber: _trackingController.text.trim(),
      postcode: postcode,
    );

    if (!mounted) return;

    Navigator.of(context).pop();

    if (errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Tilføj pakke'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _trackingController,
            decoration: const InputDecoration(
              labelText: 'Trackingnummer',
              hintText: 'Fx ABC123456789',
            ),
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _postcodeController,
            decoration: const InputDecoration(
              labelText: 'Postnummer',
              hintText: 'Fx 8500',
            ),
            keyboardType: TextInputType.number,
            onSubmitted: (_) => _submit(),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Annuller'),
        ),
        FilledButton(
          onPressed: _submit,
          child: const Text('Tilføj'),
        ),
      ],
    );
  }
}