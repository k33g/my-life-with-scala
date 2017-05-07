#!/usr/bin/env bash
# goal: create a scala project structure (with ENSIME)
# use: newscala.sh my-awesome-project
# ⚠️ first time: chmod +x newscala.sh

mkdir $1
cd $1
mkdir -p src/{main,test}/{java,resources,scala}
mkdir lib project target
cat > build.sbt << EOF
name := "$1"

version := "1.0"

scalaVersion := "2.12.2"
EOF

sbt ensimeConfig
