# ----------------------------------------------------------------------
# MacPorts
# ----------------------------------------------------------------------

PATH="/opt/local/bin:/opt/local/sbin:$PATH"

# ----------------------------------------------------------------------
# coreutils
# ----------------------------------------------------------------------

# The tools provided by GNU coreutils are prefixed with the character 'g' by default to distinguish them from the BSD commands.
# For example, cp becomes gcp and ls becomes gls.

# If you want to use the GNU tools by default, add this directory to the front of your PATH environment variable:
#     /opt/local/libexec/gnubin/