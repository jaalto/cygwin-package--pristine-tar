#!/bin/sh
# This file has been automatically generated by cygbuild
#
# Please do not remove section comments '#:<name>'

set -e

PATH=/bin:/sbin:/usr/bin:/usr/sbin
LC_ALL=C

dest=$1


#:Perl
from='/usr/share/perl/cygwin-pods/pristine-tar.pod'
to='/usr/lib/perl5/5.10/i686-cygwin/perllocal.pod'
grep -Eq 'EXE_FILES:[[:space:]]+pristine-tar' $to || cat "$from" >> "$to"