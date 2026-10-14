# Windows 11 Context Menu Switcher

A tiny `.bat` script to switch between the **classic** (Windows 10-style) and the **Windows 11** right-click context menu.

No installation. No dependencies. Fully reversible.

![Screenshot](screenshot.png)

## What it does

Windows 11 ships with a redesigned context menu that hides many useful entries behind "Show more options". This script toggles that behavior by writing (or deleting) a single registry key under `HKCU`:

```
HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32
```

- **Option 1 – Windows 11 context menu** — removes the key, restoring the default Windows 11 menu.
- **Option 2 – Classic context menu** — creates the key, bringing back the Windows 10-style menu.

After applying a change, the script restarts `explorer.exe` so the new menu takes effect immediately.

## Requirements

- Windows 11
- No administrator rights needed (changes affect the current user only)

## Usage

1. Download `Classic-Right-Click-Color.bat`.
2. Double-click it.
3. Choose an option from the menu:
   - `1` — Windows 11 context menu
   - `2` — Classic context menu
   - `3` — Exit

That's it. The window closes automatically after a successful change.

## Notes & warnings

- **Registry modification.** The script only touches `HKCU` (current user). It does not affect other users or the system-wide configuration.
- **Explorer restart.** `explorer.exe` is killed and restarted. This briefly hides the taskbar and closes all open File Explorer windows. Unsaved work in other apps is not affected.
- **Unofficial method.** Microsoft may change or remove this behavior in a future Windows update. If the script stops working, the key will simply have no effect.
- **Antivirus warnings.** Some antivirus tools flag `.bat` files that modify the registry. This is expected — the script is short and you can read every line.
- **Reversible.** Running option `1` returns your system to the default Windows 11 state.

## How to revert manually

If you'd rather undo the change by hand:

1. Press `Win + R`, type `regedit`, press Enter.
2. Navigate to:
   ```
   HKEY_CURRENT_USER\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}
   ```
3. Delete the whole `{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}` key.
4. Restart Explorer (or sign out and back in).

## License

MIT — see [LICENSE](LICENSE).

---

## Русская версия

Небольшой `.bat`-скрипт для переключения между **классическим** контекстным меню (как в Windows 10) и **меню Windows 11**.

Без установки, без зависимостей, полностью обратимо.

### Что делает

- **Пункт 1 — меню Windows 11** — удаляет ключ реестра, возвращая стандартное меню Windows 11.
- **Пункт 2 — классическое меню** — создаёт ключ, возвращая меню в стиле Windows 10.

После изменения скрипт перезапускает `explorer.exe`, чтобы настройка применилась сразу.

### Использование

1. Скачай `Classic-Right-Click-Color.bat`.
2. Запусти двойным кликом.
3. Выбери пункт:
   - `1` — меню Windows 11
   - `2` — классическое меню
   - `3` — выход

### Предупреждения

- Меняется только ветка `HKCU` — то есть только для текущего пользователя.
- `explorer.exe` перезапускается: панель задач на пару секунд исчезает, открытые окна Проводника закрываются.
- Метод неофициальный: Microsoft может сломать его в будущем обновлении.
- Антивирусы иногда ругаются на `.bat`, который лезет в реестр, — это нормально.
