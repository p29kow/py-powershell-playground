from argparse import ArgumentParser, ArgumentTypeError
import os


CMDLET_DICT = {
        "ev-l": "scripts/event-logger.ps1",
        "f-ext-l": "scripts/file-ext-locator.ps1"
    }

def validate_path(path):
    if not os.path.exists(path):
        raise ArgumentTypeError("Path not found")
    if os.access(path, os.R_OK):
        return path
    else:
        raise ArgumentTypeError("Path is not readable")
    

def get_cmdlet_path(key):
    try:
        return CMDLET_DICT[key]
    except:
        raise KeyError("Key not found")
    
    
def parse_args(title, *args):
    parser = ArgumentParser(title)
    # for arg_dict in args:
    #     parser.add_argument(arg_dict.short, arg_dict.long, required=arg_dict.required)
    for i in range(len(args)):
        print(args[i][0], args[i][1])
    parsed_args = parser.parse_args()
