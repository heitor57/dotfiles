# keybinding/keybinding.py
class Keybinding:
    def replacements(self):
        def _custom_match(variable):
            if variable == 'TEST':
                return ['pass']
        def _custom_replace(task, arg):
            return 'TEST:%s' % arg
        return [
            {
                'match_callback': _custom_match,
                'replacement_callback': _custom_replace,
            },
        ]
