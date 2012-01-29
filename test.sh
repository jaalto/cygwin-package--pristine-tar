#!/bin/sh

pwd=$(cd $(dirname $0) && pwd)
PATH="$pwd/../.inst/usr/bin:$PATH"

INC=$(perl -e 'print join qq(:), @INC')
LIB=$(cd $pwd/../.inst/usr/lib/perl5/vendor_perl/5*/ && pwd)
PERL5LIB="$LIB:$INC"

ROOT=/tmp/pristine-tar

rm -rf $ROOT
mkdir -p $ROOT/git $ROOT/package-1.1 $ROOT/package-1.2

cp $(ls | grep -v sh) $ROOT/package-1.1
cp *  $ROOT/package-1.2

set -e

which pristine-tar

cd $ROOT
tar -zcvf package-1.1.tar.gz package-1.1
tar -zcvf package-1.2.tar.gz package-1.2

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
git checkout pristine-tar
ls -l

rm ../package-*.tar.gz
git checkout -b master

pristine-tar checkout package-1.1.tar.gz
pristine-tar checkout package-1.2.tar.gz
cd ..
ls -la


# End of file
