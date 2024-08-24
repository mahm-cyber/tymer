import os


def read_strings_from_file(file_path):
    with open(file_path, 'r', encoding='utf-8') as file:
        return [line.strip() for line in file.readlines()]


def replace_strings_in_file(file_path, replacements):
    with open(file_path, 'r', encoding='utf-8') as file:
        content = file.read()

    for old_string, new_string in replacements:
        content = content.replace(old_string, new_string)

    with open(file_path, 'w', encoding='utf-8') as file:
        file.write(content)


def replace_strings_in_dart_files(directory, replacements):
    for root, _, files in os.walk(directory):
        for file in files:
            if file.endswith(".dart"):
                file_path = os.path.join(root, file)
                replace_strings_in_file(file_path, replacements)
                print(f"Replaced in: {file_path}")


if __name__ == "__main__":
    project_directory = "."

    old_strings_file = "old_strings.txt"  # File containing old strings
    new_strings_file = "new_strings.txt"  # File containing new strings

    old_strings = read_strings_from_file(old_strings_file)
    new_strings = read_strings_from_file(new_strings_file)

    if len(old_strings) != len(new_strings):
        print("Error: The number of old strings and new strings must be the same.")
    else:
        replacements = list(zip(old_strings, new_strings))
        replace_strings_in_dart_files(project_directory, replacements)
        print("String replacements complete.")
