import TestGame.Metadata
import Std.Tactic.RCases
import Mathlib.Tactic.LeftRight

set_option tactic.hygienic false

Game "TestGame"
World "Proposition"
Level 14

Title "Zusammenfassung"

Introduction
"
Damit bist du am Ende der ersten Lektion angekommen. Hier ein Überblick über alle Begriffe,
Notationen, und Taktiken, die in diesem Kapitel
eingeführt wurden. Danach folgt eine Abschlussaufgabe.

## Notationen / Begriffe

|               | Beschreibung                                                             |
|:--------------|:-------------------------------------------------------------------------|
| *Goal*        | Was aktuell zu beweisen ist.                                             |
| *Annahme*     | Objekte & Resultate, die man zur Verfügung hat.                          |
| *Taktik*      | Befehl im Beweis. Entspricht einem Beweisschritt.                        |
| `ℕ`           | Typ aller natürlichen Zahlen.                                            |
| `0, 1, 2, …`  | Explizite natürliche Zahlen.                                             |
| `=`           | Gleichheit.                                                              |
| `≠`           | Ungleichheit. Abkürzung für `¬(·=·)`.                                    |
| `Prop`        | Typ aller logischen Aussagen.                                            |
| `True`        | Die logische Aussage `(True : Prop)` ist bedingungslos wahr.             |
| `False`       | Die logische Aussage `(False : Prop)` ist bedingungslos falsch.          |
| `¬`           | Logische Negierung.                                                      |
| `∧`           | Logisch UND.                                                             |
| `∨`           | Logisch ODER.                                                            |
| `(n : ℕ)`     | Eine natürliche Zahl.                                                    |
| `(A : Prop)`  | Eine logische Aussage.                                                   |
| `(ha : A)`    | Ein Beweis, dass die logische Aussage `(A : Prop)` wahr ist.             |
| `(h : A ∧ B)` | Eine Annahme, die den Namen `h` bekommen hat.                            |
| `⟨·,·⟩`       | Schreibweise für Struktur mit mehreren Feldern (kommt später im Detail). |
| `h.1, h.2, …` | Die einzelnen Felder der Stuktur. Auch `h.[Name des Feldes]`             |


Im weiteren haben wir gesehen, wie wir in Lean Aufgaben formulieren :

```
example [Annahmen] : [Aussage] := by
  [Beweis]
```

## Taktiken

Für die Beweise haben wir verschiedene Taktiken kennengelernt.

|    | Taktik                    | Beispiel                                          |
|:---|:--------------------------|:--------------------------------------------------|
| 1  | `rfl`                     | Beweist `A = A`.                                  |
| 2  | `assumption`              | Sucht das Goal in den Annahmen.                   |
| 3  | `contradiction`           | Sucht einen Widerspruch.                          |
| 4  | `trivial`                 | Kombiniert die obigen drei Taktiken (und mehr).   |
| 5  | `constructor`             | Teilt ein UND im Goal auf.                        |
| 6  | `left`/`right`            | Beweist eine Seite eines ODER im Goal.            |
| 7ᵃ | `rcases h with ⟨h₁, h₂⟩`  | Teilt ein UND in den Annahmen auf.                |
| 7ᵇ | `rcases h with h \\| h`   | Teilt ein ODER in den Annahmen in zwei Fälle auf. |


Zum Schluss gibt es noch eine kleine Übungsaufgabe:

Benutze alle vier Methoden mit UND und ODER
umzugehen um folgende Aussage zu beweisen.

| (Übersicht) | Und (`∧`)                | Oder (`∨`)              |
|-------------|:-------------------------|:------------------------|
| Annahme     | `rcases h with ⟨h₁, h₂⟩` | `rcases h with h \\| h` |
| Goal        | `constructor`            | `left`/`right`          |
"

-- Note: The other direction would need arguing by cases.

Statement
"Angenommen $A \\lor (B \\land C)$ ist wahr, zeige dass
$(A \\lor B) \\land (A \\lor C)$ wahr ist."
    (A B C : Prop) (h : A ∨ (B ∧ C)) : (A ∨ B) ∧ (A ∨ C) := by
  constructor
  rcases h with h | h
  left
  assumption
  rcases h with ⟨h₁, h₂⟩
  right
  assumption
  rcases h with h | h
  left
  assumption
  rcases h with ⟨h₁, h₂⟩
  right
  assumption

HiddenHint (A : Prop) (B : Prop) (C : Prop) (h : B ∧ C) : (A ∨ B) ∧ (A ∨ C) =>
"Das `∧` in der Annahme kann mit `rcases h with ⟨h₁, h₂⟩` zerlegt werden."

HiddenHint (A : Prop) (B : Prop) (C : Prop) : (A ∨ B) ∧ (A ∨ C) =>
"Das `∧` im Goal kann mit `constructor` zerlegt werden."

HiddenHint (A : Prop) (B : Prop) (C : Prop) (h : A ∨ (B ∧ C)) : (A ∨ B) ∧ (A ∨ C) =>
"Das `∨` in der Annahme kann mit `rcases h with h | h` zerlegt werden."

HiddenHint (A : Prop) (B : Prop) (C : Prop) (h : A ∨ (B ∧ C)) : (A ∨ B) =>
"Das `∨` in der Annahme kann mit `rcases h with h | h` zerlegt werden."

HiddenHint (A : Prop) (B : Prop) (C : Prop) (h : A ∨ (B ∧ C)) : (A ∨ C) =>
"Das `∨` in der Annahme kann mit `rcases h with h | h` zerlegt werden."


HiddenHint (A : Prop) (B : Prop) (C : Prop) (h : B ∧ C) : (A ∨ B) =>
"Das `∧` in der Annahme kann mit `rcases h with ⟨h₁, h₂⟩` zerlegt werden."

HiddenHint (A : Prop) (B : Prop) (C : Prop) (h : B ∧ C) : (A ∨ C) =>
"Das `∧` in der Annahme kann mit `rcases h with ⟨h₁, h₂⟩` zerlegt werden."

-- TODO: Hint nur Anhand der Annahmen?

HiddenHint (A : Prop) (B : Prop) : A ∨ B =>
"`left` oder `right`?"

NewTactics left right assumption constructor rcases rfl contradiction trivial
DisabledTactics tauto
