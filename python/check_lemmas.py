import argparse
import unicodedata
from pathlib import Path
from lxml import etree
def fix_hebrew_lemma(lemma):
    """Fix a Hebrew lemma by removing invalid characters."""
    # Keep only valid Hebrew characters
    fixed = ''.join(ch for ch in lemma if is_valid_hebrew_char(ch))
    return fixed

def validate_and_fix_lemmas_in_file(xml_path, fix=False):
    tree = etree.parse(str(xml_path))
    invalid_lemmas = []
    modified = False

    for elem in tree.xpath('//*[@lemma]'):
        lemma = elem.attrib['lemma']
        is_valid, invalid_chars = is_valid_hebrew_lemma(lemma)
        if not is_valid:
            invalid_lemmas.append((xml_path.name, lemma, invalid_chars))
            if fix:
                fixed_lemma = fix_hebrew_lemma(lemma)
                elem.attrib['lemma'] = fixed_lemma
                modified = True

    if fix and modified:
        tree.write(str(xml_path), encoding='utf-8', xml_declaration=True)

    return invalid_lemmas

def is_valid_hebrew_char(ch):
    code = ord(ch)
    return (
        (0x05D0 <= code <= 0x05EA) or  # Hebrew letters א - ת
        code in {
            0x05B0, 0x05B1, 0x05B2, 0x05B3, 0x05B4,  # Sheva to Hiriq
            0x05B5, 0x05B6, 0x05B7, 0x05B8, 0x05B9,  # Tsere to Holam
            0x05BB,              # Qubuts
            0x05BC,              # Dagesh or Mapiq
            0x05C1, 0x05C2,      # Shin and Sin dots
            0x05C7,              # Qamats Qatan
            0x05BA,              # Holam Haser for Vav (optional, used in some lexica)
            0x05BF               # Rafe (optional in older texts)
        } or
        ch == ' ' or            # Space for compound lemmas
        ch == '\u05BE'          # Maqaf (Hebrew hyphen) - do not allow ASCII hyphen
    )


def is_valid_hebrew_lemma(lemma):
    # Find invalid characters with their details
    invalid_chars = []
    for ch in lemma:
        if not is_valid_hebrew_char(ch):
            invalid_chars.append((ch, f"U+{ord(ch):04X}", unicodedata.name(ch, "Unknown")))

    # Return validity status plus invalid character details for reporting
    return not bool(invalid_chars), invalid_chars if invalid_chars else []

def validate_lemmas_in_file(xml_path):
    tree = etree.parse(str(xml_path))
    invalid_lemmas = []

    for elem in tree.xpath('//*[@lemma]'):
        lemma = elem.attrib['lemma']
        is_valid, invalid_chars = is_valid_hebrew_lemma(lemma)
        if not is_valid:
            invalid_lemmas.append((xml_path.name, lemma, invalid_chars))

    return invalid_lemmas


def validate_and_fix_lemmas_in_file(xml_path, fix=False):
    # Use parser that preserves whitespace
    parser = etree.XMLParser(remove_blank_text=False)
    tree = etree.parse(str(xml_path), parser)
    invalid_lemmas = []
    modified = False

    for elem in tree.xpath('//*[@lemma]'):
        lemma = elem.attrib['lemma']
        is_valid, invalid_chars = is_valid_hebrew_lemma(lemma)
        if not is_valid:
            invalid_lemmas.append((xml_path.name, lemma, invalid_chars))
            if fix:
                fixed_lemma = fix_hebrew_lemma(lemma)
                elem.attrib['lemma'] = fixed_lemma
                modified = True

    if fix and modified:
        # Use method that preserves formatting
        with open(xml_path, 'wb') as f:
            f.write(etree.tostring(tree, encoding='utf-8', xml_declaration=True,
                                    pretty_print=False))

    return invalid_lemmas


def main(folder_path):
    folder = Path(folder_path)
    xml_files = list(folder.glob('**/*.xml'))
    all_invalid = []

    for xml_file in xml_files:
        if args.fix:
            invalid_lemmas = validate_and_fix_lemmas_in_file(xml_file, fix=True)
        else:
            invalid_lemmas = validate_lemmas_in_file(xml_file)
        all_invalid.extend(invalid_lemmas)

    if all_invalid:
        print("Invalid lemmas found:")
        for file_name, lemma, invalid_chars in all_invalid:
            print(f"{file_name}: {lemma}")
            for ch, code, name in invalid_chars:
                print(f"  Invalid character: '{ch}' ({code}, {name})")

    print(f"Invalid characters found in {len(all_invalid)} lemmas in {len(xml_files)} files.")

    # Create a table of unique invalid characters
    if all_invalid:
        unique_chars = {}
        for _, _, invalid_chars in all_invalid:
            for ch, code, name in invalid_chars:
                if ch not in unique_chars:
                    unique_chars[ch] = (code, name)

        print("\nTable of Invalid Characters:")
        print("-" * 60)
        print(f"{'Character':<10} {'Unicode':<10} {'Name':<40}")
        print("-" * 60)
        for ch, (code, name) in unique_chars.items():
            print(f"{ch:<10} {code:<10} {name:<40}")
        print("-" * 60)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Check XML files for lemmas with forbidden characters.")
    parser.add_argument("folder", help="Folder containing XML files")
    parser.add_argument("--fix", action="store_true", default=False, help="Fix invalid lemmas in XML files")
    args = parser.parse_args()
    main(args.folder)
