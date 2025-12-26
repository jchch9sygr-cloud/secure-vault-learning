# Secure Vault

Dieses Projekt ist ein Lernprojekt zur Entwicklung eines sicheren Ethereum Smart Contracts.
Der Fokus liegt nicht auf vielen Features, sondern auf **korrekten Regeln, Sicherheit und Tests als Beweise**.

---

## 🧠 Idee des Projekts

Der Vault ist eine **digitale Sparbüchse**:

- Jeder Nutzer kann ETH einzahlen
- Jeder Nutzer kann **nur sein eigenes Guthaben** abheben
- Guthaben werden pro Adresse getrennt gespeichert
- Der Contract schützt sich gegen typische Angriffe (z. B. Reentrancy)

Ziel ist es zu zeigen, wie man **Geldregeln ohne Vertrauen** korrekt umsetzt.

---

## 🔒 Zentrale Regeln

1. Jeder Nutzer besitzt nur sein eigenes Guthaben  
2. Niemand kann mehr ETH abheben, als er eingezahlt hat  
3. Der Contract-Zustand muss immer konsistent bleiben  
4. Withdraw folgt strikt dem Checks-Effects-Interactions-Prinzip  
5. Ungültige Aktionen werden vollständig reverted  

---

## 🧱 Architektur

- Guthaben werden über ein `mapping(address => uint256)` gespeichert  
- `deposit` bucht ETH dem Einzahler gut  
- `withdraw`:
  - prüft Bedingungen
  - aktualisiert zuerst den State
  - sendet danach ETH  

Der Contract ist bewusst minimal gehalten, um Sicherheit klar nachvollziehbar zu machen.

---

## 🛡️ Sicherheit

### Reentrancy
Der Vault ist gegen Reentrancy geschützt, da:
- der State **vor** dem ETH-Versand aktualisiert wird
- ein Angreifer bei erneutem `withdraw` kein Guthaben mehr besitzt

Ein Reentrancy-Angriff wird explizit in den Tests simuliert und scheitert.

---

## 🧪 Tests

Tests werden mit **Foundry** geschrieben und lokal ausgeführt.

Die Tests sind keine Funktionschecks, sondern **Beweise für Regeln**, u. a.:

- Einzahlung erhöht nur das eigene Guthaben
- Ein Nutzer beeinflusst keine anderen Nutzer
- Withdraw reduziert Guthaben und sendet ETH
- Ungültige Withdraws revertieren
- Reentrancy-Angriff schlägt fehl

Tests werden mit `forge test` ausgeführt.

---

## 🛠️ Tooling

- Solidity ^0.8.x
- Foundry (forge)
- GitHub zur Versionskontrolle

Tests laufen **lokal**, nicht auf GitHub.

---

## 🎯 Lernziel

Dieses Projekt dient dazu, den Zusammenhang zu verstehen zwischen:

**Problem → Regel → Code → Test → Sicherheit**

Nicht Geschwindigkeit oder Feature-Anzahl stehen im Fokus,
sondern **sauberes Denken und überprüfbare Sicherheit**.

---

## ⚠️ Hinweis

Dieses Projekt ist ein Lernprojekt und **nicht für den produktiven Einsatz** gedacht.
