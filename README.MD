# Multi-Project Godot Architecture
This repository serves as a technical proof of concept demonstrating how to scale complex Godot games by decoupling separate systems into entirely independent Godot sub-projects using OS-level symbolic links (symlinks).

The goal of this architecture to enforce code coupling, allow independent testing workflows, and to build well defined systems, which can works on its own and can be seamlessly integrated to a main project.
## Architecture Overview
The system architecture utilizes a unidirectional dependency pipeline:
1. **Independent Sub-Projects:** Individual systems (`System A - Playfield`, `System B - UI`) operate in isolation with their own localized `project.godot` configuration, `tests/` suites, and code domains.
2. **The Main Project:** The main executable configuration. Its `res://` directory is populated by symlinks pointing to the internal engine modules of the sub-projects. Godot treats these directories natively upon compilation.
3. **The Reverse Shared Symlink:** Global resources (UI themes, core shared scripts, fonts) reside in the Master Project and are symlinked _backwards_ into the sub-projects to prevent asset duplication.
## Installation & Setup

To get this example running locally on your machine, follow these steps:
### 1. Clone the Repository

Clone the repository recursively to ensure all structural folders are present:

```Bash
git clone https://github.com/lampmilan/godot_symlink_example.git
cd godot_symlink_example
```

### 2. Generate the Symbolic Links
#### **On Windows (PowerShell or Command Prompt):**

PowerShell
```
# Link Sub-Projects to Main Project
New-Item -ItemType SymbolicLink -Path "{path_to_the_repo}\main\ui_module" -Value "{path_to_the_repo}\ui\ui_module"
New-Item -ItemType SymbolicLink -Path "{path_to_the_repo}\main\playfield_module" -Value "{path_to_the_repo}\playfield\playfield_module"

# Reverse Link Shared Assets back to Sub-Projects
New-Item -ItemType SymbolicLink -Path "{path_to_the_repo}\playfield\shared" -Value "{path_to_the_repo}\main\shared"
New-Item -ItemType SymbolicLink -Path "{path_to_the_repo}\ui\shared" -Value "{path_to_the_repo}\main\shared"
```

Command Prompt
```
:: Link Sub-Projects to Main Project
mklink /D {path_to_the_repo}\main\ui_module {path_to_the_repo}\ui\ui_module
mklink /D {path_to_the_repo}\main\playfield_module {path_to_the_repo}\playfield\playfield_module

:: Reverse Link Shared Assets back to Sub-Projects
mklink /D {path_to_the_repo}\playfield\shared {path_to_the_repo}\main\shared
mklink /D {path_to_the_repo}\ui\shared {path_to_the_repo}\main\shared
```
#### **On Linux / macOS (Terminal):**
```
# Link Sub-Projects to Main Project
ln -s "{path_to_the_repo}/ui/ui_module" "{path_to_the_repo}/main/ui_module"
ln -s "{path_to_the_repo}/playfield/playfield_module" "{path_to_the_repo}/main/playfield_module"

# Reverse Link Shared Assets back to Sub-Projects
ln -s "{path_to_the_repo}/main/shared" "{path_to_the_repo}/playfield/shared"
ln -s "{path_to_the_repo}/main/shared" "{path_to_the_repo}/ui/shared"
```

### 3. Open and Run in Godot

1. Open the **Godot Project Manager**.
2. Import the  `main/project.godot` in Godot.
3. Individually import `playfield/project.godot` or `ui/project.godot` to edit the isolated features or run independent tests.

## Technical Caveats & Best Practices

- **Path Safety:** Make sure all paths within sub-project scripts utilize relative references (`res://playfield_module/...`) rather than relying on root level asset targeting that could break when compiled into the main project.
- **Autoloads & Singletons:** Project settings and Autoload instances do not transfer natively via symlinks because they belong to individual `project.godot` configuration files. If an Autoload is modified or added to the main project, ensure it is manually defined across the relevant sub-projects.
- **Concurrent Editing:** When working with multiple Godot editor instances open simultaneously across sub-projects and the master project, expect the standard "Files have been modified outside Godot" prompt upon switching context window focuses.

## Credits
[Bonsaiheldin - Gold treasure icons 16x16](https://opengameart.org/content/gold-treasure-icons-16x16)
[Antifarea's RPG sprite set 1](https://opengameart.org/content/antifareas-rpg-sprite-set-1-enlarged-w-transparent-background-fixed)
