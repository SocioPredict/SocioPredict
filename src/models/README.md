## Model Organization

**Convention 7652196C-216A-4CE5-9119-BB59169A767F**

Functions that simply extract data from models belong in the models directory.

Example: A function returning PublicUser data should live in `models/users/`.

Model-specific packages get their own subdirectory (e.g., `usermodel`).
