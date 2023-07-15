import 'package:app/common/custom_button.dart';
import 'package:app/screens/patients/patients_files_search/models/patient_model.dart';
import 'package:app/screens/patients/patients_files_search/view/patients_files_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:search_page/search_page.dart';

SizedBox getVerticalSpacerWidget(context) => SizedBox(
      height: MediaQuery.of(context).size.height * 0.04,
    );

SearchPage<Patient> getSearchPage(WidgetRef ref, context, items) =>
    SearchPage<Patient>(
      items: items,
      searchLabel: 'Search people',
      searchStyle: const TextStyle(color: Colors.white),
      barTheme: Theme.of(context).copyWith(
        appBarTheme: const AppBarTheme(backgroundColor: Colors.indigo),
        inputDecorationTheme: const InputDecorationTheme(
          focusedErrorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          border: InputBorder.none,
        ),
      ),
      suggestion: const Center(
        child: Text('Filter people by name, surname or ID'),
      ),
      failure: const Center(
        child: Text('No person found :('),
      ),
      filter: (patient) => [
        patient.nameEN,
        patient.nameAR,
        patient.uid.toString(),
      ],
      builder: (patient) => PatientCard(
        patient: patient,
      ),
    );

double getWidgetWidth(double fullWidth, CustomWidth customWidth) {
  switch (customWidth) {
    case CustomWidth.oneThird:
      return fullWidth * 0.33;
    case CustomWidth.twoThird:
      return fullWidth * 0.66;
    case CustomWidth.half:
      return fullWidth * 0.50;
    case CustomWidth.matchParent:
      return fullWidth;
    default:
      return fullWidth;
  }
}

Widget getVerticalSpacerLine(double fullWidth, CustomWidth customWidth,
        Color color, double padding) =>
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        // padding: EdgeInsets.all( padding),
        height: 3,
        width: getWidgetWidth(fullWidth, customWidth),
        color: color,
      ),
    );
