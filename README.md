SE Laboratory 2 — Refactoring

Course: Software Engineering  
Lab: SE5 Lab 2 — Refactoring  
Author: Cloey 
Date: September 30, 2026

What this repo contains

A focused refactor of `_getAppointmentsForDay`, extracted from a Flutter thesis project. The refactor replaces a `try/catch` around `DateTime.parse` with `DateTime.tryParse`, and lifts a three-field calendar comparison into a named predicate.

## Target

File: `lib/views/screens/appointments_screen.dart` (adjust to your real path)
Function: `_getAppointmentsForDay`
Baseline commit: `<paste your pre-refactor SHA>`
Refactor branch: `refactor/appointments-same-day`

## The problem

`_getAppointmentsForDay` packed three unnamed responsibilities into one expression:

1. Parsing `appointment.date` from a string
2. Comparing calendar days via three separate field checks
3. Swallowing every parse failure with `catch (e) { return false; }`

A malformed date was indistinguishable from "different day" — both returned `false`, so a data bug was invisible.

## The change

Extracted two helpers:

- `_tryParseDate(String raw)` — uses `DateTime.tryParse`, returns `null` on invalid input
- `_isSameCalendarDay(DateTime a, DateTime b)` — the same three-field comparison, named

The filter body now reads as one sentence: parse, then keep if same day.

## Evidence of unchanged behavior

Run:

```bash
flutter test test/get_appointments_for_day_test.dart
