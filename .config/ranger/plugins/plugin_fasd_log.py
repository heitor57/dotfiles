import ranger.api
import ranger.core.fm
try: from shlex import quote
except ImportError: from pipes import quote

old_hook_init = ranger.api.hook_init

def hook_init(fm:ranger.core.fm.FM):
    def fasd_add():
        fm.execute_console("shell fasd --add " + quote(fm.thisfile.path))
    fm.signal_bind('execute.before', fasd_add)
    # def fasd_add_dir():
        # fm.execute_console("shell fasd --add " + quote(fm.thisdir.path))
    # fm.signal_bind('cd', fasd_add_dir)
    return old_hook_init(fm)

ranger.api.hook_init = hook_init
    # fm.signal_bind('cd', fasd_add)
