# Installing a Boot Loader Selector

Still being investigated. This may require soldering.

Excerpt from the Forlinx [SOM](../SOM.md) manual, covering connector pinouts:

| Num. | Ball | Signal     | GPIO         | Vol  | Spec.                 | Function              |
| ------- | ---- | ---------- | ------------ | ---- | --------------------- | --------------------- |
| L_66    | UI0  | BOOT_MODE1 | Gpio5.IO[11] | 3.3V | Booting mode select 1 | SHIFT_SHCP BOOT_MODE1 |
| L_68    | T10  | BOOT_MODE0 | Gpio5.IO[10] | 3.3V | Booting mode select 1 | SHIFT_SDI BOOT_MODE0  |

