import 'package:flutter/material.dart';
import 'package:gomate/backend/database.dart';
import 'package:gomate/misc/disability.dart';
import 'package:gomate/misc/journey.dart';
import 'package:gomate/misc/values.dart';
import 'package:gomate/pages/page_content.dart';
import 'package:gomate/widgets/cards/content_card.dart';
import 'package:gomate/widgets/other/auto_image.dart';
import 'package:gomate/widgets/other/form_fields.dart';
import 'package:uuid/v4.dart';

class AddMissingPage extends StatefulWidget {
  const AddMissingPage({super.key});

  @override
  State<AddMissingPage> createState() => _AddMissingPageState();
}

class _AddMissingPageState extends State<AddMissingPage> {
  String image = "";
  String name = "";
  String location = "";
  String description = "";
  JourneyType journeyType = JourneyType.accommodation;
  // Temporary ugly hack
  Map<String, Set<Disability>> disabilitiesAccountStaging = {
    "disabilities": {}
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add missing"),
        actions: [
          TextButton(
              onPressed: () {
                addJourney(
                    const UuidV4().generate(),
                    Journey(
                        type: journeyType,
                        name: name,
                        image: image,
                        description: description,
                        location: location,
                        incompatibleDisabilities: disabilitiesAccountStaging[
                            "disabilities"]! // Temporary ugly hack
                        ));
                Navigator.pop(context);
              },
              child: const Text("Save"))
        ],
      ),
      body: PageContent(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Flexible(flex: 2, child: SizedBox()),
              Flexible(
                  flex: 9,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ContentCard(
                        height: 200,
                        child: Stack(
                          children: [
                            AutoImage(
                              image: image,
                            ),
                            Align(
                                alignment: Alignment.bottomRight,
                                child: Padding(
                                  padding: comfortable,
                                  child: IconButton.filledTonal(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) => SimpleDialog(
                                                  title:
                                                      Text("Enter image URL"),
                                                  contentPadding: comfortableCardInset,
                                                  children: [
                                                    TextFormField(
                                                        decoration:
                                                            const InputDecoration(
                                                                hintText: "URL",
                                                                border:
                                                                    OutlineInputBorder()),
                                                        initialValue: image,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            image = value;
                                                          });
                                                        }),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
                                                                "Confirm"))
                                                      ],
                                                    )
                                                  ].spacedOut(by: 8),
                                                ));
                                      },
                                      icon: const Icon(Icons.edit)),
                                ))
                          ],
                        ),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), hintText: "Name"),
                        initialValue: "",
                        onChanged: (value) => setState(() {
                          name = value;
                        }),
                      ),
                      TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Location"),
                          initialValue: "",
                          onChanged: (value) {
                            setState(() {
                              location = value;
                            });
                          }),
                      TextFormField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Description"),
                        initialValue: "",
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        onChanged: (value) {
                          setState(() {
                            description = value;
                          });
                        },
                      ),
                      DropdownButtonFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Experience type"),
                          items: [
                            for (final journeyType in JourneyType.values)
                              DropdownMenuItem(
                                  value: journeyType,
                                  child: Text(journeyType.toString()))
                          ],
                          onChanged: (newJourneyType) {
                            setState(() {
                              journeyType =
                                  newJourneyType ?? JourneyType.accommodation;
                            });
                          }),
                      Row(
                        children: [
                          const Icon(Icons.warning_rounded),
                          const Text("Incompatible with")
                        ].spacedOut(by: 3, direction: Axis.horizontal),
                      ),
                      DisabilitiesField(
                          accountStaging: disabilitiesAccountStaging)
                    ].spacedOut(by: 8),
                  )),
              const Flexible(flex: 2, child: SizedBox())
            ],
          )
        ],
      ),
    );
  }
}
