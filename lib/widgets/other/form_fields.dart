import 'package:flutter/material.dart';
import 'package:gomate/backend/account.dart';
import 'package:gomate/misc/disability.dart';
import 'package:gomate/misc/gender.dart';
import 'package:date_field/date_field.dart';
import 'package:gomate/misc/values.dart';
import 'package:gomate/widgets/cards/content_card.dart';

typedef AccountStaging = Map<String, dynamic>;

class TextFormFieldRow extends StatelessWidget {
  final String labelText;
  final bool autocorrect;
  final String? Function(String?)?
      validator; // Given an inputted value, return the error string or null
  final AccountStaging accountStaging;
  final String valueToChange;
  const TextFormFieldRow({
    super.key,
    required this.labelText,
    required this.accountStaging,
    required this.valueToChange,
    this.autocorrect = true,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: accountStaging[valueToChange],
      autocorrect: autocorrect,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText,
      ),
      onChanged: (newValue) {
        accountStaging[valueToChange] = newValue;
      },
      validator: validator,
    );
  }
}

class EditGenderRow extends StatelessWidget {
  const EditGenderRow({
    super.key,
    required this.accountStaging,
  });

  final AccountStaging accountStaging;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Gender",
      ),
      items: Gender.values
          .map((gender) => DropdownMenuItem(
                value: gender,
                child: Text(gender.toString()),
              ))
          .toList(),
      style: Theme.of(context).textTheme.bodyLarge,
      value: accountStaging["gender"],
      onChanged: (value) {
        accountStaging["gender"] = value ?? Gender.male;
      },
    );
  }
}

class EditDateOfBirthRow extends StatelessWidget {
  const EditDateOfBirthRow({super.key, required this.accountStaging});
  final AccountStaging accountStaging;

  @override
  Widget build(BuildContext context) {
    return DateTimeFormField(
      initialValue: accountStaging["dateOfBirth"],
      pickerPlatform: DateTimeFieldPickerPlatform.material,
      mode: DateTimeFieldPickerMode.date,
      firstDate: DateTime.parse("1900-01-01"),
      lastDate: DateTime.now(),
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Date of Birth",
      ),
      style: Theme.of(context).textTheme.bodyLarge,
      onChanged: (DateTime? value) {
        accountStaging["dateOfBirth"] = value ?? DateTime.parse("1899-12-31");
      },
    );
  }
}

class PhoneNumberFieldRow extends StatelessWidget {
  final String labelText;
  final String? Function(String?)?
      validator; // Given an inputted value, return the error string or null
  final AccountStaging accountStaging;
  const PhoneNumberFieldRow({
    super.key,
    required this.labelText,
    required this.accountStaging,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.phone,
      initialValue: accountStaging["phoneNo"],
      autocorrect: false,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText,
      ),
      validator: validator,
      onChanged: (newValue) {
        accountStaging["phoneNo"] = newValue;
      },
    );
  }
}

class DisabilitiesField extends StatefulWidget {
  const DisabilitiesField({required this.accountStaging, super.key});

  final AccountStaging accountStaging;

  @override
  State<DisabilitiesField> createState() => _DisabilitiesFieldState();
}

class _DisabilitiesFieldState extends State<DisabilitiesField> {
  @override
  Widget build(BuildContext context) {
    return FormField(
      initialValue: (widget.accountStaging["disabilities"] ?? const {})
          as Set<Disability>,
      onSaved: (disabilities) {
        widget.accountStaging["disabilities"] = disabilities ?? const {};
      },
      builder: (formFieldState) {
        final disabilities = formFieldState.value ?? const <Disability>{};
        final unaddedDisabilities =
            Disability.values.toSet().difference(disabilities);
        final menuItemButtons = [
          for (final disability in unaddedDisabilities)
            MenuItemButton(
              leadingIcon: Icon(disability.icon()),
              onPressed: () {
                formFieldState.setState(() {
                  formFieldState.value!.add(disability);
                });
              },
              child: Text(disability.toString()),
            )
        ];
        return ContentCard(
          width: double.infinity,
          child: Padding(
            padding: comfortable,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 80),
              child: Wrap(
                spacing: 3,
                runSpacing: 3,
                children: [
                  for (final disability in disabilities)
                    Chip(
                      avatar: Icon(disability.icon()),
                      label: Text(disability.toString()),
                      onDeleted: () {
                        formFieldState.setState(() {
                          formFieldState.value!.remove(disability);
                        });
                      },
                    ),
                  unaddedDisabilities.isNotEmpty
                      ? MenuAnchor(
                          menuChildren: menuItemButtons,
                          builder: (context, controller, child) => ActionChip(
                            padding: zero,
                            labelPadding: tight,
                            shape: const CircleBorder(),
                            label: const Icon(Icons.add),
                            tooltip: "Add a disability",
                            onPressed: () {
                              controller.isOpen
                                  ? controller.close()
                                  : controller.open();
                            },
                          ),
                        )
                      : nothing
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
