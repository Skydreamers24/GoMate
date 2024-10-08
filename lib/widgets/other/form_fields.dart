import 'package:flutter/material.dart';
import 'package:gomate/misc/gender.dart';
import 'package:date_field/date_field.dart';

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Flexible(flex: 2, child: SizedBox()),
        Flexible(
            flex: 9,
            child: TextFormField(
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
            )),
        const Flexible(flex: 2, child: SizedBox())
      ],
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Flexible(flex: 2, child: SizedBox()),
        Flexible(
            flex: 9,
            child: DropdownButtonFormField(
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
            )),
        const Flexible(flex: 2, child: SizedBox())
      ],
    );
  }
}

class EditDateOfBirthRow extends StatelessWidget {
  const EditDateOfBirthRow({super.key, required this.accountStaging});
  final AccountStaging accountStaging;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Flexible(flex: 2, child: SizedBox()),
        Flexible(
          flex: 9,
          child: DateTimeFormField(
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
          ),
        ),
        const Flexible(flex: 2, child: SizedBox()),
      ],
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Flexible(flex: 2, child: SizedBox()),
        Flexible(
            flex: 9,
            child: TextFormField(
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
            )),
        const Flexible(flex: 2, child: SizedBox())
      ],
    );
  }
}
