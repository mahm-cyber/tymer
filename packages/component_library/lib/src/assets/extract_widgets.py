import re
import os


def camel_to_snake(name):
    """
    Convert CamelCase to snake_case.
    """
    # Replace camel case with snake case
    return re.sub(r'(?<!^)(?=[A-Z])', '_', name).lower()


# Get the directory of the current script
script_dir = os.path.dirname(os.path.abspath(__file__))

# Define the path to the Dart file
dart_file_path = os.path.join(script_dir, 'src/svg_asset.dart')

# Read the Dart file
with open(dart_file_path, 'r') as file:
    dart_content = file.read()

# Regex to match Dart widget class definitions, including nested braces
widget_regex = r'class (\w+) extends StatelessWidget \{[^{}]*(?:\{[^{}]*\}[^{}]*)*\}'

# Find all widget class definitions
matches = re.finditer(widget_regex, dart_content, re.DOTALL)

# Extract each widget class and write to a new Dart file
widgets = []
for match in matches:
    widget_class = match.group(0)
    widget_name = re.search(r'class (\w+)', widget_class).group(1)
    widgets.append((widget_name, widget_class))

# Create a directory for the extracted widgets if it doesn't exist
output_dir = os.path.join(script_dir, 'src/extracted_widgets')
if not os.path.exists(output_dir):
    os.makedirs(output_dir)

# Remove each widget from the original content and save to new files
for widget_name, widget_class in widgets:
    try:
        # Write the widget class to a new Dart file
        camel_case_name = camel_to_snake(widget_name)
        widget_file_path = os.path.join(output_dir, f'{camel_case_name}.dart')
        with open(widget_file_path, 'w') as widget_file:
            widget_file.write(f"import 'package:component_library/component_library.dart';\n")
            widget_file.write(f"import 'package:flutter/material.dart';\n")
            widget_file.write(f"import 'package:flutter_svg/flutter_svg.dart';\n\n")
            widget_file.write(widget_class)

        # Remove the widget class from the original Dart content
        dart_content = dart_content.replace(widget_class, '')
    except Exception as e:
        print(f"An error occurred while processing widget: {widget_name}\nError: {e}")

# Write the modified Dart content back to the original file
with open(dart_file_path, 'w') as file:
    file.write(dart_content)

print('Widgets have been extracted and saved to individual files.')
