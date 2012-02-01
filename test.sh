#!/bin/sh

pwd=$(cd $(dirname $0) && pwd)
export PATH="$pwd/../.inst/usr/bin:$PATH"

INC=$(perl -e 'print join qq(:), @INC')
LIB=$(cd $pwd/../.inst/usr/lib/perl5/vendor_perl/5*/ && pwd)
export PERL5LIB="$LIB:$INC"

ROOT=/tmp/pristine-tar

rm -rf $ROOT
mkdir -p $ROOT/git $ROOT/package-1.1 $ROOT/package-1.2

cp $(ls | tail -n 4) $ROOT/package-1.1
cp *  $ROOT/package-1.2

set -e

which pristine-tar

cd $ROOT

tar --gzip -cf package-1.1.tar.gz package-1.1
tar --gzip -cf package-1.2.tar.gz package-1.2

tar --bzip2 -cf packagebz-1.1.tar.bz2 package-1.1
tar --bzip2 -cf packagebz-1.2.tar.bz2 package-1.2

tar --xz -cf packagexz-1.1.tar.xz package-1.1
tar --xz -cf packagexz-1.2.tar.xz package-1.2

ls -la

cd $ROOT/package-1.1

git init
git symbolic-ref HEAD refs/heads/upstream
git add .
git commit -m "Import release 1.1"
git tag upstream/1.1

cp ../package-1.2/* .
git add -A
git commit -m "Import release 1.2"
git tag upstream/1.2

pristine-tar commit ../package-1.1.tar.gz
pristine-tar commit ../package-1.2.tar.gz

pristine-tar commit ../packagebz-1.1.tar.bz2
pristine-tar commit ../packagebz-1.2.tar.bz2

pristine-tar commit ../packagexz-1.1.tar.xz
pristine-tar commit ../packagexz-1.2.tar.xz

git checkout pristine-tar
ls -l

rm ../package-*.tar.*

pristine-tar checkout ../package-1.1.tar.gz
pristine-tar checkout ../package-1.2.tar.gz

pristine-tar checkout ../packagebz-1.1.tar.bz2
pristine-tar checkout ../packagebz-1.2.tar.bz2

pristine-tar checkout ../packagexz-1.1.tar.xz
pristine-tar checkout ../packagexz-1.2.tar.xz

cd ..
ls -la


# End of file
