# hardware_hacking/devices

This directory is for device-specific submodules.
The directory names should be of the form: `(Manufacturer)_(ProductName)_(ProductCode)_v(Version)`.
The submodule repo should reflect that name, but may vary for organizational reasons.
* The manufacturer name should be the brand for which the device is known.
* The product name should be according to the branding on the device itself,
and may include a series name.
However, it should not duplicate the manufacturer name,
even though it commonly appears that way in literature.
If the brand is `GizmoWare`, and the product is `GizmoWare Gizmo`,
then the directory should be named `GizmoWare_Gizmo`, not `GizmoWare_GizmoWare_Gizmo`
* The product code is meant to be the most specific identification code for the product.
  * Sometimes, there is no product code, or it's the same as the name. If so, skip it. 
  * Sometimes, product codes include the version number: `GizmoV4`.
Go ahead and separate them.
If there's one version number in the product code and another hardware version listed, keep both:
`P/N: GizmoV4 HW:1.0` => `GizmoV4_v1.0`
* Version code starts with `v` for readability.
Omit any preamble the manufacturer may include: `VER1.2` => `v1.2`.
  * The version should match any visible product versioning,
found either on the physical device or online.
If there isn't any, skip it.
  * It generally refers to hardware versions,
the design changes that may happen within a product lifecycle and are hidden from the user,
rather than product generations themselves: Pentium vs Pentium 2.
  * Don't include firmware versions.
Firmware is considered variable,
and what's on the box may not match what's in the ROM.
We handle firmware variations at a lower level.

The directory `template` is a template for new device-specific repos.
